clear
load caso_102_ejecucion_1clusters1.mat;
clearvars -regexp directividad Potencia_r Tiempo minimo
c_antenas=1;c_sensores=1;instante=1;

cd ..
for j=1:length(estacion(:,1))
    for k=1:length(mejor_centro_cluster(:,1))
        
        [distancia{c_antenas,c_sensores,instante,j,k},theta_cluster{c_antenas,c_sensores,instante,j,k},phi_cluster{c_antenas,c_sensores,instante,j,k}]=cart2sph2(estacion(j,:)-mejor_centro_cluster(k,:));
        
        [Etot_deseada{c_antenas,c_sensores,instante,j,k},Ptot_deseada{c_antenas,c_sensores,instante,j,k},directividad_deseada{c_antenas,c_sensores,instante,j,k},Thmax,Phmax,directividad_buscada_deseada{c_antenas,c_sensores,instante,j,k}] = ...
            Calacula_Campo_entero(array_config(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,theta_cluster{c_antenas,c_sensores,instante,j,k},phi_cluster{c_antenas,c_sensores,instante,j,k});
        
        sensores_cluster_actual=sum(idx_global{c_antenas,c_sensores,instante}==k);
        sincronismo=calcular_sincronismo(sensores_cluster_actual);
        Potencia_radiada_deseada{c_antenas,c_sensores,instante,j,k}=reshape(array_config(1,5,mejor_idx==k),1,sum(mejor_idx==k),1,1)*sincronismo; %10.^(mejor_x(mejor_idx==k))*sincronismo;
        Potencia_recibida_deseada{c_antenas,c_sensores,instante,j,k}=((10^(directividad_buscada_deseada{c_antenas,c_sensores,instante,j,k}/10))*(LANDA)^2/(4*distancia{c_antenas,c_sensores,instante,j,k}*pi))^2./Potencia_radiada_deseada{c_antenas,c_sensores,instante,j,k};
        Tiempo_de_vida_beam_deseada{c_antenas,c_sensores,instante,j,k}=Potencia_sensores{c_sensores}(mejor_idx==k).*Potencia_recibida_deseada{c_antenas,c_sensores,instante,j,k}/sensores_cluster_actual;
        minimo_cluster_deseada{c_antenas,c_sensores,instante,j}(k)=min(Tiempo_de_vida_beam_deseada{c_antenas,c_sensores,instante,j,k});
    end
    minimo_beam_deseada{c_antenas,c_sensores,instante}(j)=min(minimo_cluster_deseada{c_antenas,c_sensores,instante,j});
end

for j=1:length(estacion(:,1))
    for i=1:Numero_de_sensores
        
        [distancia1,thetabuscado1,phibuscado1]=cart2sph2(estacion(j,:)-[posicion_X{c_sensores}(i,instante) posicion_Y{c_sensores}(i,instante) posicion_Z{c_sensores}(i,instante)]);
        
        [Etot_deseada_1{c_antenas,c_sensores,instante,j,i},Ptot_deseada_1{c_antenas,c_sensores,instante,j,i},directividad_deseada_1,Thmax1,Phmax1,directividad_buscada_deseada_1{c_antenas,c_sensores,instante,j,i}] = ...
            Calacula_Campo_entero(array_config1(:,:,1),freq_config,range_config,deltheta1,delphi1,thetabuscado1,phibuscado1);
        
        Potencia_radiada_buscada1{c_antenas,c_sensores,instante,j,i}=reshape(array_config1(1,5,i),1,cantidad_de_sensores,1,1);
        Potencia_recibida_buscada1{c_antenas,c_sensores,instante,j,i}=((10^(directividad_buscada_deseada_1{c_antenas,c_sensores,instante,j,i}/10))*(LANDA)^2/(4*distancia1*pi))^2./Potencia_radiada_buscada1{c_antenas,c_sensores,instante,j,i}; % Añadido un "."
        Tiempo_de_vida_beam_buscada1{c_antenas,c_sensores,instante,j}(i)=Potencia_sensores{c_sensores}(i).*Potencia_recibida_buscada1{c_antenas,c_sensores,instante,j,i};
    end
    minimo_beam1{c_antenas,c_sensores,instante}(j)=min(Tiempo_de_vida_beam_buscada1{c_antenas,c_sensores,instante,j});
end

cd nuevos
save campo;

cd ..
j=1;k=1;
[distancia,theta_cluster,phi_cluster]=cart2sph2(estacion_no_deseada(j,:)-mejor_centro_cluster(k,:));

cd nuevos