clear all
clc
close all

cd resultados
load('caso_227_ejecucion_21clusters1.mat');
cd ..

plot3(estacion(:,1),estacion(:,2),estacion(:,3),'.','Color','b')
hold on
grid on
plot3(estacion_no_deseada(:,1),estacion_no_deseada(:,2),estacion_no_deseada(:,3),'.','Color','r')
axis([-200 200 -200 200 -200 200])

plot3([-1000 1000],[0 0],[0 0],'k')
plot3([0 0],[-1000 1000],[0 0],'k')

