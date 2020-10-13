function [rv,avg,dev,discarea] = getRV(rawdata,res)
    % Takes the middle of the adhesion disk as center of rotationalsymetry
    xbase = rawdata(1,1) + (rawdata(2,1)-rawdata(1,1))/2;
    data(:,1) = rawdata(3:end,1) - xbase;
    data(:,2) = rawdata(3:end,2);

    % sort data according to center
    r = find(data(:,1)>0);
    l = find(data(:,1)<0);
    rd=data(r(1:end-1),:);
    ld=data(l(1:end-1),:);
    [A1,V1] = numint(rd,res);
    [A2,V2] = numint(ld,res);
    rv(1) = V1 / (4*pi/3 * (A1/(4*pi))^(3/2));
    rv(2) = V2 / (4*pi/3 * (A2/(4*pi))^(3/2));
    avg(1)=mean([A1,A2]);
    avg(2)=mean([V1,V2]);
    avg(3)=mean(rv);
    dev(1)=std([A1,A2]);
    dev(2)=std([V1,V2]);
    dev(3)=std(rv);
    discarea=((rawdata(2,1)-rawdata(1,1))/(res*2))^2*pi;
end
function [A,V]=numint(data,res)
    for i=1:length(data)-1
        ri=data(i,1);
        ri_1=data(i+1,1);
        zi=data(i,2);
        zi_1=data(i+1,2);
        a(i) = (pi*(ri+ri_1)*sqrt((ri_1-ri)^2+(zi_1-zi)^2));
        v(i) = (pi/3*(zi_1-zi)*(ri^2+ri*ri_1+ri_1^2));
    end
    A=abs((sum(a)))/res^2;
    V=abs((sum(v)))/res^3;
end
