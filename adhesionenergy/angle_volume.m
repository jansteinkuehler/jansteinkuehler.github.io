function [ t,flag ] = angle_volume( v,t0 )
%Jaime Agudo, 4-4-14

%For given reduced volume and trial contact angle, calculates the strong
%adhesion contact angle of a droplet

%opt=optimoptions('fsolve','Display','off');
opt=optimset('Display','off');

[t,~,flag] = fsolve(@problem,t0,opt);

function [ F ] = problem(t)
    
    F= v*2*(2-2*cos(t)+sin(t)^2)^(3/2)-8+9*cos(t)-cos(3*t);
    
end

end

