P = [0, 0; 1, 3; 2, -1; 3, 4; 4, 4; 4, 6; 5, 0; 5, -2; 6, 0];
T = [0, 0; 0, 0; 0, 0; 0, 1; 0, 1; 0, 1; 1, 0; 1, 0; 1, 0];

w = [0, 0; 0, 0];%initialize w
b = [0; 0];%initialize b

input_num = size(P,1);
i = 0;
count = 1;%for count
while (true)
  index = mod(i, input_num) + 1;%repeat
  i = i + 1;

  if (index == 1)
    count = 0;
  end

  p = P(index, :)';
  t = T(index, :)';
  a = hardlim(w * p + b);%calculate

  if not(isequal(a, t))
    e = t - a;
    w = w + e * p';%w=w+(t-a)*p'
    b = b + e;%b=b+e
  else
    count = count + 1;%if right, count++
  end
  
  if count == input_num%if count=input_num,end
     break;
  end
end

figure;
plot(P(1:3, 1)', P(1:3, 2)', '+'); hold on;%class1 plot
plot(P(4:6, 1)', P(4:6, 2)', 'o'); hold on;%class2 plot
plot(P(7:9, 1)', P(7:9, 2)', '*'); hold on;%class3 plot

axis([-20 20 -20 20]);
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
    fprintf(fid,'%f ',w(k1,k2));
end
fprintf(fid,'\n');
end
fclose(fid);