%% Ejemplo de representaci?n
clear all
cont_ante=0;
for simulacion=1:12

    simulacion
    
clear -regexp ^Etot ^Ptot ;
load(strcat('caso_',num2str(simulacion),'.mat'));


caso='Caso base';

dimensiones=size(minimo_beam);
c_antenas=dimensiones(1);
cont_ante=cont_ante+c_antenas-1;
c_sensor=dimensiones(2);
c_phi=dimensiones(3);
c_theta=dimensiones(4);

% Numero_de_sensores=10;
for  c_antenas_ind=1:c_antenas
    for  c_sensor_ind=1:c_sensor
        for  c_phi_ind=1:c_phi
            for  c_theta_ind=1:c_theta  
                for i=1:tiempo_de_simulacion
                    eficiencia(i,simulacion,c_antenas_ind,c_phi_ind,c_theta_ind)=minimo_beam{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i}./minimo_beam1{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i};
                    n_cluster(i,simulacion,c_antenas_ind,c_phi_ind,c_theta_ind)=max(idx_global{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i});
                    eficiencia2(i,simulacion+cont_ante,c_phi_ind,c_theta_ind)=minimo_beam{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i}./minimo_beam1{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i};
                    n_cluster2(i,simulacion+cont_ante,c_phi_ind,c_theta_ind)=max(idx_global{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i});
                    eficiencia3(i,simulacion+cont_ante)=minimo_beam{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i}./minimo_beam1{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i};
                    n_cluster3(i,simulacion+cont_ante)=max(idx_global{c_antenas_ind,c_sensor_ind,c_phi_ind,c_theta_ind,i});
                end
            end
        end
    end

end 


end
save resultados eficiencia* n_cluster*
figure
subplot(2,1,1);bar(eficiencia3')
subplot(2,1,2);bar(n_cluster3')
figure
subplot(2,1,1);bar(eficiencia2(:,:,1,1)');
subplot(2,1,2);bar(n_cluster2(:,:,1,1)');

figure
subplot(2,1,1);bar(eficiencia2(:,:,2,1)');
subplot(2,1,2);bar(n_cluster2(:,:,2,1)');

