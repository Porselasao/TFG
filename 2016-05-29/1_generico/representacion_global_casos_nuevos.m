%% Primera

% % 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% % 4 para 20 sensores, 5 para 50 sensores
% clear
% 
% for clusters_fijados=1:2
% clearvars -except clusters_fijados
% cd resultados
% simulaciones_a_cargar=146:155;
% sensores_a_cargar='146.1.155';
% c_phi1=1;
% cantidad_realizaciones=30;
% 
% contador_archivo=1;
% caso_no_existe=0;
% for num=simulaciones_a_cargar
%     for ejecucion=1:cantidad_realizaciones
%         numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
%         caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
%         
%         if(exist(caso_a_cargar,'file'))
%             load(caso_a_cargar);
%             
%             eficiencia_phi1_iso(contador_archivo,ejecucion)=minimo_beam{1,1,c_phi1,1,1}./minimo_beam1{1,1,c_phi1,1,1};
%             
%             cluster_phi1_iso(contador_archivo,ejecucion)=max(idx_global{1,1,c_phi1,1,1});
%             
%             clearvars -except -regexp eficiencia cluster_phi cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a simulaciones caso_no
%         else
%             caso_no_existe=caso_no_existe+1;
%         end
%     end
%     contador_archivo=contador_archivo+1;
% end
% cd ..
% cd graficas
% save(['casos_nuevos' sensores_a_cargar '_clusters_fijados=' clusters_fijados '.mat']);
% cd ..
% clusters_fijados=str2num(clusters_fijados);
% end
%% Representación primera gráfica
% 
% % % % 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% % % % 4 para 20 sensores, 5 para 50 sensores
% for clusters_fijados=0:5
for clusters_fijados=1
cd graficas
clearvars -except sensores_a_cargar clusters_fijados
guardar=0;
close all
sensores_a_cargar='146.1.155';
caso_titulo=', Carga aleatoria, 3D (400 generaciones 200 población), ';
casos_a_cargar=['casos_' sensores_a_cargar '_'];
clusters_fijados=num2str(clusters_fijados);
% clusters_fijados='4';
load(['casos_nuevos' sensores_a_cargar '_clusters_fijados=' clusters_fijados '.mat']);
counter=0;

%     XtickFiguras=['16';'18';'20';'22';'24';'26';'28';'30'];
    XtickFiguras=['32';'34';'36';'38';'40';'42';'44';'46';'48';'50'];

eje_X=(0.5:length(eficiencia_phi1_iso(:,1)):length(eficiencia_phi1_iso(:,1))+0.5);

if clusters_fijados ~= '0'
counter=counter+1;figura(counter)=figure;
bar(eficiencia_phi1_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_iso(:,1)),mean(eficiencia_phi1_iso,2),'r','LineWidth',2);hold off;grid on;
title(['Clusters: ' clusters_fijados caso_titulo 'Isotrópica, \it\theta = 45º, \phi = 0º'],'FontSize',14);xlabel('Sensores','FontSize',14);ylabel('Eficiencia','FontSize',14);set(gca,'XtickLabel',XtickFiguras,'FontSize',14,'XLim',eje_X);
set(1,'Color',[1 1 1])
end

if guardar
    archivo_a_guardar='casos_nuevos';
    
    savefig(figura,[archivo_a_guardar casos_a_cargar 'clusters_fijados=' clusters_fijados '.fig'])
end
clusters_fijados=str2num(clusters_fijados);
cd ..
end