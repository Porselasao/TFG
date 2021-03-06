%% Caso 4. 2D carga maxima

clear
clc
close all

x1=[2 5 10 20 50];
y1=[1.818 4.527 10.095 19.005 21.862 ];

plot(x1,y1,'LineWidth',2)
grid on;
hold on;

x2=[10 20 50];
y2=[5.368 8.917 11.406];
plot(x2,y2,'r','LineWidth',2)

x3=[20 50];
y3=[5.837 7.201];
plot(x3,y3,'g','LineWidth',2)

% x4=[10 20 50];
% y4=[10.376 16.934 14.670];
% plot(x4,y4,'k','LineWidth',2)


hold off

xlabel('Cantidad de sensores','FontSize',14);ylabel('Eficiencia media','FontSize',14);
title('Eficiencia media en funci�n de la cantidad de clusters','FontSize',14)
legend('1 cluster','2 clusters','3 clusters')%,'Clusters optimizados')
set(gca,'FontSize',14)
set(1,'Color',[1 1 1])

%% Caso 1. 2D carga maxima

clear
clc
close all
figure

x1=[2 5 10 20 50];
y1=[1.818 4.527 10.095 19.005 21.862];

% plot(x1,y1,'LineWidth',2)
grid on;
hold on;
% plot(x1(3:5),y1(3:5)./2,'c','LineWidth',2)
plot(x1(2:3),y1(2:3),'k','LineWidth',2.3)
plot([10 20],y1(2:3),'g','LineWidth',2.3)

x2=[10 20 50];
y2=[5.368 8.917 11.406];
plot(x2(1:2),y2(1:2),'r','LineWidth',2.3)

plot([5 10],[y1(2) y1(2)],'--')
plot([10 20],[y1(3) y1(3)],'--')


hold off
axis([4 21 4 11])

xlabel('Cantidad de sensores');ylabel('Eficiencia media');
title('Eficiencia media en funci�n de la cantidad de clusters')
legend('1 cluster','Tendencia con 2 clusters esperada','Tendencia con 2 clusters obtenida')
