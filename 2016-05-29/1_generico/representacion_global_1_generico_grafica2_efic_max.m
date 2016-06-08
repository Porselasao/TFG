% %% Borrar y almacenar
% 
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

%%

% clear
% simulaciones_a_cargar=1:5;
% cantidad_realizaciones=30;
% % clusters_fijados=1;
% cd resultados
% for clusters_fijados=1:5
%     clusters_fijados
% for num=simulaciones_a_cargar
% %     num
%     for ejecucion=1:cantidad_realizaciones
%         numero=num2str(num);ejec=num2str(ejecucion);clusters_fijados=num2str(clusters_fijados);
%         
%         caso_a_cargar=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
%         caso_a_guardar=['caso_cambiado_' numero '_ejecucion_' ejec 'clusters' clusters_fijados '.mat'];
%         
%         if(exist(caso_a_cargar,'file') && ~exist(caso_a_guardar,'file'))
%             load(caso_a_cargar);
%             
%             cd ..
%             clear Potencia_radiada Potencia_recibida Tiempo_de_vida_beam minimo_cluster minimo_beam
%             c_sensores=1;
%             for Numero_de_sensores=sensores
%             c_antenas=1;
%             for tipo_antena=antenas
%             c_phi=1;
%             for phibuscado=phi
%             c_theta=1;
%             for thetabuscado=theta
%             for instante=1:(tiempo_de_simulacion)
%             for k=1:length((centro_cluster_global{c_antenas,c_sensores,c_phi,c_theta,instante}(:,1)))
%                 
%                 sensores_cluster_actual=sum(idx_global{c_antenas,c_sensores,c_phi,c_theta,instante}==k);
%                 sincronismo=calcular_sincronismo(sensores_cluster_actual);
%                 Potencia_radiada{c_antenas,c_sensores,c_phi,c_theta,instante,k}=reshape(array_config(1,5,mejor_idx==k),1,sum(mejor_idx==k),1,1)*sincronismo;
%                 Potencia_recibida{c_antenas,c_sensores,c_phi,c_theta,instante,k}=((10^(directividad_buscada{c_antenas,c_sensores,c_phi,c_theta,instante,k}/10))*(LANDA)^2/(4*distancia*pi))^2./Potencia_radiada{c_antenas,c_sensores,c_phi,c_theta,instante,k}; % Añadido un "."
%                 Tiempo_de_vida_beam{c_antenas,c_sensores,c_phi,c_theta,instante,k}=Potencia_sensores{c_sensores}(mejor_idx==k).*Potencia_recibida{c_antenas,c_sensores,c_phi,c_theta,instante,k}/sensores_cluster_actual;
%                 minimo_cluster{c_antenas,c_sensores,c_phi,c_theta,instante}(k)=min(Tiempo_de_vida_beam{c_antenas,c_sensores,c_phi,c_theta,instante,k});
%             end
%             minimo_beam{c_antenas,c_sensores,c_phi,c_theta,instante}=min(minimo_cluster{c_antenas,c_sensores,c_phi,c_theta,instante});
%             end
%             c_theta=c_theta+1;
%             end
%             c_phi=c_phi+1;
%             end
%             c_antenas=c_antenas+1;
%             end
%             c_sensores=c_sensores+1;
%             end
%             
%             cd resultados
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
clear
% for clusters_fijados=0:5
for clusters_fijados=1
clearvars -except clusters_fijados
cd resultados
simulaciones_a_cargar=[26:30];
sensores_a_cargar='26.1.30';
% simulaciones_a_cargar=[230];
c_phi1=1;
c_phi2=2;
cantidad_realizaciones=30;
% clusters_fijados=4;

contador_archivo=1;
caso_no_existe=0;
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
            
            clearvars -except -regexp eficiencia cluster_phi cantidad_ clusters_f num ejecucion contador_ar c_phi sensores_a simulaciones caso_no
        else
            caso_no_existe=caso_no_existe+1;
        end
    end
    contador_archivo=contador_archivo+1;
end
cd ..
cd graficas
save(['eficiencia_maximas_' sensores_a_cargar '_clusters_fijados=' clusters_fijados '.mat']);
cd ..
clusters_fijados=str2num(clusters_fijados);
end
%% Representación primera gráfica
% 
% % % % 1 para 2 sensores, 2 para 5 sensores, 3 para 10 sensores
% % % % 4 para 20 sensores, 5 para 50 sensores
% for clusters_fijados=0:5
for clusters_fijados=1
cd graficas
clearvars -except sensores_a_cargar clusters_fijados
guardar=1;
close all
sensores_a_cargar='26.1.30';
caso_titulo=', Pot. aleatoria, 3D, ';
casos_a_cargar=['casos_' sensores_a_cargar '_'];
clusters_fijados=num2str(clusters_fijados);
% clusters_fijados='4';
load(['eficiencia_maximas_' sensores_a_cargar '_clusters_fijados=' clusters_fijados '.mat']);
counter=0;
% XtickFiguras=['Pot. fija, 2D, fij';'Pot. alea, 2D, fij';'Pot. fija, 2D, mov';'Pot. alea, 2D, mov';'Pot. fija, 3D, fij';'Pot. alea, 3D, fij'];
% XtickFiguras=['Pot. fija, 2D, fij';'Pot. fija, 2D, mov';'Pot. alea, 2D, mov'];
if (str2num(clusters_fijados)==1)
    XtickFiguras=['2 sensores ';'5 sensores ';'10 sensores';'20 sensores';'50 sensores'];
elseif (str2num(clusters_fijados)==0 || str2num(clusters_fijados)==2)
    XtickFiguras=['10 sensores';'20 sensores';'50 sensores'];
    eficiencia_phi1_iso=eficiencia_phi1_iso(3:5,:);
    eficiencia_phi2_iso=eficiencia_phi2_iso(3:5,:);
    eficiencia_phi1_dip=eficiencia_phi1_dip(3:5,:);
    eficiencia_phi2_dip=eficiencia_phi2_dip(3:5,:);
    cluster_phi1_iso=cluster_phi1_iso(3:5,:);
    cluster_phi2_iso=cluster_phi2_iso(3:5,:);
    cluster_phi1_dip=cluster_phi1_dip(3:5,:);
    cluster_phi2_dip=cluster_phi2_dip(3:5,:);
else
    XtickFiguras=['20 sensores';'50 sensores'];
    eficiencia_phi1_iso=eficiencia_phi1_iso(4:5,:);
    eficiencia_phi2_iso=eficiencia_phi2_iso(4:5,:);
    eficiencia_phi1_dip=eficiencia_phi1_dip(4:5,:);
    eficiencia_phi2_dip=eficiencia_phi2_dip(4:5,:);
    cluster_phi1_iso=cluster_phi1_iso(4:5,:);
    cluster_phi2_iso=cluster_phi2_iso(4:5,:);
    cluster_phi1_dip=cluster_phi1_dip(4:5,:);
    cluster_phi2_dip=cluster_phi2_dip(4:5,:);
end
eje_X=(0.5:length(eficiencia_phi1_iso(:,1)):length(eficiencia_phi1_iso(:,1))+0.5);

if clusters_fijados ~= '0'
counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_phi1_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_iso(:,1)),mean(eficiencia_phi1_iso,2),'r','LineWidth',2);hold off;grid on;
title(['Clusters: ' clusters_fijados caso_titulo 'Isotrópica, \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_phi1_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_dip(:,1)),mean(eficiencia_phi1_dip,2),'r','LineWidth',2);hold off;grid on;
title(['Clusters: ' clusters_fijados caso_titulo 'Dipolo, \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(eficiencia_phi2_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_iso(:,1)),mean(eficiencia_phi2_iso,2),'r','LineWidth',2);hold off;grid on;
title(['Clusters: ' clusters_fijados caso_titulo 'Isotrópica, \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,4);bar(eficiencia_phi2_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_dip(:,1)),mean(eficiencia_phi2_dip,2),'r','LineWidth',2);hold off;grid on;
title(['Clusters: ' clusters_fijados caso_titulo 'Dipolo, \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);

else
    
counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_phi1_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_iso(:,1)),mean(eficiencia_phi1_iso,2),'r','LineWidth',2);hold off;grid on;
title([caso_titulo 'Isotrópica, \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_phi1_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi1_dip(:,1)),mean(eficiencia_phi1_dip,2),'r','LineWidth',2);hold off;grid on;
title([caso_titulo 'Dipolo, \it\theta = 45º, \phi = 0º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_phi1_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_phi1_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

counter=counter+1;figura(counter)=figure;
subplot(2,2,1);bar(eficiencia_phi2_iso);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_iso(:,1)),mean(eficiencia_phi2_iso,2),'r','LineWidth',2);hold off;grid on;
title([caso_titulo 'Isotrópica, \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,2);bar(eficiencia_phi2_dip);hold on;plot(eje_X,[1 1],'k');plot(1:length(eficiencia_phi2_dip(:,1)),mean(eficiencia_phi2_dip,2),'r','LineWidth',2);hold off;grid on;
title([caso_titulo 'Dipolo, \it\theta = 45º, \phi = 45º']);xlabel('Diferentes escenarios');ylabel('Eficiencia');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);
subplot(2,2,3);bar(cluster_phi2_iso);
title('Clusters: Isotrópica');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);
subplot(2,2,4);bar(cluster_phi2_dip);
title('Clusters: Dipolo');xlabel('Diferentes escenarios');ylabel('Clusters');set(gca,'XtickLabel',XtickFiguras);%axis([0.5 length(eficiencia_5_iso_estacion_1(:,1))+0.5 0 20]);%axis([1 length(eficiencia_phi2_iso(:,1))+0.3 0 max(max(eficiencia_phi1_iso))+0.3]);

end

if guardar
    archivo_a_guardar='eficiencia_maximas_';
    
    savefig(figura,[archivo_a_guardar casos_a_cargar 'clusters_fijados=' clusters_fijados '.fig'])
end
clusters_fijados=str2num(clusters_fijados);
cd ..
end