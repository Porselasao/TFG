%% Borrar y almacenar

% simulaciones_a_cargar=47:50;
% 
% % c_sensor=1;
% % c_phi1=1;
% % c_phi2=2;
% % c_theta=1;
% % i=1;
% % c_antenas=1; %puede ser 2
% cantidad_realizaciones=35;
% % clusters_fijados=1;
% cd resultados
% for clusters_fijados=0:5
% for num=simulaciones_a_cargar
%     num
%     for ejecucion=1:cantidad_realizaciones
%         numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
%         
%         caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
%         caso_a_guardar=['caso_cambiado_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
%         
%         if(exist(caso_a_cargar,'file') && ~exist(caso_a_guardar,'file'))
%             load(caso_a_cargar);         
%             clearvars -except -regexp minimo_beam idx_global caso_ num ejecucion clusters_fijados cantidad_realizaciones simulaciones_a sensores
%             save(caso_a_guardar);
%         end
%         
%         clear caso_a_cargar;
%         clear caso_a_guardar;
%     end
% end
% end
% cd ..



%% Primera

% % 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% % 4 para 20 sensores, 5 para 50 sensores
% 
for clusters_fijados=1
clearvars -except clusters_fijados
cd resultados
sensores_a_cargar=1;
% simulaciones_a_cargar=(1+sensores_a_cargar-1:5:26+sensores_a_cargar-1);
grafica='213.1.215';
simulaciones_a_cargar=[213:215];
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
                eficiencia_50(length(minimo_beam_deseada{1,1,1})+1:length(minimo_beam_deseada{1,1,1})+length(minimo_beam_no_deseada{1,1,1}),ejecucion)=minimo_beam_no_deseada{1,1,1}./minimo_beam1_no_deseada{1,1,1};
                
            end
            if(exist('minimo_beam_deseada','var') && sensores == 10)
                
                eficiencia_10(1:length(minimo_beam_deseada{1,1,1}),ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                eficiencia_10(length(minimo_beam_deseada{1,1,1})+1:length(minimo_beam_deseada{1,1,1})+length(minimo_beam_no_deseada{1,1,1}),ejecucion)=minimo_beam_no_deseada{1,1,1}./minimo_beam1_no_deseada{1,1,1};
            end
            if(exist('minimo_beam_deseada','var') && sensores == 20)
                
                eficiencia_20(1:length(minimo_beam_deseada{1,1,1}),ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                eficiencia_20(length(minimo_beam_deseada{1,1,1})+1:length(minimo_beam_deseada{1,1,1})+length(minimo_beam_no_deseada{1,1,1}),ejecucion)=minimo_beam_no_deseada{1,1,1}./minimo_beam1_no_deseada{1,1,1};
            end
            
            clearvars -except -regexp eficiencia cluster_10 cluster_5 clusters_20 cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a sensores booleana grafica estaciones_deseadas estaciones_no_desea
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
clusters_fijados='1';
grafica='213.1.215';
cd graficas
load(['casos_nuevos_' grafica '_clusters_fijados_' clusters_fijados '.mat']);

titulo_grafica=', estaciones deseadas y no deseadas';
XtickFiguras=['  Estación deseada 1 ';'Estación no deseada 1';'Estación no deseada 2';'Estación no deseada 3';'Estación no deseada 4';'Estación no deseada 5'];
counter=0;
eje_X=(0.5:length(eficiencia_10(:,1)):length(eficiencia_10(:,1))+0.5);

cd ..

counter=counter+1;figura(counter)=figure;

subplot(3,1,1);bar(eficiencia_10);
hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10(:,1)),mean(eficiencia_10,2),'r','LineWidth',2);hold off;grid on;
title(['10 sensores, isotrópica, 3D, pot. aleatoria clusters: ' clusters_fijados titulo_grafica]);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);

subplot(3,1,2);bar(eficiencia_20);
hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10(:,1)),mean(eficiencia_20,2),'r','LineWidth',2);hold off;grid on;
title(['20 sensores, isotrópica, 3D, pot. aleatoria clusters: ' clusters_fijados titulo_grafica]);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);

subplot(3,1,3);bar(eficiencia_50);
hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10(:,1)),mean(eficiencia_50,2),'r','LineWidth',2);hold off;grid on;
title(['50 sensores, isotrópica, 3D, pot. aleatoria clusters: ' clusters_fijados titulo_grafica]);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);



cd graficas
if guardar
    savefig(figura,['casos_nuevos_' grafica '_clusters_fijados_' clusters_fijados '.fig'])
end
cd ..