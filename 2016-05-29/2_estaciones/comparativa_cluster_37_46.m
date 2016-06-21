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

plot(x,y_caso1_1cluster_iso,x,y_caso2_1cluster_iso,x,y_caso3_1cluster_iso,x,y_caso4_1cluster_iso,x,y_caso1_2cluster_iso,x,y_caso2_2cluster_iso,x,y_caso3_2cluster_iso,x,y_caso4_2cluster_iso,'LineWidth',2)
title('Comparativa entre casos y clusters, caso de estudio 5, isotrópica')
xlabel('Sensores')
ylabel('Eficiencia')
grid on
legend('carga igual 2D, 1 cluster','carga igual 3D, 1 cluster','carga aleatoria 2D, 1 cluster','carga aleatoria 3D, 1 cluster','carga igual 2D, 2 clusters','carga igual 3D, 2 clusters','carga aleatoria 2D, 2 clusters','carga aleatoria 3D, 2 clusters')


figure

y_caso1_1cluster_dip=[4.315 7.091 9.342];
y_caso2_1cluster_dip=[4.744 8.073 12.664];
y_caso3_1cluster_dip=[4.315 8.589 15.374];
y_caso4_1cluster_dip=[4.257 9.434 18.711];

y_caso1_2cluster_dip=[1.717985511 3.819759621 6.172476499];
y_caso2_2cluster_dip=[1.983734034 5.565074707 9.669559233];
y_caso3_2cluster_dip=[2.205061202 4.678271642 9.466973643];
y_caso4_2cluster_dip=[2.28473996 5.425045702 11.45784389];

plot(x,y_caso1_1cluster_dip,x,y_caso2_1cluster_dip,x,y_caso3_1cluster_dip,x,y_caso4_1cluster_dip,x,y_caso1_2cluster_dip,x,y_caso2_2cluster_dip,x,y_caso3_2cluster_dip,x,y_caso4_2cluster_dip,'LineWidth',2)
title('Comparativa entre casos y clusters, caso de estudio 5, dipolo')
xlabel('Sensores')
ylabel('Eficiencia')
grid on
legend('carga igual 2D, 1 cluster','carga igual 3D, 1 cluster','carga aleatoria 2D, 1 cluster','carga aleatoria 3D, 1 cluster','carga igual 2D, 2 clusters','carga igual 3D, 2 clusters','carga aleatoria 2D, 2 clusters','carga aleatoria 3D, 2 clusters')

