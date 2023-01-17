clear;

Lmin=-1;
Lmax=1;
N=200;    % No of grid points in space    
Delta_x=(Lmax-Lmin)/N;
Tx=[Lmin:Delta_x:Lmax];
CFL=0.8;
Delta_t=CFL*Delta_x;
T0=0;
Tf=4; %Final Time
M=Tf/Delta_t; % No. of grid points in time
%Delta_t=(Tf-T0)/m
Tp=[T0:Delta_t:Tf];

for i=1:N+1
    if Tx(i)>-1/3

   % a=Tx(i)-Delta_x
a=Tx(i)
   break
    end
end

for i=1:N+1
    if Tx(i)>1/3
        b=Tx(i)
        break
    end
end

u0=zeros(length(Tp),N+1);
for i=1:N+1  %space loop
    if Tx(i)<a
        %u0(i)=0;
     u0(1,i)=0;
    elseif Tx(i)>b
        %u0(i)=0
        u0(1,i)=0;
    else
      %  u0(i)=1-3*abs(Tx(i))
       %u0(i)=1
       u0(1,i)=1;
    end
end
length(Tx);
u0
plot(Tx,u0,'--or');
