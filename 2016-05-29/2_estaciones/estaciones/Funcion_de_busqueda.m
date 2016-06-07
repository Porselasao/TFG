function  scores  = Funcion_de_busqueda(x,array_config,Potencia_sensores,freq_config,range_config,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,clusters_fijados)

global mejor_idx;
global mejor_centro_cluster;
global estacion;
global mejor_scores;
global mejor_x;
global estacion_no_deseada;
global estacion_si;
global estacion_no_deseada_si;

% clear idx;

% % Con estaciones deseada y no deseada
if clusters_fijados == 0
    if estacion_si && estacion_no_deseada_si
        %     array_config(1,5,:)=10.^x(1:(length(x)-2)/2);
        %     array_config(2,5,:)=2*pi*x((length(x)-2)/2+1:length(x)-2);
    else
        % Solo con estaci�n deseada o no deseada
        array_config(1,5,:)=10.^x(1:(length(x)-1)/2);
        array_config(2,5,:)=2*pi*x((length(x)-1)/2+1:length(x)-1);
    end
    
    Numero_de_cluster=round(x(end-1)*(Numero_de_sensores-1))+1;
    
else
    if estacion_si && estacion_no_deseada_si
        %     array_config(1,5,:)=10.^x(1:(length(x)-2)/2);
        %     array_config(2,5,:)=2*pi*x((length(x)-2)/2+1:length(x)-2);
    else
        % Solo con estaci�n deseada o no deseada
        array_config(1,5,:)=10.^x(1:(length(x))/2);
        array_config(2,5,:)=2*pi*x((length(x))/2+1:length(x));
    end
    Numero_de_cluster=clusters_fijados;
end

% Se ha de crear la variable X que es de Numero_de_sensores filas por 3
% columnas (1 por dimensi�n). idx es un vector columna que identifica a qu�
% cluster pertenece cada sensor, es decir, a qu� cluster pertenece cada
% fila de la matriz X. En C est�n los centros de cada cluster.

X=[posicion_X posicion_Y posicion_Z];

opts = statset('Display','off');
[idx,centro_cluster] = kmeans(X,Numero_de_cluster,'Distance','cityblock','Replicates',Numero_de_cluster,'Options',opts);

% Paso para optimizaci�n
deltheta=15;
delphi=15;

%% Ahora entra en juego el tiempo de vida de los sensores

for i=1:Numero_de_cluster
    
    if estacion_si
        for j=1:length(estacion(:,1))
            [distancia,theta_cluster,phi_cluster]=cart2sph2(estacion(j,:)-centro_cluster(i,:));

            [directivity_dBi,Thmax,Phmax,directivity_dBi_buscada] = Calacula_Directividad2(array_config(:,:,idx==i),freq_config,range_config,deltheta,delphi,theta_cluster,phi_cluster);
            
            sensores_cluster_actual=sum(idx==i);
            sincronismo=calcular_sincronismo(sensores_cluster_actual);
            
            Potencia_radiada=10.*x(idx==i)*sincronismo;
            LANDA=1;
            
            Potencia_recibida=10.^(directivity_dBi_buscada/10)*(LANDA)^2/(4*distancia*pi)^2./Potencia_radiada;
            Tiempo_de_vida=Potencia_sensores(idx==i).*Potencia_recibida/sensores_cluster_actual;
            optimiza_estacion(j)=min(Tiempo_de_vida);
        end
        optimiza1(i,:)=optimiza_estacion;
    end
    
    if estacion_no_deseada_si
        for j=1:length(estacion_no_deseada(:,1))
            [distancia,theta_cluster,phi_cluster]=cart2sph2(estacion_no_deseada(j,:)-centro_cluster(i,:));

            [directivity_dBi,Thmax,Phmax,directivity_dBi_buscada] = Calacula_Directividad2(array_config(:,:,idx==i),freq_config,range_config,deltheta,delphi,theta_cluster,phi_cluster);
            
            sensores_cluster_actual=sum(idx==i);
            sincronismo=calcular_sincronismo(sensores_cluster_actual);
            
            Potencia_radiada=10.*x(idx==i)*sincronismo;
            LANDA=1;

            Potencia_recibida=10.^(directivity_dBi_buscada/10)*(LANDA)^2/(4*distancia*pi)^2./Potencia_radiada;
            Tiempo_de_vida=Potencia_sensores(idx==i).*Potencia_recibida/sensores_cluster_actual;
            optimiza_estacion_no_deseada(j)=max(Tiempo_de_vida);
            optimiza_estacion_no_deseada(j)=10.^(directivity_dBi_buscada/10);
        end
        optimiza2(i,:)=optimiza_estacion_no_deseada;
    end
end

%% Potencia de los senseros

if estacion_si && ~estacion_no_deseada_si
    scores=1/min(optimiza1);
elseif ~estacion_si && estacion_no_deseada_si
    scores=max(optimiza2);
elseif estacion_si && estacion_no_deseada_si
    scores1=1/min(optimiza1);
    scores2=sum(optimiza2);
    scores=scores1*scores2;
end

if scores<mejor_scores
   mejor_scores=scores;
   mejor_idx=idx;
   mejor_centro_cluster=centro_cluster;
   mejor_x=x;
end

%scores=pwrdB(angulo+90); %Para security issues
