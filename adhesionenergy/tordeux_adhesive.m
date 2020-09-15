function [ wl,Dwl ] = tordeux_adhesive( rv,avg,dev,disc )
%Jaime Agudo, 4-4-14

%Given a data rv,avg,dev,disc of adhering vesicles, calculates the adhesive
%strength according to eqs. (31) of "Analytical characterization of
%adhering vesicles", C. Tordeux and J.-B. Fournier (2008)
%Outputs:
%wl is the adhesive energy W/kappa in units of microm^(-2)
%Dwl is its absolute error
%volt is the corresponding vector containing the voltages

%_%%%%%% If no gravity, set G=0, if gravity, set G~=0
%_%%%%%% Bending rigidity value only relevant if G~=0
G=0; %G=g*ro_m/(k_B T) [length^(-4)] (microm^(-4))  reduced gravitational constant
k=19;  %bending rigidity in kbT units
Dk=1;  %error in bending rigidity
%_%%%%%%
    
A=avg(1);
DA=dev(1);

v=avg(3);
Dv=dev(3);

L=sqrt(disc/pi);
DL=0.5*disc*dev(1)/avg(1)/sqrt(pi*disc);

[t,flag]=angle_volume( v,pi/2 );
dtdv=2*(2-cos(t)+sin(t)^2)^(3/2)/(9*sin(t)-3*sin(3*t)-3*v*sin(t)*(2-cos(t)+sin(t)^2)^(1/2)*(1+2*cos(t)));

%volt(i)=data.(char(names(i))).volt;
%end

l0=sqrt((1+cos(t))./(pi*(3+cos(t))));
dl0dt=-sin(t)./(sqrt(pi)*(1+cos(t)).^(1/2).*(3+cos(t)).^(3/2));

l1=-sqrt(2)*cos(t/2)./(1+sin(t/2));
dl1dt=1./(sqrt(2)*(1+sin(t/2)));

wl=l1.^2./(L./sqrt(A)-l0).^2./A;
dwdL=-l1.^2./(L-l0.*sqrt(A)).^3;
dwdA=l1.^2.*l0./(2*(L-l0.*sqrt(A)).^3.*sqrt(A));
dwdv=(dl1dt.*(L-l0.*sqrt(A)) + l1.*sqrt(A).*dl0dt)./(L-l0.*sqrt(A)).^3 *2.*l1.*dtdv;
Dwl=sqrt((dwdL.*DL).^2+(dwdA.*DA).^2+(dwdv.*Dv).^2);

%Gravity effects
if G~=0
wl=wl-G*A/(6*pi*k);
dwdA=dwdA-G/(6*pi*k);
dwdk=G*A/(6*pi*k^2);
Dwl=sqrt((dwdL.*DL).^2+(dwdA.*DA).^2+(dwdv.*Dv).^2+(dwdk.*Dk).^2);
end



%h0=sqrt((1-cos(t))./(pi*(3+cos(t))));
%h1=-2*sqrt(2)*(1-sin(t/2));

%wh=h1.^2./(H./sqrt(A)-h0).^2./A;
%wh=wh.*A;


end

