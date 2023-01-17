format long;
x=0.1:0.01:0.00001;
A=zeros(size(x));
B=zeros(size(x));
C=der(1);
m=1;
for h=0.00000000000005:0.00000009:0.05    % 2nd order h=0.000000001:0.000000000001:0.0000002   0.000000001:0.00000009:0.00009  sin(x)                               % 1st order h=0.00000000001:0.0000000009:0.000009 
    A(m)=imag(f(1+((1i)*h)))/h;
    B(m)=h;
    A(m)=abs(A(m)-C);
    m=m+1;
end

plot(B,A,'b');

function val=f(x)
    val=sin(x);
end

function val=der(x)
    val=cos(x);
end