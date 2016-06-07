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
% % simulaciones_a_cargar=(1+sensores_a_cargar-1:5:26+sensores_a_cargar-1);
% simulaciones_a_cargar=[51:52,71];
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
%             if(exist('minimo_beam_no_deseada','var') && sensores == 5)
%                 
%                 eficiencia_5_iso(contador_archivo5,ejecucion)=minimo_beam_no_deseada{1,1,1}./minimo_beam1_no_deseada{1,1,1};
%                 eficiencia_5_dip(contador_archivo5,ejecucion)=minimo_beam_no_deseada{2,1,1}./minimo_beam1_no_deseada{2,1,1};
%                 
%                 cluster_5_iso(contador_archivo5,ejecucion)=max(idx_global{1,1,1});
%                 cluster_5_dip(contador_archivo5,ejecucion)=max(idx_global{2,1,1});
%                 booleana5=1;
%                 booleana10=0;
%                 booleana20=0;
%             end
%             if(exist('minimo_beam_no_deseada','var') && sensores == 10)
%                 
%                 eficiencia_10_iso(contador_archivo10,ejecucion)=minimo_beam_no_deseada{1,1,1}./minimo_beam1_no_deseada{1,1,1};
%                 eficiencia_10_dip(contador_archivo10,ejecucion)=minimo_beam_no_deseada{2,1,1}./minimo_beam1_no_deseada{2,1,1};
%                 
%                 cluster_10_iso(contador_archivo10,ejecucion)=max(idx_global{1,1,1});
%                 cluster_10_dip(contador_archivo10,ejecucion)=max(idx_global{2,1,1});
%                 booleana5=0;
%                 booleana10=1;
%                 booleana20=0;
%             end
%             if(exist('minimo_beam_no_deseada','var') && sensores == 20)
%                 
%                 eficiencia_20_iso(contador_archivo20,ejecucion)=minimo_beam_no_deseada{1,1,1}./minimo_beam1_no_deseada{1,1,1};
%                 eficiencia_20_dip(contador_archivo20,ejecucion)=minimo_beam_no_deseada{2,1,1}./minimo_beam1_no_deseada{2,1,1};
%                 
%                 cluster_20_iso(contador_archivo20,ejecucion)=max(idx_global{1,1,1});
%                 cluster_20_dip(contador_archivo20,ejecucion)=max(idx_global{2,1,1});
%                 booleana5=0;
%                 booleana10=0;
%                 booleana20=1;
%             end
%             
%             clearvars -except -regexp eficiencia cluster_10 cluster_5 cluster_20 cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a sensores booleana
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
% % sensores_a_cargar=num2str(sensores_a_cargar);
% save(['tercera_grafica_3' '_clusters_fijados_' clusters_fijados '.mat']);
% cd ..
% end

%% Representación primera gráfica

% 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% 4 para 20 sensores, 5 para 50 sensores
clear
close all
guardar=1;
clusters_fijados='2';
% clusters_fijados=num2str(clusters_fijados);
% sensores_a_cargar=num2str(sensores_a_cargar);
cd graficas
load(['tercera_grafica_3' '_clusters_fijados_' clusters_fijados '.mat']);

% XtickFiguras=['Pot. fija, 2D, fij';'Pot. alea, 2D, fij';'Pot. fija, 3D, fij';'Pot. alea, 3D, fij'];
% XtickFiguras=['Pot. fija, 2D, fij';'Pot. fija, 2D, mov';'Pot. alea, 2D, mov'];

counter=0;
% XtickFiguras=['Pot. fija, 3D'];
eje_X=(0.5:length(eficiencia_5_iso(:,1)):length(eficiencia_5_iso(:,1))+0.5);

if clusters_fijados ~= '0'

counter=counter+1;figura(counter)=figure;
subplot(3,2,1);bar(eficiencia_5_iso);grid on;
title(['5 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(3,2,2);bar(eficiencia_5_dip);grid on;
title(['5 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(3,2,3);bar(eficiencia_10_iso);grid on;
title(['10 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(3,2,4);bar(eficiencia_10_dip);grid on;
title(['10 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(3,2,5);bar(eficiencia_20_iso);grid on;
title(['20 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(3,2,6);bar(eficiencia_20_dip);grid on;
title(['20 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');

else
    
counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_5_iso);grid on;
title(['5 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(2,2,2);bar(eficiencia_5_dip);grid on;
title(['5 sensores, dipolo, clusters: ' clusters_fijados ', 1 estació no deseadan']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(2,2,3);bar(cluster_5_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');%set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_5_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');%set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_10_iso);grid on;
title(['10 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(2,2,2);bar(eficiencia_10_dip);grid on;
title(['10 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(2,2,3);bar(cluster_10_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');%set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_10_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');%set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_20_iso);grid on;
title(['20 sensores, isotrópica, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(2,2,2);bar(eficiencia_20_dip);grid on;
title(['20 sensores, dipolo, clusters: ' clusters_fijados ', 1 estación no deseada']);xlabel('Potencia fija, 3D');ylabel('Eficiencia');
subplot(2,2,3);bar(cluster_20_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');%set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_20_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');%set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);


end

% cd graficas
if guardar
    archivo_a_guardar='grafica3_';
    casos_a_cargar='casos_51.1.52_';
    
    savefig(figura,[archivo_a_guardar casos_a_cargar 'clusters_fijados_' clusters_fijados '.fig'])
end
clusters_fijados=str2num(clusters_fijados);
cd ..