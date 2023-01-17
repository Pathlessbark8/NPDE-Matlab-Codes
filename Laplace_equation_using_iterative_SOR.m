format long;


%Initial Conditions
a=0;
b=2;
no_of_grid_points=50;
delx=(b-a)/(no_of_grid_points-1);
dely=delx;
tol=1e-3;
xcoord=a+(0:no_of_grid_points-1)*delx;
ycoord=a+(0:no_of_grid_points-1)*dely;
omega=1.5;
A=zeros((no_of_grid_points-2)^2);
X=ones((no_of_grid_points-2)^2,1);
n=(no_of_grid_points-2)^2;


%Calculating the coefficients matrix
for i=1:no_of_grid_points-2
    for j=1:no_of_grid_points-2
        k = get_index(i,j,no_of_grid_points-1);
        A(k,k) = -4;
        if(i - 1 ~= 0) 
            k_new = get_index(i-1,j,no_of_grid_points-1);
            A(k,k_new) = 1;
        end 
        if(j - 1 ~= 0) 
            k_new = get_index(i,j-1,no_of_grid_points-1);
            A(k,k_new) = 1;
        end 
        if(i + 1 ~= no_of_grid_points-1) 
            k_new = get_index(i+1,j,no_of_grid_points-1);
            A(k,k_new) = 1;
        end 
        if(j + 1 ~= no_of_grid_points-1) 
            k_new = get_index(i,j+1,no_of_grid_points-1);
            A(k,k_new) = 1;
        end 
    end
end

%Splitting A into L,D and U
% L=tril(A,-1);
% D=diag(diag(A));
% U=triu(A,1);


%Initializing matrix B
B=zeros((no_of_grid_points-2)^2,1);
val=1;
for i=2:no_of_grid_points-1
    for j=2:no_of_grid_points-1
        x=a+delx*(i-1);
        y=a+dely*(i-1);
        if(i==2)
            if(j==2)
                B(val)=-((x^2)/2);
            elseif(j==no_of_grid_points-1)
                B(val)=-2-y-((x^2)/2);
            else
                B(val)=-((x^2)/2);
            end
        elseif(i==no_of_grid_points-1)
            if(j==2)
                B(val)=-(x^2);
            elseif(j==no_of_grid_points-1)
                B(val)=-2-y-(x^2);
            else
                B(val)=-(x^2);
            end
       elseif(j==2)
            if(i==2)
                B(val)=0;
            elseif(i==no_of_grid_points-1)
                B(val)=-2-y-((x^2)/2);
            else
                B(val)=0;
            end
       elseif(j==no_of_grid_points-1)
            if(i==2)
                B(val)=-(x^2);
            elseif(i==no_of_grid_points-1)
                B(val)=-2-y-(x^2);
            else
                B(val)=-2-y;
            end
        end
        val=val+1;
    end
end


%SOR Method for calculating the solution
Error=[];
currError=1;
val=1;
while(currError > tol && val<50) 
    for i= 1:(no_of_grid_points-2)^2
        err = 0.0;
        for j = 1:(no_of_grid_points-2)^2
            if (j ~= i)  
                err = err+A(i, j) * X(j);
            end 
        end 
        X(i) = (1 - omega) * X(i) + (omega / A(i, i)) * (B(i) - err);  
    end 
    currError=vecnorm((A*X) - B,2);
    Error= [Error,currError];
    val = val+1;
end  


% XN=X;
%  while(val<=50 && currError>tol) 
%    err = 0;
%    for i = 1 : (no_of_grid_points-2)^2
%       s = 0;
%       for j = 1 : (no_of_grid_points-2)^2
%         s = s-A(i,j)*X(j);
%       end
% %       k=get_index(i,j,no_of_grid_points-1);
%       s = Omega*(s+B(i)/A(i,i));
%       if abs(s) > err 
%          err = err+(s)^2;
%       end
%       X(i) = X(i)+s;
%    end
%    currError=sqrt(err);
%    X=XN;
%    if err <= tol  
%       break;
%    else
%       val = val+1;
%    end
%  end
% while(currError>tol && val<50)
%     XN=(((L+(D/Omega))^-1)*((D/Omega)-D-U))*X+((L+(D/Omega))^-1)*B;
%     currError=vecnorm(XN-X,2);
%     Error=[Error,currError];
%     X=XN;
%     val=val+1;
% end



%Calculating and plotting residue
Residue=[];
for i=1:length(Error)
    Residue=[Residue,log(Error(i)/Error(1))];
end
plot(Residue);
title('Residue vs Iterations Plot');    
xlabel('Iteration');
ylabel('Residue Value');




%Allocating solution to vector U to plot
V=reshape(X,(no_of_grid_points-2),(no_of_grid_points-2));
U=zeros((no_of_grid_points));


    %Setting boundary points for plotting
    for i=1:no_of_grid_points
        x=a+delx*(i-1);
        y=a+dely*(i-1);
        U(1,i)=x^2/2;
        U(no_of_grid_points,i)=x^2;
        U(i,1)=0;
        U(i,no_of_grid_points)=2+y;
    end


    %Allocating calculated values to U
    val=1;
    for i=2:no_of_grid_points-1
        U(i,2:no_of_grid_points-1)=V(val,:);
        val=val+1;
    end



%Plotting
[M,N]=meshgrid(xcoord,ycoord);
figure(2);
surf(M,N,U);
title('3D view of obtained solution');
xlabel('x-axis');
ylabel('y-axis');


%Function to retrive matrix index 
function val=get_index(i,j,n)
    val=((i-1)*(n-1)+(j-1))+1;
end



% disp(A);
% disp(L+D);
% disp(D);
% disp(D/Omega);
% disp((D/Omega)^-1);
% disp(L+(D/Omega));
% disp(((L+(D/Omega))^-1));
% disp(((D/Omega)-D-U));
% disp(((L+(D/Omega))^-1) *((D/Omega)-D-U));
% disp(norm( ((L+(D/Omega))^-1) *((D/Omega)-D-U)));