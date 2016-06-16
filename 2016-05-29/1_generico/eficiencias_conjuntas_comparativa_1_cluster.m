clear
clc
close all

hold on
x1=[2 5 10 20 50];
y1=[1.827 4.162 6.561 8.461 7.887];
plot(x1,y1,'LineWidth',2)

x2=[2 5 10 20 50];
y2=[1.817 4.259 7.072 10.667 11.096];
plot(x2,y2,'r','LineWidth',2)

x3=[2 5 10 20 50];
y3=[1.803 4.446 9.720 16.080 15.668];
plot(x3,y3,'g','LineWidth',2)

x4=[2 5 10 20 50];
y4=[1.818 4.527 10.095 19.005 21.862 ];
plot(x4,y4,'k','LineWidth',2)

plot([0 50],[1 1],'k')

hold off

grid on;

legend('Pot. fija, 2D','Pot. fija, 3D','Pot. aleatoria, 2D','Pot. aleatoria, 3D');
xlabel('Cantidad de sensores');
ylabel('Eficiencia media');
title('Eficiencia media vs. cantidad de sensores');