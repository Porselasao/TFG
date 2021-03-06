clear all
clc
close all

x=[5 10 20];

figure

y_caso1_1cluster_iso=[4.315 7.091 9.342];
y_caso2_1cluster_iso=[4.744 8.073 12.664];
y_caso3_1cluster_iso=[4.315 8.589 15.374];
y_caso4_1cluster_iso=[4.257 9.434 18.711];

y_caso1_2cluster_iso=[1.615066374 3.472719413 4.825152644];
y_caso2_2cluster_iso=[1.669025386 3.860471771 5.72034994];
y_caso3_2cluster_iso=[2.156263678 4.620329033 8.129710896];
y_caso4_2cluster_iso=[2.084141153 4.721403366 8.769804777];

LineSpec.LineWidth=2;
hold on
LineSpec.Color='r';plot(x,y_caso1_1cluster_iso,LineSpec)
LineSpec.Color='k';plot(x,y_caso2_1cluster_iso,LineSpec)
LineSpec.Color='b';plot(x,y_caso3_1cluster_iso,LineSpec)
LineSpec.Color='g';plot(x,y_caso4_1cluster_iso,LineSpec)
LineSpec.Line='-.';
LineSpec.Color='r';plot(x,y_caso1_2cluster_iso,LineSpec)
LineSpec.Color='k';plot(x,y_caso2_2cluster_iso,LineSpec)
LineSpec.Color='b';plot(x,y_caso3_2cluster_iso,LineSpec)
LineSpec.Color='g';plot(x,y_caso4_2cluster_iso,LineSpec)
plot([5 20],[1 1],'k')
hold off
title('Comparativa entre casos y clusters, caso de estudio 5, isotrópica','FontSize',14)
xlabel('Sensores','FontSize',14)
ylabel('Eficiencia','FontSize',14)
grid on
legend('carga igual 2D, 1 cluster','carga igual 3D, 1 cluster','carga aleatoria 2D, 1 cluster','carga aleatoria 3D, 1 cluster','carga igual 2D, 2 clusters','carga igual 3D, 2 clusters','carga aleatoria 2D, 2 clusters','carga aleatoria 3D, 2 clusters')
set(gca,'FontSize',14)
set(1,'Color',[1 1 1])

figure


y_caso1_1cluster_dip=[4.661 8.017 12.186];
y_caso2_1cluster_dip=[6.901 12.751 23.381];
y_caso3_1cluster_dip=[4.390 8.619 16.988];
y_caso4_1cluster_dip=[9.434 10.903 29.329];

y_caso1_2cluster_dip=[1.717985511 3.819759621 6.172476499];
y_caso2_2cluster_dip=[1.983734034 5.565074707 9.669559233];
y_caso3_2cluster_dip=[2.205061202 4.678271642 9.466973643];
y_caso4_2cluster_dip=[2.28473996 5.425045702 11.45784389];

LineSpec.LineWidth=2;
LineSpec.Line='-';
hold on
LineSpec.Color='r';plot(x,y_caso1_1cluster_dip,LineSpec)
LineSpec.Color='k';plot(x,y_caso2_1cluster_dip,LineSpec)
LineSpec.Color='b';plot(x,y_caso3_1cluster_dip,LineSpec)
LineSpec.Color='g';plot(x,y_caso4_1cluster_dip,LineSpec)
LineSpec.Line='-.';
LineSpec.Color='r';plot(x,y_caso1_2cluster_dip,LineSpec)
LineSpec.Color='k';plot(x,y_caso2_2cluster_dip,LineSpec)
LineSpec.Color='b';plot(x,y_caso3_2cluster_dip,LineSpec)
LineSpec.Color='g';plot(x,y_caso4_2cluster_dip,LineSpec)
plot([5 20],[1 1],'k')
hold off
title('Comparativa entre casos y clusters, caso de estudio 5, dipolo','FontSize',14)
xlabel('Sensores','FontSize',14)
ylabel('Eficiencia','FontSize',14)
grid on
legend('carga igual 2D, 1 cluster','carga igual 3D, 1 cluster','carga aleatoria 2D, 1 cluster','carga aleatoria 3D, 1 cluster','carga igual 2D, 2 clusters','carga igual 3D, 2 clusters','carga aleatoria 2D, 2 clusters','carga aleatoria 3D, 2 clusters')
set(gca,'FontSize',14)
set(2,'Color',[1 1 1])
