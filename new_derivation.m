format long;
theta = 0:0.01:2*pi;
theta_half=0:0.01:pi;

% G Ratios

%1) G Explicit
leg={};
iter =1;
t=[];
for c=1:1
    t=explicit(c,theta);
    polarplot(theta,t);
    leg{iter} = strcat('CFL=',num2str(c));
    iter=iter+1;
%     hold on;
end
title('Explicit Scheme');
hold off;
legend(leg);

%formatting

pax=gca;
pax.ThetaAxisUnits='radians';
set(gca,'fontsize',12,'fontweight','b');

% function val=explicit(c,theta)
% %     val=1./(1-(c.*sin(theta))+(c^2.*(cos(theta)))-c^2);
%     val=1./(cos(theta));
% end

function val=explicit(c,theta)
    val=sqrt((1-c^2)^2+(c^4*(cos(theta)).^2)+2*(1-c^2)*c^2*cos(theta)+c^2*(sin(theta)).^2);
end