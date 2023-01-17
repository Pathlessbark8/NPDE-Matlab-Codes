format long;
x=0.01:0.01:0.07;
FD=zeros(size(x));
B=zeros(size(x));
SD=zeros(size(x));
D=zeros(size(x));
CT=zeros(size(x));
K=zeros(size(x));
Sec_der=zeros(size(x));
step_size=zeros(size(x));
E=fir(1);
F=sec(1);
m=1;
for h=1e-60:0.000009:1.784214000000   %10e-14:10e-8:10e-2                             
    FD(m)=(f(1+h)-f(1))/(h);             %0.0000001:0.000000009:0.00009 
    B(m)=h;
    FD(m)=abs(FD(m)-E);
    SD(m)=(f(1+h)-f(1-h))/(2*h);
    D(m)=h;
    SD(m)=abs(SD(m)-E);
    CT(m)=imag(f(1+((1i)*h)))/h;
    K(m)=h;
    CT(m)=abs(CT(m)-E);
    Sec_der(m)=(f(1+h)-2*f(1)+f(1-h))/(h^2);             %0.0000001:0.000000009:0.00009 
    step_size(m)=h;
    Sec_der(m)=abs(Sec_der(m)-F);
    m=m+1;
end
% m=1;
% for h=1e-60:0.00000009:5       %0.000000001:0.0000000009:0.0005                                             
%     SD(m)=(f(1+h)-f(1-h))/(2*h);
%     D(m)=h;
%     SD(m)=abs(SD(m)-E);
%     m=m+1;
% end
% m=1;
% for h=1e-60:0.00000009:5    % 2nd order h=0.000000001:0.000000000001:0.0000002   0.000000001:0.00000009:0.00009  sin(x)                               % 1st order h=0.00000000001:0.0000000009:0.000009 
%     CT(m)=imag(f(1+((1i)*h)))/h;
%     K(m)=h;
%     CT(m)=abs(CT(m)-E);
%     m=m+1;
% end
% m=1;
% for h=1e-60:0.00000009:5     % 2nd order h=0.000000001:0.000000000001:0.0000002   0.000000001:0.00000009:0.00009  sin(x)                              % 1st order h=0.00000000001:0.0000000009:0.000009 
%     Sec_der(m)=(f(1+h)-2*f(1)+f(1-h))/(h^2);             %0.0000001:0.000000009:0.00009 
%     step_size(m)=h;
%     Sec_der(m)=abs(Sec_der(m)-F);
%     m=m+1;
% end


figure(1);
plot(B,FD,'b');
legend('Forward Difference');
xlabel('Step Size'); 
ylabel('Absolute Error'); 
fprintf("Rate of Change of Error(Forward Difference) is: " +(  FD(size(FD,2))  -  FD(  size(FD,2)-1  )  )/(    B(size(B,2))-B(size(B,2)-1)    )    +"\n");


figure(2);
plot(D,SD,'g');
legend('Central Difference');
xlabel('Step Size'); 
ylabel('Absolute Error'); 
fprintf("Rate of Change of Error(Central Difference) is: " +(  SD(size(SD,2))  -  SD(  size(SD,2)-1  )  )/(    D(size(D,2))-D(size(D,2)-1)    )     +"\n");


figure(3);
plot(K,CT,'r');
legend('Complex Taylor Series');
xlabel('Step Size'); 
ylabel('Absolute Error'); 
fprintf("Rate of Change of Error(Complex Taylor Series) is: " +(  CT(size(CT,2))  -  CT(  size(CT,2)-1  )  )/(    K(size(K,2))-K(size(K,2)-1)    )     +"\n");

figure(4);
plot(step_size,Sec_der,'k');
legend('Second Derivative');
xlabel('Step Size'); 
ylabel('Absolute Error'); 
fprintf("Rate of Change of Error Second derivative is: " +(  Sec_der(size(Sec_der,2))  -  Sec_der(  size(Sec_der,2)-1  )  )/(    step_size(size(step_size,2))-step_size(size(step_size,2)-1)    )     +"\n");

function val=f(x)
        val=cos(exp(x)+log(x));
%       val=cos(log(x));
%       val=sin(x);
end

function val=fir(x)
        val=-sin(exp(x)+log(x)).*(exp(x)+1.0./x);
%       val=-sin(log(x))/x;
%       val=cos(x);
end

function val=sec(x)
        val=- cos(exp(x) + log(x))*(exp(x) + 1/x)^2 - sin(exp(x) + log(x))*(exp(x) - 1/x^2);
%       val=sin(log(x))/x^2 - cos(log(x))/x^2;
%       val=-sin(x);
end