format long;
i=2^100;
x=i;
while true
    if(mod(x,2)==0)
        x=x/2;
    elseif(x~=1) 
        x=3*x+1;
    else
        disp(i);
        i=i+1;
        x=i;
    end
end