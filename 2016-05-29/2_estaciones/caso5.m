clear all
close all

x=[5 10 20];

iso_1 = [4.315 7.091 9.342];
iso_2 = [4.744 8.073 12.664 ];
iso_3 =[4.315 8.589 15.374 ];
iso_4 =[4.257 9.434 18.711 ];

dip_1 =[4.661 8.017 12.186 ];
dip_2 =[6.901 12.751 23.381 ];
dip_3 =[4.390 8.619 16.988 ];
dip_4 =[5.797 10.903 29.329];

LineSpec.LineWidth=2;
hold on
LineSpec.Color='r';plot(x,iso_1,LineSpec)
LineSpec.Color='k';plot(x,iso_2,LineSpec)
LineSpec.Color='b';plot(x,iso_3,LineSpec)
LineSpec.Color='g';plot(x,iso_4,LineSpec)
plot([5 20],[1 1],'k')
hold off
title('Caso de estudio 5, antenas isotrópicas','FontSize',14)
xlabel('Sensores','FontSize',14)
ylabel('Eficiencia','FontSize',14)
grid on
legend('carga igual 2D, iso','carga igual 3D, iso','carga aleatoria 2D, iso','carga aleatoria 3D, iso')
set(gca,'FontSize',14)
set(1,'Color',[1 1 1])
hold off

figure
LineSpec.Line='-';
hold on
LineSpec.Color='r';plot(x,dip_1,LineSpec)
LineSpec.Color='k';plot(x,dip_2,LineSpec)
LineSpec.Color='b';plot(x,dip_3,LineSpec)
LineSpec.Color='g';plot(x,dip_4,LineSpec)
plot([5 20],[1 1],'k')
hold off
title('Caso de estudio 5, antenas dipolo','FontSize',14)
xlabel('Sensores','FontSize',14)
ylabel('Eficiencia','FontSize',14)
grid on
legend('carga igual 2D, dip','carga igual 3D, dip','carga aleatoria 2D, dip','carga aleatoria 3D, dip')
set(gca,'FontSize',14)
set(2,'Color',[1 1 1])