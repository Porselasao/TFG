function  scores  = Funcion_de_busqueda(x,array_config,Potencia_sensores,freq_config,range_config,thetabuscado,phibuscado,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,clusters_fijados)

global mejor_idx;
global mejor_centro_cluster;
global mejor_scores;
global mejor_x;

% clear idx;

if clusters_fijados==0
    array_config(1,5,:)=10.^x(1:(length(x)-1)/2);
    array_config(2,5,:)=2*pi*x((length(x)-1)/2+1:length(x)-1);
    Numero_de_cluster=round(x(end)*(Numero_de_sensores-1))+1;
else
    array_config(1,5,:)=10.^x(1:(length(x)/2));
    array_config(2,5,:)=2*pi*x((length(x))/2+1:length(x));
    Numero_de_cluster=clusters_fijados;
end

% Se ha de crear la variable X que es de Numero_de_sensores filas por 3
% columnas (1 por dimensión). idx es un vector columna que identifica a qué
% cluster pertenece cada sensor, es decir, a qué cluster pertenece cada
% fila de la matriz X. En C están los centros de cada cluster.

X=[posicion_X posicion_Y posicion_Z];

opts = statset('Display','off');
[idx,centro_cluster] = kmeans(X,Numero_de_cluster,'Distance','cityblock','Replicates',Numero_de_cluster,'Options',opts);

% Paso para optimización
deltheta=15;
delphi=15;

%% Ahora entra en juego el tiempo de vida de los sensores

distancia=1;
LANDA=1;
for i=1:Numero_de_cluster
    
    [directivity_dBi,Thmax,Phmax,directivity_dBi_buscada] = Calacula_Directividad2(array_config(:,:,idx==i),freq_config,range_config,deltheta,delphi,thetabuscado,phibuscado);

    sensores_cluster_actual=sum(idx==i);
    sincronismo=calcular_sincronismo(sensores_cluster_actual);
    
    Potencia_radiada=10.^(x(idx==i))*sincronismo;

    Pontencia_recibida=10.^(directivity_dBi_buscada/10)*(LANDA)^2/(4*distancia*pi)^2./Potencia_radiada;
    Tiempo_de_vida=Potencia_sensores(idx==i).*Pontencia_recibida/sensores_cluster_actual;
    optimiza(i)=min(Tiempo_de_vida);

end

%% Potencia de los senseros

scores=1/min(optimiza);  % 

if scores<mejor_scores
   mejor_scores=scores;
   mejor_idx=idx;
   mejor_centro_cluster=centro_cluster;
   mejor_x=x;
end

%scores=pwrdB(angulo+90); %Para security issues
