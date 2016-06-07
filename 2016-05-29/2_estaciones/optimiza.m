function [array_config]=optimiza(Potencia_sensores,freq_config,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,range_config,array_config,generaciones,poblacion,clusters_fijados)
%% Parametros de configuraci?n 

global mejor_x;
global estacion_si;
global estacion_no_deseada_si;
global estacion;
global mejor_estacion;
global elegir_mejor_estacion;

% % Con estaciones deseada y no deseada
if clusters_fijados==0
    x=rand(1,2*Numero_de_sensores+1);
    LB=0.05*ones(1,2*Numero_de_sensores+1);
    LB(end)=0;
    UB=ones(2*Numero_de_sensores+1,1);
    
else
    x=rand(1,2*Numero_de_sensores);
    LB=0.05*ones(1,2*Numero_de_sensores);
    UB=ones(2*Numero_de_sensores,1);
end

%         'PlotFcns',{@gaplotbestf,@gaplotbestindiv,@gaplotexpectation,@gaplotstopping},...
if (elegir_mejor_estacion==0)
% Generaciones y población
    options = gaoptimset('Generations',generaciones,'PopulationSize',poblacion,'EliteCount',1,...
        'MutationFcn', {@mutationadaptfeasible , 1/10},...       
        'StallGenLimit',500000,'StallTimeLimit',100000);
    

    [x,fval] = ga(@(x)Funcion_de_busqueda(x, array_config,Potencia_sensores,freq_config,range_config,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,clusters_fijados),size(x,2),[],[],[],[],LB,UB,[],[],options);

else
    options = gaoptimset('Generations',round(generaciones/2),'PopulationSize',round(poblacion/2),'EliteCount',1,...
        'MutationFcn', {@mutationadaptfeasible , 1/10},...       
        'StallGenLimit',500000,'StallTimeLimit',100000);

    [x,fval] = ga(@(x)Funcion_de_busqueda(x, array_config,Potencia_sensores,freq_config,range_config,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,clusters_fijados),size(x,2),[],[],[],[],LB,UB,[],[],options);

    estacion=estacion(mejor_estacion,:);
    
    [x,fval] = ga(@(x)Funcion_de_busqueda(x, array_config,Potencia_sensores,freq_config,range_config,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,clusters_fijados),size(x,2),[],[],[],[],LB,UB,[],[],options);

end

% % Con estaciones deseada y no deseada
if clusters_fijados==0
    array_config(1,5,:)=10.^((x(1:(length(x)-1)/2)));%/10);
    array_config(2,5,:)=2*pi*x((length(x)-1)/2+1:length(x)-1);
    
else
    array_config(1,5,:)=10.^((x(1:(length(x))/2)));%/10);
    array_config(2,5,:)=2*pi*x((length(x))/2+1:length(x));
end

end
