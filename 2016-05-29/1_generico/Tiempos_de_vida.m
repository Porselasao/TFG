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
    dimensiones=size(minimo_beam);
    c_antenas=dimensiones(1);
    c_antenas_archivo(ind_sim)=dimensiones(1);
    c_sensor=dimensiones(2);
    c_phi=dimensiones(3);
    c_theta=dimensiones(4);

    % Numero_de_sensores=10;
    for  c_antenas_ind=1:c_antenas
        c_antenas_ind
            for  c_phi_ind=1:c_phi
                c_phi
                for  c_theta_ind=1:c_theta  
                    c_theta
                    for i=1:tiempo_de_simulacion
                        i
                        c_cluster=zeros(1,Numero_de_sensores)
                        for n=1:Numero_de_sensores
                            n
                            cluster=idx_global{c_antenas_ind,c_theta_ind,c_phi_ind,1,i}(n);
                            cluster2{c_antenas_ind,c_phi_ind,c_theta_ind,i,ind_sim}(n)=idx_global{c_antenas_ind,c_theta_ind,c_phi_ind,1,i}(n);
                            c_cluster(cluster)=c_cluster(cluster)+1;
                            T_vida{c_antenas_ind,c_phi_ind,c_theta_ind,i,ind_sim}(n)=Tiempo_de_vida_beam{c_antenas_ind,c_theta_ind,c_phi_ind,1,i,cluster}(c_cluster(cluster));
                            Potencia_sensores_todos{ind_sim}=Potencia_sensores{1};
                        end
                    end
                end
            end
    end
end
                        
%%

ind_sim=0
vector_thetas=theta;
vector_phis=phi;
for simulacion=n_simu_cargadas
    ind_sim=ind_sim+1;
   
                       
        for  c_phi_ind=1:c_phi
          
            for  c_theta_ind=1:c_theta  
             
                for  c_antenas_ind=1:c_antenas
                 
                    figure
                    
                    for i=1:tiempo_de_simulacion
                    
                    subplot(2,10,i);bar(T_vida{c_antenas_ind,c_phi_ind,c_theta_ind,i,ind_sim});
                    H1=ylabel('Tiempo de vida');
                     H3=xlabel('Different Scenarios');
    %                set(gca,'XtickLabel',Sensores_xtick)
                    %set(H1,'LineWidth',2,'FontSize',16);
                    %set(H2,'LineWidth',2,'FontSize',16);
                    %set(H3,'LineWidth',2,'FontSize',16);grid on;
                    %set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;

                    a=cluster2{c_antenas_ind,c_phi_ind,c_theta_ind,i,ind_sim};
                    subplot(2,10,10+i);H0=bar(a);
                    ylabel('Number of cluster');
                    H1=ylabel('Number of cluster');

                    H3=xlabel('Different Scenarios');
                    %set(gca,'XtickLabel',Sensores_xtick)
                    %set(H1,'LineWidth',2,'FontSize',16);

                    %set(H3,'LineWidth',2,'FontSize',16);grid on;
                    %set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
                    end
                 H2=title(['Meas=' num2str(simulacion) ' Phi=' num2str(vector_phis(c_phi_ind))  'º Theta=' num2str( vector_thetas(c_theta_ind)) 'º ANTENA=' num2str( c_antenas_ind) ]);
                set(H2,'LineWidth',2,'FontSize',16);
             end
        end
        
    end
end                  
               

%%
ind_sim=0
vector_thetas=theta;
vector_phis=phi;
for simulacion=n_simu_cargadas
    ind_sim=ind_sim+1;
   
                       
        for  c_phi_ind=1:c_phi
          
            for  c_theta_ind=1:c_theta  
             
                for  c_antenas_ind=1:c_antenas
                 
                    figure
                    
                    for i=1:tiempo_de_simulacion
                    
                    subplot(3,1,1);plot(T_vida{c_antenas_ind,c_phi_ind,c_theta_ind,i,ind_sim});
                    hold on;grid on;
                    ylabel('Number of cluster');
                    H1=ylabel('Tiempo de vida');
                     H3=xlabel('Different Scenarios');
    %                set(gca,'XtickLabel',Sensores_xtick)
                    %set(H1,'LineWidth',2,'FontSize',16);
                    %set(H2,'LineWidth',2,'FontSize',16);
                    %set(H3,'LineWidth',2,'FontSize',16);grid on;
                    %set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;

                    a=cluster2{c_antenas_ind,c_phi_ind,c_theta_ind,i,ind_sim};
                    subplot(3,1,2);H0=plot(a);hold on;grid on;
                    ylabel('Number of cluster');
                    H1=ylabel('Number of cluster');

                    H3=xlabel('Different Scenarios');
                    %set(gca,'XtickLabel',Sensores_xtick)
                    %set(H1,'LineWidth',2,'FontSize',16);

                    %set(H3,'LineWidth',2,'FontSize',16);grid on;
                    %set(gca,'FontSize',16); set(gcf,'color',[1,1,1]) ;
                    a=Potencia_sensores_todos{ind_sim};
                    subplot(3,1,3);H0=plot(a);hold on;grid on;
                    ylabel('Number of cluster');
                    H1=ylabel('Number of cluster');

                    H3=xlabel('Different Scenarios');
                    end
                 H2=title(['Meas=' num2str(simulacion) ' Phi=' num2str(vector_phis(c_phi_ind))  'º Theta=' num2str( vector_thetas(c_theta_ind)) 'º ANTENA=' num2str( c_antenas_ind) ]);
                set(H2,'LineWidth',2,'FontSize',16);
             end
        end
        
    end
end                  
