format long;

%Set Initial Conditions
u_Nplus1_FTBS=[];
u_Nplus1_FTCS=[];
u_Nplus1_Lax=[];
noOfGridPoints=500;
gridPoints=linspace(-1,1,noOfGridPoints);
u_N_FTBS=[];
u_N_FTCS=[];
u_N_Lax=[];
u_x=[];
cfl=0.5;
del_t=cfl*2/noOfGridPoints;
time=2;



%Initialize at t=0
for i=1:noOfGridPoints
    u_N_FTBS=[u_N_FTBS,u(gridPoints(i))];
    u_N_FTCS=[u_N_FTCS,u(gridPoints(i))];
    u_N_Lax =[u_N_Lax,u(gridPoints(i))];
    u_x =[u_x,u(gridPoints(i))];
end


%Run the iterations to find value at t=4

%FTBS
for i=2:del_t:time
    disp(i);
    u_Nplus1_FTBS=cal_FTBS(u_N_FTBS,cfl);
    u_N_FTBS=u_Nplus1_FTBS;
end

figure(1);
plot(gridPoints,u_Nplus1_FTBS);
hold on;
plot(gridPoints,u_x);
hold off;
leg={'FTBS','Exact'};
legend(leg);
tle=strcat('Linear Advection-FTBS with CFL = ',num2str(cfl));
tle=strcat(tle,' and time =');
title(strcat(tle,num2str(time)));


for i=1:noOfGridPoints
    err_vec(i)=abs(u_Nplus1_FTBS(i)-u_x(i));
end
err=sum(err_vec,'all')/length(err_vec);
disp("Average Error in FTBS is "+err);





%FTCS
for i=2:del_t:time
    u_Nplus1_FTCS=cal_FTCS(u_N_FTCS,cfl);
    u_N_FTCS=u_Nplus1_FTCS;
end

figure(2);
plot(gridPoints,u_Nplus1_FTCS);
hold on;
plot(gridPoints,u_x);
hold off;
leg={'FTCS','Exact'};
legend(leg);
tle=strcat('Linear Advection-FTCS with CFL = ',num2str(cfl));
tle=strcat(tle,' and time =');
title(strcat(tle,num2str(time)));

for i=1:noOfGridPoints
    err_vec(i)=abs(u_Nplus1_FTCS(i)-u_x(i));
end
err=sum(err_vec,'all')/length(err_vec);
disp("Average Error in FTCS is "+err);




%Lax-Wendroff
for i=2:time
    u_Nplus1_Lax=cal_Lax(u_N_Lax,cfl);
    u_N_Lax=u_Nplus1_Lax;
end

figure(3);
plot(gridPoints,u_Nplus1_Lax);
hold on;
plot(gridPoints,u_x);
hold off;
leg={'Lax','Exact'};
legend(leg);
tle=strcat('Linear Advection-Lax with CFL = ',num2str(cfl));
tle=strcat(tle,' and time =');
title(strcat(tle,num2str(time)));

for i=1:noOfGridPoints
    err_vec(i)=abs(u_Nplus1_Lax(i)-u_x(i));
end
err=sum(err_vec,'all')/length(err_vec);
disp("Average Error in Lax is "+err);



%functions 
%1) u(x)
function val=u(x)
    if 0<=x && x<=1/3
        val=1-3*x;
    elseif -1/3<=x && x<0
        val =1+3*x;
    else 
        val =0;
    end
end


%2) FTBS
function val=cal_FTBS(u_I_N,c)
    val=[];
    for k =1:length(u_I_N)
       if k==1
           val=[val,0];
       else
           val=[val,u_I_N(k)-c*(u_I_N(k)-u_I_N(k-1))];
       end
    end
end


%3) FTCS
function val=cal_FTCS(u_I_N,c)
    val=[];
    for k =1:length(u_I_N)
       if k==1
           val=[val,0];
       elseif k==length(u_I_N)
           val=[val,0];
       else
           val=[val,u_I_N(k)-(c/2)*(u_I_N(k+1)-u_I_N(k-1))];
       end
    end
end


%4)Lax-Wendroff
function val=cal_Lax(u_I_N,c)
    val=[];
    for k =1:length(u_I_N)
       if k==1
           val=[val,0];
       elseif k==length(u_I_N)
           val=[val,0];
       else
           val=[val,u_I_N(k)-(c/2)*(u_I_N(k+1)-u_I_N(k-1))+((c^2)/2)*(u_I_N(k+1)-(2*u_I_N(k))+u_I_N(k-1))];
       end
    end
end