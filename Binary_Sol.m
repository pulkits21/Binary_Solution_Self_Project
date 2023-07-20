clear;clc;
x1=linspace(1,0,101);                       %defining variables used, x1 is varied from 0 to 1 with gap of 0.01
x2=1-x1;                                    %as x1+x2=1
A12=0.4269; A21=0.6722;                     %given
gama1=zeros(1,101); gama2=zeros(1,101);     %same size as of x1, will be filled with appropriate value later 
p1sat=@(T)10^(7.25970-1369.410/(235.475+T));%saturation pressure as temperature as a function of T (temperature)
p2sat=@(T)10^(7.81910-1801.900/(230.000+T));
T_val=zeros(1,101);
for i=1:101
    gama1(i)=exp((x2(i)*x2(i))*(A12+2*(A21-A12)*x1(i)));%finding values of gama from the formula given
    gama2(i)=exp((A21+2*(A12-A21)*x2(i))*x1(i)*x1(i));
    X1=x1(i)*gama1(i);                                     
    X2=x2(i)*gama2(i);       %unnecessory variables X2,X1, to make function defined below look bit simplier
    root=@(T)X1*10^(7.25970-1369.410/(235.475+T))+X2*10^(7.81910-1801.900/(230.000+T))-760;
    T0=[63,210];             %range of T to get the roots, [77,134] is required but extending range would give same output
    T_val(i)=fzero(root,T0); %find roots of function in given range
end
tiledlayout(2,2); nexttile;  %difining tiles to plot multiple plots
plot(x1,T_val); grid on;
hold on;                     %to plot multiple graphs on same plot
y1=zeros(1,101);
for i=1:101                  %loop to find y1
    p1sat=10^(7.25970-1369.410/(235.475+T_val(i)));
    y1(i)=p1sat*x1(i)*gama1(i)/760;
end
plot(y1,T_val);
T=[135.00,130.60,128.60,125.90,119.30,113.10,106.80,97.60,95.40,90.50,87.10,84.20,82.30,80.60,77.10]; %defining matrix for the data given
X=[0,0.0200,0.0320,0.0500,0.0825,0.1330,0.1930,0.3150,0.3475,0.4525,0.5800,0.6650,0.7375,0.8125,1];
Y=[0,0.1625,0.1960,0.2600,0.4090,0.5300,0.6575,0.7900,0.8175,0.8675,0.9125,0.9375,0.9500,0.9625,1];
plot(X,T,'.');   %used '.'to get points on graph as dotted instead of line
plot(Y,T,'.');
hold off; nexttile;        %moving to next plot
plot(y1,x1);
hold on; grid on;
plot(Y,X,'.'); hold off;