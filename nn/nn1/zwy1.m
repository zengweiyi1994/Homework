clear all;clc;close all
X1=[0,1,2];
Y1=[0,3,-1];
X2=[3,4,4];
Y2=[4,4,6];
X3=[5,5,6];
Y3=[0,-2,0];
plot(X1,Y1,'O');
hold on;
plot(X2,Y2,'+');
hold on;
plot(X3,Y3,'*')
x1=[0,0];
x2=[1,3];
x3=[2,-1];
x4=[3,4];
x5=[4,4];
x6=[4,6];
x7=[5,0];
x8=[5,-2];
x9=[6,0];
y11=[x1,1];
y12=[x2,1];
y13=[x3,1];
y14=[-x4,-1];
y15=[-x5,-1];
y16=[-x6,-1];
y17=[-x7,-1];
y18=[-x8,-1];
y19=[-x9,-1];
y=[y11;y12;y13;y14;y15;y16;y17;y18;y19];
w=[0;0;0];%initialize w
i=1;
k=0;
for i=1:2000
    for j=1:9
       if (y(j,:)*w<=0)
           w=w+y(j,:)';%w=w+(t-a)*p
           k=0;
       else
           k=k+1;%count
       end
       if(k==9)
           break;
       end
    end
    if(k==9)
           break;
    end
end
X=[-10:10];
Y=(-w(3)-w(1)*X)/w(2);
plot(X,Y,'linewidth',3);%plot line
k2=0;
w2=[0;0;0];%initialize w
y2=[y11;y12;y13;-y14;-y15;-y16;y17;y18;y19]
for i=1:2000
    for j=1:9
       if (y2(j,:)*w2<=0)
           w2=w2+y2(j,:)';
           k2=0;
       else
           k2=k2+1;%count
       end
       if(k2==9)
           break;
       end
    end
    if(k2==9)
           break;
    end
end
X2=[-10:10];
Y2=(-w2(3)-w2(1)*X)/w2(2);
plot(X2,Y2,'linewidth',3);%plot line
xlabel(x1);
ylabel(x2);
legend('class1','class2','class3','boundary1','boundary2');%legend
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
fid=fopen('2.txt','wt');
[m,n]=size(w2);
for k1=1:m
    for k2=1:n
        fprintf(fid,'%f',w2(k1,k2));
    end
    fprintf(fid,'/n');
end
fclose(fid);



    
    

           
           
