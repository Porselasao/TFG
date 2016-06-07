%% Borrar y almacenar

simulaciones_a_cargar=222;

% c_sensor=1;
% c_phi1=1;
% c_phi2=2;
% c_theta=1;
% i=1;
% c_antenas=1; %puede ser 2
cantidad_realizaciones=35;
% clusters_fijados=1;
cd resultados
for clusters_fijados=0:5
for num=simulaciones_a_cargar
    num
    for ejecucion=1:cantidad_realizaciones
        numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
        
        caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
        caso_a_guardar=['caso_cambiado_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
        
        if(exist(caso_a_cargar,'file') && ~exist(caso_a_guardar,'file'))
            load(caso_a_cargar);         
            clearvars -except -regexp minimo_beam idx_global caso_ num ejecucion clusters_fijados cantidad_realizaciones simulaciones_a sensores
            save(caso_a_guardar);
        end
        
        clear caso_a_cargar;
        clear caso_a_guardar;
    end
end
end
cd ..



%% Primera

% 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% 4 para 20 sensores, 5 para 50 sensores

clear
cd resultados
sensores_a_cargar=1;
% simulaciones_a_cargar=(1+sensores_a_cargar-1:5:26+sensores_a_cargar-1);
simulaciones_a_cargar=[222];
c_phi1=1;
c_phi2=2;
contador_archivo5=1;
contador_archivo10=1;
cantidad_realizaciones=35;
clusters_fijados=1;
for num=simulaciones_a_cargar
    for ejecucion=1:cantidad_realizaciones
        numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
        caso_a_cargar=['caso_cambiado_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
        
        if(exist(caso_a_cargar,'file'))
            load(caso_a_cargar);
            
            if(exist('minimo_beam_deseada','var') && sensores == 5)
                
                eficiencia_5_iso(contador_archivo5,ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                eficiencia_5_dip(contador_archivo5,ejecucion)=minimo_beam_deseada{2,1,1}./minimo_beam1{2,1,1};
                
                cluster_5_iso(contador_archivo5,ejecucion)=max(idx_global{1,1,1});
                cluster_5_dip(contador_archivo5,ejecucion)=max(idx_global{2,1,1});
                booleana5=1;
                booleana10=0;
            end
            if(exist('minimo_beam_deseada','var') && sensores == 10)
                
                eficiencia_10_iso(contador_archivo10,ejecucion)=minimo_beam_deseada{1,1,1}./minimo_beam1{1,1,1};
                eficiencia_10_dip(contador_archivo10,ejecucion)=minimo_beam_deseada{2,1,1}./minimo_beam1{2,1,1};
                
                cluster_10_iso(contador_archivo10,ejecucion)=max(idx_global{1,1,1});
                cluster_10_dip(contador_archivo10,ejecucion)=max(idx_global{2,1,1});
                booleana5=0;
                booleana10=1;
            end
            
            clearvars -except -regexp eficiencia cluster_10 cluster_5 cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a sensores booleana
        end
    end
    if(exist('booleana5','var') && booleana5)
        contador_archivo5=contador_archivo5+1;
    end
    if(exist('booleana10','var') && booleana10)
        contador_archivo10=contador_archivo10+1;
    end
end
cd ..
cd graficas
sensores_a_cargar=num2str(sensores_a_cargar);
save(['grafica_prueba' sensores_a_cargar '_clusters_fijados_' clusters_fijados '.mat']);
cd ..
%% Representación primera gráfica

% 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% 4 para 20 sensores, 5 para 50 sensores
cd graficas
clear
close all
guardar=1;
clusters_fijados='1';
grafica='1';
% sensores_a_cargar=num2str(sensores_a_cargar);
load(['grafica_prueba' grafica '_clusters_fijados_' clusters_fijados '.mat']);

XtickFiguras=['Pot. fija, 2D, fij';'Pot. alea, 2D, fij';'Pot. fija, 3D, fij';'Pot. alea, 3D, fij';'Pot. fija, 3D, mov'];
% XtickFiguras=['Pot. fija, 2D, fij';'Pot. fija, 2D, mov';'Pot. alea, 2D, mov'];

h(1)=figure;
% subplot(2,1,1);bar(eficiencia_5_iso);
% title('Isotrópica, 1 estación, 5 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([0 length(eficiencia_phi1_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,1,2);bar(eficiencia_10_iso);
title('Isotrópica, 1 estación, 10 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

h(2)=figure;
subplot(2,1,1);bar(eficiencia_5_dip);
title('Dipolo, 1 estación, 5 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([0 length(eficiencia_phi1_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,1,2);bar(eficiencia_10_dip);
title('Dipolo, 1 estación, 10 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

h(3)=figure;
subplot(2,1,1);bar(eficiencia_5_iso);
title('Isotrópica, 1 estación, 5 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([1 length(eficiencia_phi1_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,1,2);bar(cluster_5_iso);
title('Clusters por realización');xlabel('Diferentes escenarios');ylabel('Cantidad de clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0 5 0 20]);

h(4)=figure;
subplot(2,1,1);bar(eficiencia_10_iso);
title('Isotrópica, 1 estación, 10 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([1 length(eficiencia_phi1_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,1,2);bar(cluster_10_iso);
title('Clusters por realización');xlabel('Diferentes escenarios');ylabel('Cantidad de clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0 5 0 20]);

h(5)=figure;
subplot(2,1,1);bar(eficiencia_5_dip);
title('Dipolo, 1 estación, 5 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([1 length(eficiencia_phi1_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,1,2);bar(cluster_5_iso);
title('Clusters por realización');xlabel('Diferentes escenarios');ylabel('Cantidad de clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0 5 0 20]);

h(6)=figure;
subplot(2,1,1);bar(eficiencia_10_dip);
title('Dipolo, 1 estación, 10 sensores');xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);axis([0.5 5.5 0 20]);%axis([1 length(eficiencia_phi1_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,1,2);bar(cluster_10_dip);
title('Clusters por realización');xlabel('Diferentes escenarios');ylabel('Cantidad de clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0 5 0 20]);

cd graficas
if guardar
    archivo_a_guardar='grafica_prueba_';
    casos_a_cargar='casos_37.2.46_';
    
    savefig(h,[archivo_a_guardar casos_a_cargar 'clusters_fijados_' clusters_fijados '.fig'])
end
cd ..