clear
clc
close all

hold on
x1=[2,5,10,16:2:30];
y1=[1.823 4.550 10.098 15.378 17.763 19.635 18.736 20.182 21.387 22.253 21.959];
Linespec.Marker='.';Linespec.Color='k';Linespec.MarkerSize=15;Linespec.LineWidth=2;
plot(x1,y1,Linespec)


x2=[32:2:50];
y2=[21.967 21.823 23.255 24.365 25.296 25.401 27.572 26.580 27.152 26.599];
Linespec.Marker='.';Linespec.Color='r';Linespec.MarkerSize=15;Linespec.LineWidth=2;
plot(x2,y2,Linespec)


x3=[32:2:50];
y3=[21.166 22.679 23.346 24.371 25.515 25.353 26.119 27.138 27.821 28.824];
Linespec.Marker='.';Linespec.Color='g';Linespec.MarkerSize=15;Linespec.LineWidth=2;
plot(x3,y3,Linespec)

% plot([30 32],[21.959 21.967],'--')
% plot([30 32],[21.959 21.166],'--')

plot([0 50],[1 1],'k')
Linespec.Marker='.';Linespec.Color='k';Linespec.MarkerSize=15;
plot(50,  22.254,Linespec)
% axis([16 50 0 10])
hold off

grid on;
legend('200 generaciones, 100 población','400 generaciones, 100 población','400 generaciones, 200 población');
xlabel('Cantidad de sensores','FontSize',14);
ylabel('Eficiencia media','FontSize',14);
title('Eficiencia para caso de estudio 4 (carga aleatoria 3D)','FontSize',14);
set(gca,'FontSize',14)
set(1,'Color',[1 1 1])