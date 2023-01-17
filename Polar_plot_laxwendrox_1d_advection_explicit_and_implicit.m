format long;
theta = 0:0.01:2*pi;
theta_half=0:0.01:pi;

% G Ratios

%1) G Explicit
leg={};
iter =1;
for c=0.2:0.2:1.5
    polarplot(theta,explicit(c,theta));
    leg{iter} = strcat('CFL=',num2str(c));
    iter=iter+1;
    hold on;
end
title('Explicit Scheme');
hold off;
legend(leg);

%formatting

pax=gca;
pax.ThetaAxisUnits='radians';
set(gca,'fontsize',12,'fontweight','b');

%2) G Implicit

leg={};
iter=1;
figure(2);
for c=0.2:0.2:50
    polarplot(theta,implicit(c,theta));
    leg{iter} = strcat('CFL=',num2str(c));
    iter=iter+1;
    hold on;
end
title('Implicit Scheme');
hold off;
legend(leg);


%formatting

pax=gca;
pax.ThetaAxisUnits='radians';
set(gca,'fontsize',12,'fontweight','b');


%Phi Ratios

%1) Phi Ratio - Explicit

leg={};
iter=1;
figure(3);
for c=0.2:0.4:2
    polarplot(theta_half,phi_explicit(c,theta_half));
    leg{iter} = strcat('CFL=',num2str(c));
    iter=iter+1;
    hold on;
end
title('Explicit Scheme - Phase angle Ratio ');
hold off;
legend(leg);

%formatting

pax=gca;
pax.ThetaAxisUnits='radians';
set(gca,'fontsize',12,'fontweight','b');


%2) Phi Ratio - Implicit


leg={};
iter=1;
figure(4);
for c=0.2:0.2:50
    polarplot(theta_half,phi_implicit(c,theta_half));
    leg{iter} = strcat('CFL=',num2str(c));
    iter=iter+1;
    hold on;
end
title('Implicit Scheme - Phase angle Ratio ');
hold off;
legend(leg);


%formatting

pax=gca;
pax.ThetaAxisUnits='radians';
set(gca,'fontsize',12,'fontweight','b');


%functions 

function val=explicit(c,theta)
    val=sqrt((1-c^2)^2+(c^4*(cos(theta)).^2)+2*(1-c^2)*c^2*cos(theta)+c^2*(sin(theta)).^2);
end

function val=implicit(c,theta)
    val=sqrt(1./((1+c^2-(c^2*cos(theta))).^2+(c^2*(sin(theta)).^2)));
end

function val=phi_explicit(c,theta)
    val=atan((-c*sin(theta))./(1-c^2+c^2*cos(theta)))./(-theta*c);
%       temp=(-c*sin(theta))./(1-c^2+c^2*cos(theta));
%       temp=min(atan(temp),atan(-temp));
%       val=temp./(-theta*c);
end

function val=phi_implicit(c,theta)
    val=atan((-c*sin(theta))./(1-(c^2)*cos(theta)+c^2))./(-theta*c);
end