clear
clc
close all

hold on
x1=[2 5 10 20 50];
y1=[1.827 4.292 9.750 22.485 46.165];
plot(x1,y1,'LineWidth',2)

x2=[2 5 10 20 50];
y2=[1.817 4.376 9.630 21.432 57.447];
plot(x2,y2,'r','LineWidth',2)

x3=[2 5 10 20 50];
y3=[2.985 12.053 27.984 57.093 144.453];
plot(x3,y3,'g','LineWidth',2)

x4=[2 5 10 20 50];
y4=[2.925 10.938 26.564 61.016 170.003];
plot(x4,y4,'k','LineWidth',2)

plot([0 50],[1 1],'k')

hold off

grid on;

legend('Pot. fija, 2D','Pot. fija, 3D','Pot. aleatoria, 2D','Pot. aleatoria, 3D');
xlabel('Cantidad de sensores');
ylabel('Eficiencia media máxima');
title('Eficiencia media máxima vs. cantidad de sensores');