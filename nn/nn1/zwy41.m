P = [0, 0; 1, 3; 2, -1; 3, 4; 4, 4; 4, 6; 5, 0; 5, -2; 6, 0];
T = [-1, -1; -1, -1; -1, -1; -1, 1; -1, 1; -1, 1; 1, -1; 1, -1; 1, -1];

w = [-1, -1; -1, -1];%initialize w
b = [-1; -1];%initialize b
w_new=w;
b_new=b;
input_num = size(P,1);
alpha=0.00001;
i=0;
d=0.0000000001;
while(true)
    index = mod(i, input_num) + 1;%repeat
    i = i + 1;
    p = P(index, :)';
    t = T(index, :)';
    a = w_new * p + b_new;%calculate
    e = t - a;
    w_new = w_new + 2*alpha*e * p';%w=w+(t-a)*p'
    b_new = b_new + 2*alpha*e;%b=b+e
    if index == input_num
        if max(max(w_new-w)) < d && max(max(b_new-b)) < d
            break
        else
            w=w_new;
            b=b_new;
        end
    end
end

disp(w)
disp(b)

figure;
plot(P(1:3, 1)', P(1:3, 2)', '+'); hold on;%class1 plot
plot(P(4:6, 1)', P(4:6, 2)', 'o'); hold on;%class2 plot
plot(P(7:9, 1)', P(7:9, 2)', '*'); hold on;%class3 plot

axis([-10 10 -10 10]);
x = linspace(-20, 20);
y1 = (-b(1) - w(1,1) * x) / w(1,2);%the first line
y2 = (-b(2) - w(2,1) * x) / w(2,2);%the second line
plot(x, y1, x, y2);%plot line
legend('class1','class2','class3','line1','line2');
xlabel('x');
ylabel('y');
fid=fopen('1.txt','wt');
[m,n]=size(w);
for k1=1:m
    for k2=1:n
    fprintf(fid,'%f',w(k1,k2));
end
fprintf(fid,'\n');
end
fclose(fid);

