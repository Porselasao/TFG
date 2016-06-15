%% Caso 3. 2D carga maxima

% NO RELLENO!!!!!!!!!!!
clear
clc
close all

x1=[2 5 10 20 50];
y1=[1.803 4.446 9.720 16.080 15.668];

plot(x1,y1,'LineWidth',2)
grid on;
hold on;

x2=[10 20 50];
y2=[5.025 8.409 10.070];
plot(x2,y2,'r','LineWidth',2)

x3=[20 50];
y3=[5.536 6.489];
plot(x3,y3,'g','LineWidth',2)

x4=[10 20 50];
y4=[9.331 13.551 10.836];
plot(x4,y4,'k','LineWidth',2)


hold off

xlabel('Cantidad de sensores');ylabel('Eficiencia media');
title('Eficiencia media en función de la cantidad de clusters')
legend('1 cluster','2 clusters','3 clusters','Clusters optimizados')

%% Caso 1. 2D carga maxima

clear
clc
close all
figure

x1=[2 5 10 20 50];
y1=[1.803 4.446 9.720 16.080 15.668];

% plot(x1,y1,'LineWidth',2)
grid on;
hold on;
% plot(x1(3:5),y1(3:5)./2,'c','LineWidth',2)
plot(x1(2:3),y1(2:3),'k','LineWidth',2.3)
plot([10 20],y1(2:3),'g','LineWidth',2.3)

x2=[10 20 50];
y2=[5.025 8.409 10.070];
plot(x2(1:2),y2(1:2),'r','LineWidth',2.3)

plot([5 10],[y1(2) y1(2)],'--')
plot([10 20],[y1(3) y1(3)],'--')


hold off
axis([4 21 4 11])

xlabel('Cantidad de sensores');ylabel('Eficiencia media');
title('Eficiencia media en función de la cantidad de clusters')
legend('1 cluster','Tendencia con 2 clusters esperada','Tendencia con 2 clusters obtenida')
