format long;

x = linspace(-50,50,101);
y = linspace(0,50,101);
u1=[];
% for i=1:length(x)
%     for j=1:length(x)
%         u1(i,j)=0.5*(f(x(i)+y(j))+f(x(i)-y(j)));
%     end
% end

% figure(1);
% surf(x,y,u1);

u2=[];
for i=1:length(x)
    for j=1:length(x)
        if(y(j)<0)
            u2(i,j)=0;
        else
            u2(i,j)=integrate(x(i)-y(j),x(i)+y(j));
        end
    end
end

surf(x,y,u2);

function val=f(x)
    a=19;
    if (x>=-a && x<-a/2)
        val=a;
    elseif (x>=-a/2 && x<=a/2)
        val=a/2;
    elseif(x>a/2 && x<=a)
        val=a;
    else
        val=0;
    end
end

function val=integrate(c1,c2)
    a=19;
    val=0;
    while(true)
        if(c1<-a)
            if(c2<=-a)
                break;
            end
            c1=-a;
        elseif(c1>=-a && c1<-a/2)
            if(c2>=-a/2)
                val=val+a*(((-a)/2)-c1);
                c1=-a/2;
            else
                val=val+a*(c2-c1);
                break;
            end
        elseif(c1>=(-a/2) && c1<(a/2))
            if(c2>=a/2)
                val=val+(a/2)*(a/2-c1);
                c1=a/2;
            else
                val=val+(a/2)*(c2-c1);
                break;
            end
        elseif(c1>=a/2 && c1<a)
            if(c2>=a)
                val=val+(a-c1)*a;
                c1=a;
            else
                val=val+a*(c2-c1);
                break;
            end
        else
            break;
        end
    end
    
end