clear
clc
close all

hold on
x1=[2,5,10,16:2:30];
y1=[1.795 4.095 6.501 8.233 8.323 8.736 8.637 8.096 8.576 9.144 9.283];
Linespec.Marker='.';Linespec.Color='k';Linespec.MarkerSize=15;Linespec.LineWidth=2;
plot(x1,y1,Linespec)

x2=[32:2:50];
y2=[8.976 8.562 8.620 8.829 8.984 8.989 9.212 8.969 8.996 9.049];
Linespec.Marker='.';Linespec.Color='r';Linespec.MarkerSize=15;Linespec.LineWidth=2;
plot(x2,y2,Linespec)

x3=[32:2:50];
y3=[9.018 9.135 9.122 8.958 8.602 8.760 9.507 8.832 9.095 9.224];
Linespec.Marker='.';Linespec.Color='g';Linespec.MarkerSize=15;Linespec.LineWidth=2;
plot(x3,y3,Linespec)

% plot([30 32],[9.283 8.976],'--')
% plot([30 32],[9.283 9.018],'--')
plot([0 50],[1 1],'k')
Linespec.Marker='.';Linespec.Color='k';Linespec.MarkerSize=15;
plot(50, 7.750,Linespec)
axis([0 50 0 10])
hold off

grid on;

legend('200 generaciones, 100 población','400 generaciones, 100 población','400 generaciones, 200 población');
xlabel('Cantidad de sensores','FontSize',14);
ylabel('Eficiencia media','FontSize',14);
title('Eficiencia para caso de estudio 1 (pot. fija 2D)','FontSize',14);

set(gca,'FontSize',14)
set(1,'Color',[1 1 1])