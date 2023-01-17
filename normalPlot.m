x = [];
y = [];
z = [];
n_x = [];
n_y = [];
n_z = [];
ind={100001,100002,100500};
for i= 00001:1:800000
% for k= 1:length(ind);
%     i=ind{k};
    if ((partGrid1000000.status(i) == 1) || (partGrid1000000.status(i) == 3 && mod(i-1,100000)<=500))
            x(end+1) = partGrid1000000.x(i);
            y(end+1) = partGrid1000000.y(i);
            z(end+1) = partGrid1000000.z(i);
            n_x(end+1) = partGrid1000000.nor1(i);
            n_y(end+1) = partGrid1000000.nor2(i);
            n_z(end+1) = partGrid1000000.nor3(i);
    end
end


% for i= 800001:1:1000000
%     if ((partGrid1000000.status(i) == 1 && mod(i-1,100000)<=10) || (partGrid1000000.status(i) == 3 && mod(i-1,100000)<=10))
%             x(end+1) = partGrid1000000.x(i);
%             y(end+1) = partGrid1000000.y(i);
%             z(end+1) = partGrid1000000.z(i);
%             n_x(end+1) = partGrid1000000.tan11(i);
%             n_y(end+1) = partGrid1000000.tan12(i);
%             n_z(end+1) = partGrid1000000.tan13(i);
%     end
% end

% for i= 00001:1:1000000
%     if ((partGrid1000000.status(i) == 1 && mod(i-1,100000)<=10) || (partGrid1000000.status(i) == 3 && mod(i-1,100000)<=10))
%         disp(i);
%         disp(mod(i-1,100000));
%             x(end+1) = partGrid1000000.x(i);
%             y(end+1) = partGrid1000000.y(i);
%             z(end+1) = partGrid1000000.z(i);
%             n_x(end+1) = partGrid1000000.tan21(i);
%             n_y(end+1) = partGrid1000000.tan22(i);
%             n_z(end+1) = partGrid1000000.tan23(i);
%     end
% end

h1=quiver3(x, y, z, n_x, n_y, n_z)
set(h1,'AutoScale','on', 'AutoScaleFactor', 0.5)
xlabel('X') 
ylabel('Y')
zlabel('Z')
    
