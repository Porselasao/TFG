%% Ejemplo de representación
clear all

ind_sim=0;
c_sensor_ind=1;

sensores2=[1,7,13,19,25,31];
sensores2_no_move=[1,7,25,31];

sensores4=[2,8,14,20,26,32];
sensores4_no_move=[2,8,26,32];

sensores5=[3,9,15,21,27,33];
sensores5_no_move=[3,9,27,33];
sensores10=[4,10,16,22,28,34];
sensores10_no_move=[4,10,28,34];
sensores20=[5,6,11,12,17,18,23,24, 29,30,35,36];
sensores20_no_move=[5,6,11,12,29,30,35,36];

cont_ante=0;
ind_sim=0;
n_simu_cargadas=sensores20_no_move; 
n_simu_cargadas=[3,9,27,33,4,10,28,34,5,6,11,12,29,30,35,36]
%% Carga de ficheros

for simulacion=n_simu_cargadas
    ind_sim=ind_sim+1;
    clear -regexp ^Etot ^Ptot ;
    load(strcat('caso_',num2str(simulacion),'.mat'));
% 
% 
%             caso='Caso base';

    dimensiones=size(minimo_beam);
    c_antenas=dimensiones(1);
    c_antenas_archivo(ind_sim)=dimensiones(1);
    c_sensor=dimensiones(2);
    c_phi=dimensiones(3);
    c_theta=dimensiones(4);

    % Numero_de_sensores=10;
    for  c_antenas_ind=1:c_antenas
        if     c_antenas_ind==2;
        cont_ante=cont_ante+1
        end
            for  c_phi_ind=1:c_phi
                for  c_theta_ind=1:c_theta  
                    for i=1:tiempo_de_simulacion
                        eficiencia(i,ind_sim,c_antenas_ind,c_phi_ind,c_theta_ind)=minimo_beam{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i}./minimo_beam1{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i};
                        n_cluster(i,ind_sim,c_antenas_ind,c_phi_ind,c_theta_ind)=max(idx_global{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i});
                        efic_all_antena(i,ind_sim+cont_ante,c_phi_ind,c_theta_ind)=minimo_beam{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i}./minimo_beam1{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i};
                        n_clust_all_antena(i,ind_sim+cont_ante,c_phi_ind,c_theta_ind)=max(idx_global{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i});

                    end
                end
            end


    end 
end

save resultados eficiencia* n_cluster*


%% Pinta para cada una de las direcciones  y cada una de las antenas
vector_thetas=theta;
vector_phis=phi;
%Sensores_xtick=['Iso Pow. Fix 2D ';'Dip Pot. Fix 2D ';'Iso Pow. Rand 2D';'Dip Pot. Rand 2D';'Iso Pow. Fix 3D ';'Dip Pot. Fix 3D ';'Iso Pow. Rand 3D';'Dip Pot. Rand 3D'];
for  c_phi_ind=1:c_phi
        for  c_theta_ind=1:c_theta  
            for  c_antenas_ind=1:c_antenas
                figure
                subplot(2,1,1);H0=bar(eficiencia(:,:,c_antenas_ind,c_phi_ind,c_theta_ind)');
                H1=ylabel('Gain');
                H2=title(['Phi=' num2str(vector_phis(c_phi_ind))  'º Theta=' num2str( vector_thetas(c_theta_ind)) 'º ANTENA=' num2str( c_antenas_ind) ]);
                H3=xlabel('Different Scenarios');
%                set(gca,'XtickLabel',Sensores_xtick)
                set(H1,'LineWidth',2,'FontSize',16);
                set(H2,'LineWidth',2,'FontSize',24);
                set(H3,'LineWidth',2,'FontSize',16);grid on;
                set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
                subplot(2,1,2);bar(n_cluster(:,:,c_antenas_ind,c_phi_ind,c_theta_ind)');
                ylabel('Number of cluster');
                H1=ylabel('Number of cluster');

                H3=xlabel('Different Scenarios');
                %set(gca,'XtickLabel',Sensores_xtick)
                set(H1,'LineWidth',2,'FontSize',16);

                set(H3,'LineWidth',2,'FontSize',16);grid on;
                set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
            end
        end
end

%% Pinta para cada una de las direcciones  todas las antenas


%Sensores_xtick=['Iso Pow. Fix 2D ';'Dip Pot. Fix 2D ';'Iso Pow. Rand 2D';'Dip Pot. Rand 2D';'Iso Pow. Fix 3D ';'Dip Pot. Fix 3D ';'Iso Pow. Rand 3D';'Dip Pot. Rand 3D'];
for  c_phi_ind=1:c_phi
        for  c_theta_ind=1:c_theta  

                figure
                subplot(2,1,1);H0=bar(efic_all_antena(:,:,c_phi_ind,c_theta_ind)');
                H1=ylabel('Gain');
                H2=title(['Phi=' num2str(vector_phis(c_phi_ind))  'º Theta=' num2str( vector_thetas(c_theta_ind)) 'º ' ]);
                H3=xlabel('Different Scenarios');
 %               set(gca,'XtickLabel',Sensores_xtick)
                set(H1,'LineWidth',2,'FontSize',16);
                set(H2,'LineWidth',2,'FontSize',24);
                set(H3,'LineWidth',2,'FontSize',16);grid on;
                set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
                subplot(2,1,2);bar(n_clust_all_antena(:,:,c_phi_ind,c_theta_ind)');
                ylabel('Number of cluster');
                H1=ylabel('Number of cluster');

                H3=xlabel('Different Scenarios');
              %  set(gca,'XtickLabel',Sensores_xtick)
                set(H1,'LineWidth',2,'FontSize',16);

                set(H3,'LineWidth',2,'FontSize',16);grid on;
                set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
            
        end
end

%% Pinta para todas las direcciones juntas diferentes antenas

ef_all_directions=[];
n_cluster_all_directions=[];
for  c_phi_ind=1:c_phi
        for  c_theta_ind=1:c_theta
            ef_all_directions=[ef_all_directions;efic_all_antena(:,:,c_phi_ind,c_theta_ind)];
            n_cluster_all_directions=[n_cluster_all_directions;n_clust_all_antena(:,:,c_phi_ind,c_theta_ind)];
        end
end

%Sensores_xtick=['F. 1 A1';'F. 2 A2';'F. 3 A1';'F. 4 A2';'F. 5 A1';'F. 6 A2';'F. 7 A1';'F. 8 A2'];

figure
subplot(2,1,1);H0=bar(ef_all_directions');
H1=ylabel('Gain');
H3=xlabel('Different Scenarios');
%set(gca,'XtickLabel',Sensores_xtick)
set(H1,'LineWidth',2,'FontSize',16);
%set(H2,'LineWidth',2,'FontSize',24);
set(H3,'LineWidth',2,'FontSize',16);grid on;
set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
subplot(2,1,2);bar(n_cluster_all_directions');
ylabel('Number of cluster');
H1=ylabel('Number of cluster');

H3=xlabel('Different Scenarios');
%set(gca,'XtickLabel',Sensores_xtick)
set(H1,'LineWidth',2,'FontSize',16);

set(H3,'LineWidth',2,'FontSize',16);grid on;
set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;


%% Pinta para todas las direcciones juntas y todas las antenas juntas

ef_all=[];
n_cluster_all=[];
contador=0;
ind_sim=0;
for simulacion=n_simu_cargadas
     ind_sim=ind_sim+1;
     ef_all=[];
     n_cluster_all=[];
     for  indice=1:c_antenas_archivo(ind_sim)
            contador=contador+1
            ef_all=[ef_all;ef_all_directions(:,contador)];
            n_cluster_all=[n_cluster_all;n_cluster_all_directions(:,contador)];
     end
     ef_all1(:,ind_sim)=ef_all;
     n_cluster_all1(:,ind_sim)=n_cluster_all;
end

%Sensores_xtick=['F. 1 A1';'F. 2 A2';'F. 3 A1';'F. 4 A2';'F. 5 A1';'F. 6 A2';'F. 7 A1';'F. 8 A2'];

figure
subplot(2,1,1);H0=bar(ef_all1');
H1=ylabel('Gain');
H3=xlabel('Different Scenarios');
%set(gca,'XtickLabel',Sensores_xtick)
set(H1,'LineWidth',2,'FontSize',16);
set(H2,'LineWidth',2,'FontSize',24);
set(H3,'LineWidth',2,'FontSize',16);grid on;
set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
subplot(2,1,2);bar(n_cluster_all1');
ylabel('Number of cluster');
H1=ylabel('Number of cluster');

H3=xlabel('Different Scenarios');
%set(gca,'XtickLabel',Sensores_xtick)
set(H1,'LineWidth',2,'FontSize',16);

set(H3,'LineWidth',2,'FontSize',16);grid on;
set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;


