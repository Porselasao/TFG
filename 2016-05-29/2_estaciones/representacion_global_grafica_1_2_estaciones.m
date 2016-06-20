%% Borrar y almacenar

% simulaciones_a_cargar=37:46;
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
% 


%% Primera

% 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% 4 para 20 sensores, 5 para 50 sensores

% for clusters_fijados=0:2
% clearvars -except clusters_fijados
% cd resultados
% sensores_a_cargar=1;
% % simulaciones_a_cargar=(1+sensores_a_cargar-1:5:26+sensores_a_cargar-1);
% simulaciones_a_cargar=[37:46,65:68];
% contador_archivo5=1;
% contador_archivo10=1;
% contador_archivo20=1;
% cantidad_realizaciones=35;
% % clusters_fijados=0;
% for num=simulaciones_a_cargar
%     for ejecucion=1:cantidad_realizaciones
%         numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
%         caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
%         
%         if(exist(caso_a_cargar,'file'))
%             load(caso_a_cargar);
%             
%             if(exist('minimo_beam_deseada','var') && sensores == 5)
%                 
%                 eficiencia_5_iso(contador_archivo5,ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
%                 eficiencia_5_dip(contador_archivo5,ejecucion)=minimo_beam_deseada{2,1,1}./minimo_beam1{2,1,1};
%                 
%                 cluster_5_iso(contador_archivo5,ejecucion)=max(idx_global{1,1,1});
%                 cluster_5_dip(contador_archivo5,ejecucion)=max(idx_global{2,1,1});
%                 booleana5=1;
%                 booleana10=0;
%                 booleana20=0;
%             end
%             if(exist('minimo_beam_deseada','var') && sensores == 10)
%                 
%                 eficiencia_10_iso(contador_archivo10,ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
%                 eficiencia_10_dip(contador_archivo10,ejecucion)=minimo_beam_deseada{2,1,1}./minimo_beam1{2,1,1};
%                 
%                 cluster_10_iso(contador_archivo10,ejecucion)=max(idx_global{1,1,1});
%                 cluster_10_dip(contador_archivo10,ejecucion)=max(idx_global{2,1,1});
%                 booleana5=0;
%                 booleana10=1;
%                 booleana20=0;
%             end
%             if(exist('minimo_beam_deseada','var') && sensores == 20)
%                 
%                 eficiencia_20_iso(contador_archivo20,ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
%                 eficiencia_20_dip(contador_archivo20,ejecucion)=minimo_beam_deseada{2,1,1}./minimo_beam1{2,1,1};
%                 
%                 cluster_20_iso(contador_archivo20,ejecucion)=max(idx_global{1,1,1});
%                 cluster_20_dip(contador_archivo20,ejecucion)=max(idx_global{2,1,1});
%                 booleana5=0;
%                 booleana10=0;
%                 booleana20=1;
%             end
%             
%             clearvars -except -regexp eficiencia cluster_10 cluster_20 cluster_5 cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a sensores booleana
%         end
%     end
%     if(booleana5)
%         contador_archivo5=contador_archivo5+1;
%     end
%     if(booleana10)
%         contador_archivo10=contador_archivo10+1;
%     end
%     if(booleana20)
%         contador_archivo20=contador_archivo20+1;
%     end
% end
% cd ..
% cd graficas
% sensores_a_cargar=num2str(sensores_a_cargar);
% save(['primera_grafica_' sensores_a_cargar '_clusters_fijados_' clusters_fijados '.mat']);
% cd ..
% end

%% Representación primera gráfica

% 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% 4 para 20 sensores, 5 para 50 sensores
clear
close all
guardar=1;
clusters_fijados='1';
grafica='1';
clusters_fijados=num2str(clusters_fijados);
% sensores_a_cargar=num2str(sensores_a_cargar);
cd graficas
load(['primera_grafica_1' '_clusters_fijados_' clusters_fijados '.mat']);

% XtickFiguras=['Pot. fija, 2D, fij';'Pot. alea, 2D, fij';'Pot. fija, 3D, fij';'Pot. alea, 3D, fij'];
% XtickFiguras=['Pot. fija, 2D, fij';'Pot. fija, 2D, mov';'Pot. alea, 2D, mov'];
cd ..
counter=0;
XtickFiguras=['igual 2D';'aleat 2D';'igual 3D';'aleat 3D'];
eficiencia_5_iso=eficiencia_5_iso(1:4,:);
eficiencia_10_iso=eficiencia_10_iso(1:4,:);
eficiencia_5_dip=eficiencia_5_dip(1:4,:);
eficiencia_10_dip=eficiencia_10_dip(1:4,:);
cluster_5_iso=cluster_5_iso(1:4,:);
cluster_10_iso=cluster_10_iso(1:4,:);
cluster_5_dip=cluster_5_dip(1:4,:);
cluster_10_dip=cluster_10_dip(1:4,:);
eje_X=(0.5:length(eficiencia_5_iso(:,1)):length(eficiencia_5_iso(:,1))+0.5);

media_20_iso = calcular_medias_distinto_cero(eficiencia_20_iso);
media_20_dip = calcular_medias_distinto_cero(eficiencia_20_dip);

if clusters_fijados ~= '0'

counter=counter+1;figura(counter)=figure;
subplot(3,2,1);bar(eficiencia_5_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),mean(eficiencia_5_iso,2),'r','LineWidth',2);hold off;grid on;
title(['5 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(3,2,2);bar(eficiencia_5_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),mean(eficiencia_5_dip,2),'r','LineWidth',2);hold off;grid on;
title(['5 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(3,2,3);bar(eficiencia_10_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),mean(eficiencia_10_iso,2),'r','LineWidth',2);hold off;grid on;
title(['10 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(3,2,4);bar(eficiencia_10_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),mean(eficiencia_10_dip,2),'r','LineWidth',2);hold off;grid on;
title(['10 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(3,2,5);bar(eficiencia_20_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),media_20_iso,'r','LineWidth',2);hold off;grid on;
title(['20 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(3,2,6);bar(eficiencia_20_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),media_20_dip,'r','LineWidth',2);hold off;grid on;
title(['20 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);

else
    
counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_5_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),mean(eficiencia_5_iso,2),'r','LineWidth',2);hold off;grid on;
title(['5 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_5_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_5_iso(:,1)),mean(eficiencia_5_dip,2),'r','LineWidth',2);hold off;grid on;
title(['5 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_5_iso);
title('Clusters: Isotrópica');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_5_dip);
title('Clusters: Dipolo');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_10_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10_iso(:,1)),mean(eficiencia_10_iso,2),'r','LineWidth',2);hold off;grid on;
title(['10 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_10_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_10_dip(:,1)),mean(eficiencia_10_dip,2),'r','LineWidth',2);hold off;grid on;
title(['10 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_10_iso);
title('Clusters: Isotrópica');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_10_dip);
title('Clusters: Dipolo');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_20_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_20_iso(:,1)),media_20_iso,'r','LineWidth',2);hold off;grid on;
title(['20 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_20_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_20_dip(:,1)),media_20_dip,'r','LineWidth',2);hold off;grid on;
title(['20 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación']);ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_20_iso);
title('Clusters: Isotrópica');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_20_dip);
title('Clusters: Dipolo');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

end

cd graficas
if guardar
    archivo_a_guardar='grafica1_';
    casos_a_cargar='casos_37.44_65.68_';
    
    savefig(figura,[archivo_a_guardar casos_a_cargar 'clusters_fijados_' clusters_fijados '.fig'])
end
clusters_fijados=str2num(clusters_fijados);
cd ..