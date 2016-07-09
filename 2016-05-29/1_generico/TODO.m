
% Este script es el scrip de funcionamiento general del sistema donde se inician todas las variables 
% clear

global mejor_idx;
global mejor_centro_cluster;
global mejor_scores;
global mejor_x;

c_sensores=1;
for Numero_de_sensores=sensores
% clc
Numero_de_sensores

% Frecuencia de funcionamiento
freq_config=300e6;          % Set analysis frequency to 300MHz (lambda=1m)
% tiempo_de_simulacion=10;    % Cuanto más tiempo, más posiciones y más cálculo
% Numero_de_sensores=5;       % Con esta variable se juega durante todo el script
range_config=999; % Punto de campo lejano cuanto m?s grande m?s preciso y m?s lento

% La potencia que van a tener los sensores para emitir
% Dos opciones o fija o variable ramdom con un minimo

if potencia_fija
    Potencia_sensores{c_sensores}=ones(1,Numero_de_sensores);
else
    Potencia_sensores{c_sensores}=0.2*ones(1,Numero_de_sensores)+0.8*rand(1,Numero_de_sensores);
%     Potencia_sensores{c_sensores}=[0.2 0.4 0.6 0.8 1];
end

if sensores_fijos
    for i=1:tiempo_de_simulacion
%         posicion_X{c_sensores}=dim_x*rand(Numero_de_sensores,tiempo_de_simulacion);
        posicion_X{c_sensores}=[-9 -7 -5 -3 -1 1 3 5 7 9]';
    end
    if dim_y
%         posicion_Y{c_sensores}=dim_y*rand(Numero_de_sensores,tiempo_de_simulacion);
        posicion_Y{c_sensores}=[-2.23974923001422 1.79702676853675 1.55098003973841 -3.37388264805369 -3.81002318441623 -0.0163594801785705 4.59743958516081 -1.59614273333867 0.852677509797774 -2.76188060508863]';
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
 
% El porcetaje de sobrecarga que supone el número de sensores para sincronizar 
% if Numero_de_sensores<=1
%     sincronismo=1;
% elseif Numero_de_sensores<=2
%     sincronismo=1.1; 
% elseif Numero_de_sensores<=3
%     sincronismo=1.13; 
% elseif Numero_de_sensores<=4
%     sincronismo=1.14; 
% elseif Numero_de_sensores<=5
%     sincronismo=1.15; 
% elseif Numero_de_sensores<=7
%     sincronismo=1.17; 
% elseif Numero_de_sensores<=10
%     sincronismo=1.2; 
% elseif Numero_de_sensores<=15
%     sincronismo=1.25; 
% elseif Numero_de_sensores<=20
%     sincronismo=1.3;
% else
%     sincronismo=1.5;
% end
 
distancia=1;
LANDA=1;

c_antenas=1;
for tipo_antena=antenas
    tipo_antena
    
c_phi=1;
for phibuscado=phi
    phibuscado
    
c_theta=1;
for thetabuscado=theta
    thetabuscado
    
% Introduzco la posición de los sensores
    array_config4=- ones(3,5,Numero_de_sensores);  % Inicializaci?n de la variable
    % Pwr.....Power (volts^2 in dB)
    % Pha.....Phase (Deg)
    for instante=1:(tiempo_de_simulacion)
        
        clear array_config
        
%         deltheta=1;
%         delphi=1;
        
        amplitud=0;
        fase=0;
        for i=1:Numero_de_sensores
            array_config2(:,:,i)=place_element(array_config4,posicion_X{c_sensores}(i,instante),posicion_Y{c_sensores}(i,instante),posicion_Z{c_sensores}(i,instante),tipo_antena, amplitud,fase);        
        end
        array_config=array_config2;
    
        mejor_scores=10^16;
        [array_config]=optimiza_2(Potencia_sensores{c_sensores},freq_config,Numero_de_sensores,posicion_X{c_sensores}(:,instante),posicion_Y{c_sensores}(:,instante),posicion_Z{c_sensores}(:,instante),range_config,thetabuscado,phibuscado,array_config,generaciones,poblacion,clusters_fijados); 

        idx_global{c_antenas,c_sensores,c_phi,c_theta,instante}=mejor_idx;
        centro_cluster_global{c_antenas,c_sensores,c_phi,c_theta,instante}=mejor_centro_cluster;
        
        array_resultado{c_antenas,c_sensores,c_phi,c_theta,instante}=array_config;
        
        for k=1:length((mejor_centro_cluster(:,1)))
            
            [Etot{c_antenas,c_sensores,c_phi,c_theta,instante,k},Ptot{c_antenas,c_sensores,c_phi,c_theta,instante,k},directividad{c_antenas,c_sensores,c_phi,c_theta,instante,k},Thmax{c_antenas,c_sensores,c_phi,c_theta,instante,k},Phmax{c_antenas,c_sensores,c_phi,c_theta,instante,k},directividad_buscada{c_antenas,c_sensores,c_phi,c_theta,instante,k}] = ...
                Calacula_Campo_entero(array_config(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,thetabuscado,phibuscado);
            
            sensores_cluster_actual=sum(idx_global{c_antenas,c_sensores,c_phi,c_theta,instante}==k);
            sincronismo=calcular_sincronismo(sensores_cluster_actual);
            Potencia_radiada{c_antenas,c_sensores,c_phi,c_theta,instante,k}=reshape(array_config(1,5,mejor_idx==k),1,sum(mejor_idx==k),1,1)*sincronismo;
            Potencia_recibida{c_antenas,c_sensores,c_phi,c_theta,instante,k}=((10^(directividad_buscada{c_antenas,c_sensores,c_phi,c_theta,instante,k}/10))*(LANDA)^2/(4*distancia*pi))^2./Potencia_radiada{c_antenas,c_sensores,c_phi,c_theta,instante,k}; % Añadido un "."
            Tiempo_de_vida_beam{c_antenas,c_sensores,c_phi,c_theta,instante,k}=Potencia_sensores{c_sensores}(mejor_idx==k).*Potencia_recibida{c_antenas,c_sensores,c_phi,c_theta,instante,k}/sensores_cluster_actual;
            minimo_cluster{c_antenas,c_sensores,c_phi,c_theta,instante}(k)=min(Tiempo_de_vida_beam{c_antenas,c_sensores,c_phi,c_theta,instante,k});
        end
        minimo_beam{c_antenas,c_sensores,c_phi,c_theta,instante}=min(minimo_cluster{c_antenas,c_sensores,c_phi,c_theta,instante});
        
%% Calculo de la mejora de eficiencia frente al no uso de beamforming.
        clear array_config3

        cantidad_de_sensores=1;
        
%         deltheta1=1;
%         delphi1=1;
        
        amplitud1{c_antenas,c_sensores,c_phi,c_theta,instante}=20*log10(sqrt(1./Numero_de_sensores.*sum(array_resultado{c_antenas,c_sensores,c_phi,c_theta,instante}(1,5,1:Numero_de_sensores).^2)));
        
        for i=1:Numero_de_sensores
            array_config3(:,:,i)=place_element(array_config4,posicion_X{c_sensores}(i,instante),posicion_Y{c_sensores}(i,instante),posicion_Z{c_sensores}(i,instante),tipo_antena,amplitud1{c_antenas,c_sensores,c_phi,c_theta,instante},fase);
        end
        array_config1=array_config3;
        
        array_resultado1{c_antenas,c_sensores,c_phi,c_theta,instante}=array_config1;        
        
        for i=1:Numero_de_sensores
            
            [Etot1{c_antenas,c_sensores,c_phi,c_theta,instante,i},Ptot1{c_antenas,c_sensores,c_phi,c_theta,instante,i},directividad1{c_antenas,c_sensores,c_phi,c_theta,instante,i},Thmax1{c_antenas,c_sensores,c_phi,c_theta,instante,i},Phmax1{c_antenas,c_sensores,c_phi,c_theta,instante,i},directividad_buscada1{c_antenas,c_sensores,c_phi,c_theta,instante,i}] = ...
                Calacula_Campo_entero(array_config1(:,:,i),freq_config,range_config,deltheta1,delphi1,thetabuscado,phibuscado);

            Potencia_radiada1{c_antenas,c_sensores,c_phi,c_theta,instante,i}=reshape(array_config1(1,5,i),1,cantidad_de_sensores,1,1);
            Potencia_recibida1{c_antenas,c_sensores,c_phi,c_theta,instante,i}=((10^(directividad_buscada1{c_antenas,c_sensores,c_phi,c_theta,instante,i}/10))*(LANDA)^2/(4*distancia*pi))^2./Potencia_radiada1{c_antenas,c_sensores,c_phi,c_theta,instante,i}; % Añadido un "."
            Tiempo_de_vida_beam1{c_antenas,c_sensores,c_phi,c_theta,instante}(i)=Potencia_sensores{c_sensores}(i).*Potencia_recibida1{c_antenas,c_sensores,c_phi,c_theta,instante,i};
        end
        minimo_beam1{c_antenas,c_sensores,c_phi,c_theta,instante}=min(Tiempo_de_vida_beam1{c_antenas,c_sensores,c_phi,c_theta,instante});
        
    end
    
c_theta=c_theta+1;
end
c_phi=c_phi+1;
end
c_antenas=c_antenas+1;
end
c_sensores=c_sensores+1;
end
