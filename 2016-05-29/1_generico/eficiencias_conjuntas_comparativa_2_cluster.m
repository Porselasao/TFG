clear
clc
close all

hold on
x1=[10 20 50];
y1=[3.414 4.699 5.167];
plot(x1,y1,'LineWidth',2)

x2=[10 20 50];
y2=[3.597 5.056 5.787];
plot(x2,y2,'r','LineWidth',2)

x3=[10 20 50];
y3=[5.025 8.409 10.070];
plot(x3,y3,'g','LineWidth',2)

x4=[10 20 50];
y4=[5.368 8.917 11.406];
plot(x4,y4,'k','LineWidth',2)

hold off

grid on;

legend('Pot. fija, 2D','Pot. fija, 2D','Pot. aleatoria, 2D','Pot. aleatoria, 3D');