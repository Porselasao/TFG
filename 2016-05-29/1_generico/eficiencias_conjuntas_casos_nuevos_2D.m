clear
clc
close all

hold on
x1=[2,5,10,16:2:30,50];
y1=[1.795 4.095 6.501 8.233 8.323 8.736 8.637 8.096 8.576 9.144 9.283 7.750];
plot(x1,y1,'k','LineWidth',2)

x2=[32:2:50];
y2=[8.976 8.562 8.620 8.829 8.984 8.989 9.212 8.969 8.996 9.049];
plot(x2,y2,'r','LineWidth',2)

x3=[32:2:50];
y3=[9.018 9.135 9.122 8.958 8.602 8.760 9.507 8.832 9.095 9.224];
plot(x3,y3,'g','LineWidth',2)

% plot([30 32],[9.283 8.976],'--')
% plot([30 32],[9.283 9.018],'--')
plot([0 50],[1 1],'k')
% axis([16 50 0 10])
hold off

grid on;

legend('200 generaciones, 100 población','400 generaciones, 100 población','400 generaciones, 200 población');
xlabel('Cantidad de sensores');
ylabel('Eficiencia media');
title('Eficiencia para caso de estudio 1 (pot. fija 2D)');