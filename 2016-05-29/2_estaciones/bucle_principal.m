
% Este script es el scrip de funcionamiento general del sistema donde se inician todas las variables 
% clear

global mejor_idx;
global mejor_centro_cluster;
global mejor_scores;
global mejor_x;
global estacion;
global estacion_no_deseada;
global estacion_si;
global estacion_no_deseada_si;
global mejor_estacion;

c_sensores=1;

for Numero_de_sensores=sensores
    Numero_de_sensores


% Frecuencia de funcionamiento
freq_config=300e6;
range_config=999; % Punto de campo lejano cuanto más grande más preciso y más lento

% La carga que van a tener los sensores para emitir
if potencia_fija
    Potencia_sensores{c_sensores}=ones(1,Numero_de_sensores);
else
    Potencia_sensores{c_sensores}=0.2*ones(1,Numero_de_sensores)+0.8*rand(1,Numero_de_sensores);
end

if sensores_fijos
    for i=1:tiempo_de_simulacion
        posicion_X{c_sensores}=dim_x*rand(Numero_de_sensores,tiempo_de_simulacion);
    end
    if dim_y
        posicion_Y{c_sensores}=dim_y*rand(Numero_de_sensores,tiempo_de_simulacion);
    else
        posicion_Y{c_sensores}=zeros(Numero_de_sensores,tiempo_de_simulacion);
    end
    if dim_z
        posicion_Z{c_sensores}=dim_z*rand(Numero_de_sensores,tiempo_de_simulacion);
    else
        posicion_Z{c_sensores}=zeros(Numero_de_sensores,tiempo_de_simulacion);
    end
else  % Nodos móviles
    [s_mobility]=movilidad(tiempo_de_simulacion,Numero_de_sensores,dim_x,dim_y,dim_z);
    
    for nodos=1:Numero_de_sensores
        posicion_X{c_sensores}(nodos,1:tiempo_de_simulacion)=s_mobility.VS_NODE(nodos).V_POSITION_X(1:tiempo_de_simulacion);
        posicion_Y{c_sensores}(nodos,1:tiempo_de_simulacion)=s_mobility.VS_NODE(nodos).V_POSITION_Y(1:tiempo_de_simulacion);
        if dim_z
            posicion_Z{c_sensores}(nodos,1:tiempo_de_simulacion)=s_mobility.VS_NODE(nodos).V_POSITION_Z(1:tiempo_de_simulacion);
        else
            posicion_Z{c_sensores}=zeros(Numero_de_sensores,tiempo_de_simulacion);
        end
    end

end

% El tipo de antena que se va a escoger
%              STRING    VALUE IN array_config
%              'iso'             0
%              'patchr'          1
%              'patchc'          2
%              'dipole'          3
%              'dipoleg'         4
%              'helix'           5
%              'aprect'          6
%              'apcirc'          7
%              'wgr'             8
%              'wgc'             9
%              'dish'            10
%              'interp'          11
%              'user1'           12 
 
LANDA=1;

c_antenas=1;
for tipo_antena=antenas
    
    array_config4=- ones(3,5,Numero_de_sensores);

    for instante=1:(tiempo_de_simulacion)
        
        clear array_config
                
        amplitud=0;
        fase=0;
        for i=1:Numero_de_sensores
            array_config2(:,:,i)=place_element(array_config4,posicion_X{c_sensores}(i,instante),posicion_Y{c_sensores}(i,instante),posicion_Z{c_sensores}(i,instante),tipo_antena, amplitud,fase);        
        end
        array_config=array_config2;
        
        mejor_scores=10^16;
        [array_config]=optimiza(Potencia_sensores{c_sensores},freq_config,Numero_de_sensores,posicion_X{c_sensores}(:,instante),posicion_Y{c_sensores}(:,instante),posicion_Z{c_sensores}(:,instante),range_config,array_config,generaciones,poblacion,clusters_fijados); 

        idx_global{c_antenas,c_sensores,instante}=mejor_idx;
        centro_cluster_global{c_antenas,c_sensores,instante}=mejor_centro_cluster;
        
        array_resultado{c_antenas,c_sensores,instante}=array_config;
        
        if estacion_si
            for j=1:length(estacion(:,1))
                for k=1:length(mejor_centro_cluster(:,1))

                    [distancia_deseada{c_antenas,c_sensores,instante,j,k},theta_cluster_deseada{c_antenas,c_sensores,instante,j,k},phi_cluster_deseada{c_antenas,c_sensores,instante,j,k}]=cart2sph2(estacion(j,:)-mejor_centro_cluster(k,:));

                    [Etot_deseada{c_antenas,c_sensores,instante,j,k},Ptot_deseada{c_antenas,c_sensores,instante,j,k},directividad_deseada{c_antenas,c_sensores,instante,j,k},Thmax,Phmax,directividad_buscada_deseada{c_antenas,c_sensores,instante,j,k}] = ...
                       Calcula_Campo_entero(array_config(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,theta_cluster_deseada{c_antenas,c_sensores,instante,j,k},phi_cluster_deseada{c_antenas,c_sensores,instante,j,k});
                    
                    sensores_cluster_actual=sum(idx_global{c_antenas,c_sensores,instante}==k);
                    sincronismo=calcular_sincronismo(sensores_cluster_actual);
                    Potencia_radiada_deseada{c_antenas,c_sensores,instante,j,k}=reshape(array_config(1,5,mejor_idx==k),1,sum(mejor_idx==k),1,1)*sincronismo; %10.^(mejor_x(mejor_idx==k))*sincronismo;
                    Potencia_recibida_deseada{c_antenas,c_sensores,instante,j,k}=((10^(directividad_buscada_deseada{c_antenas,c_sensores,instante,j,k}/10))*(LANDA)^2/(4*distancia_deseada{c_antenas,c_sensores,instante,j,k}*pi))^2./Potencia_radiada_deseada{c_antenas,c_sensores,instante,j,k};      
                    Tiempo_de_vida_beam_deseada{c_antenas,c_sensores,instante,j,k}=Potencia_sensores{c_sensores}(mejor_idx==k).*Potencia_recibida_deseada{c_antenas,c_sensores,instante,j,k}/sensores_cluster_actual;
                    minimo_cluster_deseada{c_antenas,c_sensores,instante,j}(k)=min(Tiempo_de_vida_beam_deseada{c_antenas,c_sensores,instante,j,k});
                end
                minimo_beam_deseada{c_antenas,c_sensores,instante}(j)=min(minimo_cluster_deseada{c_antenas,c_sensores,instante,j});
            end
        end
        
         %% Para estaciones no deseadas con beamforming
        if estacion_no_deseada_si
            for j=1:length(estacion_no_deseada(:,1))
                for k=1:length(mejor_centro_cluster(:,1))
                    
                    [distancia_no_deseada{c_antenas,c_sensores,instante,j,k},theta_cluster_no_deseada{c_antenas,c_sensores,instante,j,k},phi_cluster_no_deseada{c_antenas,c_sensores,instante,j,k}]=cart2sph2(estacion_no_deseada(j,:)-mejor_centro_cluster(k,:));

                    [Etot_no_deseada{c_antenas,c_sensores,instante,j,k},Ptot_no_deseada{c_antenas,c_sensores,instante,j,k},directividad_no_deseada{c_antenas,c_sensores,instante,j,k},Thmax,Phmax,directividad_buscada_no_deseada{c_antenas,c_sensores,instante,j,k}] = ...
                       Calcula_Campo_entero(array_config(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,theta_cluster_no_deseada{c_antenas,c_sensores,instante,j,k},phi_cluster_no_deseada{c_antenas,c_sensores,instante,j,k});

                    sensores_cluster_actual=sum(idx_global{c_antenas,c_sensores,instante}==k);
                    sincronismo=calcular_sincronismo(sensores_cluster_actual);
                    Potencia_radiada_no_deseada{c_antenas,c_sensores,instante,j,k}=reshape(array_config(1,5,mejor_idx==k),1,sum(mejor_idx==k),1,1)*sincronismo; %10.^(mejor_x(mejor_idx==k))*sincronismo;
                    Potencia_recibida_no_deseada{c_antenas,c_sensores,instante,j,k}=((10^(directividad_buscada_no_deseada{c_antenas,c_sensores,instante,j,k}/10))*(LANDA)^2/(4*distancia_no_deseada{c_antenas,c_sensores,instante,j,k}*pi))^2./Potencia_radiada_no_deseada{c_antenas,c_sensores,instante,j,k};      
                    Tiempo_de_vida_beam_no_deseada{c_antenas,c_sensores,instante,j,k}=Potencia_sensores{c_sensores}(mejor_idx==k).*Potencia_recibida_no_deseada{c_antenas,c_sensores,instante,j,k}/sensores_cluster_actual;
                    minimo_cluster_no_deseada{c_antenas,c_sensores,instante,j}(k)=min(Tiempo_de_vida_beam_no_deseada{c_antenas,c_sensores,instante,j,k});
                end
                minimo_beam_no_deseada{c_antenas,c_sensores,instante}(j)=min(minimo_cluster_no_deseada{c_antenas,c_sensores,instante,j});
            end
        end

    %% Cálculo de la mejora de eficiencia frente al no uso de beamforming.
    
    clear array_config3

    cantidad_de_sensores=1;

    amplitud1{c_antenas,c_sensores,instante}=20*log10(sqrt(1/Numero_de_sensores*sum(array_resultado{c_antenas,c_sensores,instante}(1,5,1:Numero_de_sensores)^2)));
            
    for i=1:Numero_de_sensores
        array_config3(:,:,i)=place_element(array_config4,posicion_X{c_sensores}(i,instante),posicion_Y{c_sensores}(i,instante),posicion_Z{c_sensores}(i,instante),tipo_antena,amplitud1{c_antenas,c_sensores,instante},fase);
    end
    array_config1=array_config3;
    
    array_resultado1{c_antenas,c_sensores,instante}=array_config1;     
    
    if estacion_si
        for j=1:length(estacion(:,1))
            for i=1:Numero_de_sensores

                [distancia1,thetabuscado1,phibuscado1]=cart2sph2(estacion(j,:)-[posicion_X{c_sensores}(i,instante) posicion_Y{c_sensores}(i,instante) posicion_Z{c_sensores}(i,instante)]);

                [Etot_deseada_1{c_antenas,c_sensores,instante,j,i},Ptot_deseada_1{c_antenas,c_sensores,instante,j,i},directividad_deseada_1,Thmax1,Phmax1,directividad_buscada_deseada_1{c_antenas,c_sensores,instante,j,i}] = ...
                    Calcula_Campo_entero(array_config1(:,:,1),freq_config,range_config,deltheta1,delphi1,thetabuscado1,phibuscado1);
                
                Potencia_radiada_buscada1{c_antenas,c_sensores,instante,j,i}=reshape(array_config1(1,5,i),1,cantidad_de_sensores,1,1);
                Potencia_recibida_buscada1{c_antenas,c_sensores,instante,j,i}=((10^(directividad_buscada_deseada_1{c_antenas,c_sensores,instante,j,i}/10))*(LANDA)^2/(4*distancia1*pi))^2./Potencia_radiada_buscada1{c_antenas,c_sensores,instante,j,i}; % Añadido un "."
                Tiempo_de_vida_beam_buscada1{c_antenas,c_sensores,instante,j}(i)=Potencia_sensores{c_sensores}(i).*Potencia_recibida_buscada1{c_antenas,c_sensores,instante,j,i};
            end
            minimo_beam1{c_antenas,c_sensores,instante}(j)=min(Tiempo_de_vida_beam_buscada1{c_antenas,c_sensores,instante,j});
        end
    end
    
    %% Para no deseadas
    if estacion_no_deseada_si
        for j=1:length(estacion_no_deseada(:,1))
            for i=1:Numero_de_sensores

                [distancia1,thetabuscado1,phibuscado1]=cart2sph2(estacion_no_deseada(j,:)-[posicion_X{c_sensores}(i,instante) posicion_Y{c_sensores}(i,instante) posicion_Z{c_sensores}(i,instante)]);

                [Etot_no_deseada_1{c_antenas,c_sensores,instante,j,i},Ptot_no_deseada_1{c_antenas,c_sensores,instante,j,i},directividad_deseada_1,Thmax1,Phmax1,directividad_buscada_no_deseada_1{c_antenas,c_sensores,instante,j,i}] = ...
                    Calcula_Campo_entero(array_config1(:,:,1),freq_config,range_config,deltheta1,delphi1,thetabuscado1,phibuscado1);
                
                Potencia_radiada_no_buscada1{c_antenas,c_sensores,instante,j,i}=reshape(array_config1(1,5,i),1,cantidad_de_sensores,1,1);
                Potencia_recibida_no_buscada1{c_antenas,c_sensores,instante,j,i}=((10^(directividad_buscada_no_deseada_1{c_antenas,c_sensores,instante,j,i}/10))*(LANDA)^2/(4*distancia1*pi))^2./Potencia_radiada_no_buscada1{c_antenas,c_sensores,instante,j,i}; % Añadido un "."
                Tiempo_de_vida_beam_no_buscada1{c_antenas,c_sensores,instante,j}(i)=Potencia_sensores{c_sensores}(i).*Potencia_recibida_no_buscada1{c_antenas,c_sensores,instante,j,i};
            end
            minimo_beam1_no_deseada{c_antenas,c_sensores,instante}(j)=min(Tiempo_de_vida_beam_no_buscada1{c_antenas,c_sensores,instante,j});
        end
    end
    end
        
c_antenas=c_antenas+1;
end
c_sensores=c_sensores+1;
end
