clear
clc
close all

LineSpec.LineWidth=2;
LineSpec.Marker='.';
LineSpec.MarkerSize=22;
hold on
x1=[2 5 10 20 50];
y1=[1.827 4.292 9.750 22.485 46.165];
LineSpec.Color='b';
plot(x1,y1,LineSpec)

x2=[2 5 10 20 50];
y2=[1.817 4.376 9.630 21.432 57.447];
LineSpec.Color='r';
plot(x2,y2,LineSpec)

x3=[2 5 10 20 50];
y3=[1.800,
4.166,
7.614,
14.710,
30.844,
];
LineSpec.Color='g';
plot(x3,y3,LineSpec)

x4=[2 5 10 20 50];
y4=[1.806,
4.192,
7.290,
14.728,
37.149,
];
LineSpec.Color='k';
plot(x4,y4,LineSpec)

plot([0 50],[1 1],'k')

hold off

grid on;

legend('Pot. fija, 2D','Pot. fija, 3D','Pot. aleatoria, 2D','Pot. aleatoria, 3D');
xlabel('Cantidad de sensores','FontSize',14);
ylabel('Eficiencia media máxima','FontSize',14);
set(gca,'FontSize',14)
title('Eficiencia media máxima vs. cantidad de sensores','FontSize',14);
set(1,'Color',[1 1 1])