%% Primera

% % 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% % 4 para 20 sensores, 5 para 50 sensores
% 
for clusters_fijados=2
clearvars -except clusters_fijados
cd resultados
sensores_a_cargar=1;
% simulaciones_a_cargar=(1+sensores_a_cargar-1:5:26+sensores_a_cargar-1);
grafica='231.1.233';
simulaciones_a_cargar=[231:233];
cantidad_realizaciones=30;
% clusters_fijados=2;

for num=simulaciones_a_cargar
    for ejecucion=1:cantidad_realizaciones
        numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
        caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
        
        if(exist(caso_a_cargar,'file'))
            load(caso_a_cargar);
            
            if(exist('minimo_beam_deseada','var') && sensores == 50)
                
                eficiencia_50(1:length(minimo_beam_deseada{1,1,1}),ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                estacion_seleccionada_50(ejecucion,1:3)=estacion;
            end
            if(exist('minimo_beam_deseada','var') && sensores == 10)
                
                eficiencia_10(1:length(minimo_beam_deseada{1,1,1}),ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                estacion_seleccionada_10(ejecucion,1:3)=estacion;
            end
            if(exist('minimo_beam_deseada','var') && sensores == 20)
                
                eficiencia_20(1:length(minimo_beam_deseada{1,1,1}),ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                estacion_seleccionada_20(ejecucion,1:3)=estacion;
            end
            
            clearvars -except -regexp estacion_seleccionada eficiencia cluster_10 cluster_5 clusters_20 cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a sensores booleana grafica estaciones_deseadas estaciones_no_desea
        end
    end
end
cd ..
cd graficas
save(['casos_nuevos_' grafica '_clusters_fijados_' clusters_fijados '.mat']);
cd ..
clusters_fijados=num2str(clusters_fijados);
end
%% Representación primera gráfica

clear
close all
guardar=1;
clusters_fijados='2';
grafica='231.1.233';
cd graficas
load(['casos_nuevos_' grafica '_clusters_fijados_' clusters_fijados '.mat']);

titulo_grafica='Elección entre 5 estaciones';
XtickFiguras=['10 sensores';'20 sensores';'50 sensores'];
counter=0;
eje_X=(0.5:3:3.5);

cd ..

counter=counter+1;figura(counter)=figure;

eficiencia_conjunta=[eficiencia_10;eficiencia_20;eficiencia_50]
bar([eficiencia_conjunta]);
hold on;plot(eje_X,[1 1],'k');plot(1:3,mean(eficiencia_conjunta,2),'r','LineWidth',2);hold off;grid on;
title([titulo_grafica ', isotrópica, 3D, pot. aleatoria, clusters: ' clusters_fijados]);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);

% subplot(3,1,2);bar(eficiencia_20);
% hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10(:,1)),mean(eficiencia_20,2),'r','LineWidth',2);hold off;grid on;
% title(['20 sensores, isotrópica, 3D, pot. aleatoria clusters: ' clusters_fijados titulo_grafica]);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);
% 
% subplot(3,1,3);bar(eficiencia_50);
% hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10(:,1)),mean(eficiencia_50,2),'r','LineWidth',2);hold off;grid on;
% title(['50 sensores, isotrópica, 3D, pot. aleatoria clusters: ' clusters_fijados titulo_grafica]);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);



cd graficas
if guardar
    savefig(figura,['casos_nuevos_' grafica '_clusters_fijados_' clusters_fijados '.fig'])
end
cd ..