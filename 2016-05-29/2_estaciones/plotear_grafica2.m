function plotear_grafica2(matriz_estacion1,matriz_estacion2,media1,media2)


eje_X=(0.5:length(matriz_estacion1(:,1))*2:length(matriz_estacion1(:,1))*2+0.5);

if media1==0

bar([matriz_estacion1(1,:);matriz_estacion2(1,:);matriz_estacion1(2,:);matriz_estacion2(2,:)]);...
    hold on;plot(eje_X,[1 1],'k');plot(1:length(matriz_estacion2(:,1))*2,[mean(matriz_estacion1(1,:)) mean(matriz_estacion2(1,:)) mean(matriz_estacion1(2,:)) mean(matriz_estacion2(2,:))],'r','LineWidth',2);hold off;grid on;

else

bar([matriz_estacion1(1,:);matriz_estacion2(1,:);matriz_estacion1(2,:);matriz_estacion2(2,:)]);...
    hold on;plot(eje_X,[1 1],'k');plot(1:length(matriz_estacion2(:,1))*2,[media1(1) media2(1) media1(2) media2(2)],'r','LineWidth',2);hold off;grid on;

end