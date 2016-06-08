%% Borrar y almacenar

% simulaciones_a_cargar=1:30;
% % simulaciones_a_cargar=230;
% 
% % c_sensor=1;
% % c_phi1=1;
% % c_phi2=2;
% % c_theta=1;
% % i=1;
% % c_antenas=1; %puede ser 2
% cantidad_realizaciones=5;
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
%             clearvars -except -regexp minimo_beam idx_global caso_ num ejecucion clusters_fijados cantidad_realizaciones simulaciones_a
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

% for clusters_fijados=0:5
for clusters_fijados=1
cd resultados
% sensores_a_cargar=5;
cantidad_de_sensores_titulo='10';
simulaciones_a_cargar=[3 8 23 28];
% simulaciones_a_cargar=simulaciones_a_cargar+sensores_a_cargar;
c_phi1=1;
c_phi2=2;
contador_archivo=1;
cantidad_realizaciones=30;
% clusters_fijados=5;
for num=simulaciones_a_cargar
    for ejecucion=1:cantidad_realizaciones
        numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
        caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
        
        if(exist(caso_a_cargar,'file'))
            load(caso_a_cargar);
            
            eficiencia_phi1_iso(contador_archivo,ejecucion)=max(Tiempo_de_vida_beam{1,1,c_phi1,1,1}./minimo_beam1{1,1,c_phi1,1,1});
            eficiencia_phi2_iso(contador_archivo,ejecucion)=max(Tiempo_de_vida_beam{1,1,c_phi2,1,1}./minimo_beam1{1,1,c_phi2,1,1});
            eficiencia_phi1_dip(contador_archivo,ejecucion)=max(Tiempo_de_vida_beam{2,1,c_phi1,1,1}./minimo_beam1{2,1,c_phi1,1,1});
            eficiencia_phi2_dip(contador_archivo,ejecucion)=max(Tiempo_de_vida_beam{2,1,c_phi2,1,1}./minimo_beam1{2,1,c_phi2,1,1});
            
            cluster_phi1_iso(contador_archivo,ejecucion)=max(idx_global{1,1,c_phi1,1,1});
            cluster_phi2_iso(contador_archivo,ejecucion)=max(idx_global{1,1,c_phi2,1,1});
            cluster_phi1_dip(contador_archivo,ejecucion)=max(idx_global{2,1,c_phi1,1,1});
            cluster_phi2_dip(contador_archivo,ejecucion)=max(idx_global{2,1,c_phi2,1,1});
            
            clearvars -except -regexp eficiencia cluster_phi cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a
            end
    end
    contador_archivo=contador_archivo+1;
end
cd ..
cd graficas
% sensores_a_cargar=num2str(sensores_a_cargar);
save(['eficiencia_maximas_' cantidad_de_sensores_titulo '_sensores_clusters_fijados=' clusters_fijados '.mat']);
cd ..
clusters_fijados=str2num(clusters_fijados);
end
%% Representación primera gráfica
% 
% % % % 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% % % % 4 para 20 sensores, 5 para 50 sensores
for cantidad_de_sensores_titulo=[10]
    cantidad_de_sensores_titulo=num2str(cantidad_de_sensores_titulo);
for clusters_fijados=1
cd graficas
clearvars -except -regexp sensores_a_cargar clusters_fijados cantidad_de_sensores_titulo
close all
% sensores_a_cargar=1;
% sensores_a_cargar=num2str(sensores_a_cargar);
clusters_fijados=num2str(clusters_fijados);
load(['eficiencia_maximas_' cantidad_de_sensores_titulo '_sensores_clusters_fijados=' clusters_fijados '.mat']);
% cantidad_de_sensores=num2str(cantidad_de_sensores);

counter=0;
XtickFiguras=['Pot. fija, 2D';'Pot. alea, 2D';'Pot. fija, 3D';'Pot. alea, 3D'];
eje_X=(0.5:length(eficiencia_phi1_iso(:,1)):length(eficiencia_phi1_iso(:,1))+0.5);

if clusters_fijados ~= '0'

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_phi1_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_iso(:,1)),mean(eficiencia_phi1_iso,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, isotrópica, clusters: ' clusters_fijados ', \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_phi1_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_dip(:,1)),mean(eficiencia_phi1_dip,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, dipolo, clusters: ' clusters_fijados ', \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(eficiencia_phi2_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_iso(:,1)),mean(eficiencia_phi2_iso,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, isotrópica, clusters: ' clusters_fijados ', \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,4);bar(eficiencia_phi2_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_dip(:,1)),mean(eficiencia_phi2_dip,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, dipolo, clusters: ' clusters_fijados ', \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);

else

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_phi1_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_iso(:,1)),mean(eficiencia_phi1_iso,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, isotrópica, \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_phi1_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_dip(:,1)),mean(eficiencia_phi1_dip,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, dipolo, \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_phi1_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_phi1_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_phi2_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_iso(:,1)),mean(eficiencia_phi2_iso,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, isotrópica, \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_phi2_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_dip(:,1)),mean(eficiencia_phi2_dip,2),'r','LineWidth',2);hold off;grid on;
title([cantidad_de_sensores_titulo ' sensores, dipolo, \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_phi2_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_phi2_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

end

guardar=1;
if guardar
    archivo_a_guardar='eficiencia_maximas_';
    
    savefig(figura,[archivo_a_guardar cantidad_de_sensores_titulo '_sensores_clusters_fijados=' clusters_fijados '.fig'])
end
cd ..
clusters_fijados=str2num(clusters_fijados);
end
cantidad_de_sensores_titulo=str2num(cantidad_de_sensores_titulo);
end