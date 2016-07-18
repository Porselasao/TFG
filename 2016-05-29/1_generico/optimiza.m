function [array_config]=optimiza(Potencia_sensores,freq_config,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,range_config,thetabuscado,phibuscado,array_config,generaciones,poblacion,clusters_fijados)
%% Parametros de configuraci?n 


if clusters_fijados==0
    
    x=rand(1,2*Numero_de_sensores+1);
    LB=0.05*ones(1,2*Numero_de_sensores+1);
    LB(end)=0;
    UB=ones(2*Numero_de_sensores+1,1);
    
else
    if clusters_fijados <= Numero_de_sensores
        x=rand(1,2*Numero_de_sensores);
        LB=0.05*ones(1,2*Numero_de_sensores);
        UB=ones(2*Numero_de_sensores,1);
    else
        x=rand(1,2*Numero_de_sensores+1);
        LB=0.05*ones(1,2*Numero_de_sensores+1);
        LB(end)=0;
        UB=ones(2*Numero_de_sensores+1,1);
    end
end

% Generaciones 100, Population 500
% options = gaoptimset('Generations',5,'PopulationSize',50,'EliteCount',1,...
%       'PlotFcns',{@gaplotbestf,@gaplotbestindiv,@gaplotexpectation,@gaplotstopping},'MutationFcn', {@mutationadaptfeasible , 1/10},...       
%       'StallGenLimit',500000,'StallTimeLimit',100000);
options = gaoptimset('Generations',generaciones,'PopulationSize',poblacion,'EliteCount',1,...
      'PlotFcns',{@gaplotbestf,@gaplotbestindiv,@gaplotexpectation,@gaplotstopping},'MutationFcn', {@mutationadaptfeasible , 1/10},...       
      'StallGenLimit',500000,'StallTimeLimit',100000);


[x,fval] = ga(@(x)funcion_de_busqueda(x, array_config,Potencia_sensores,freq_config,range_config,thetabuscado,phibuscado,Numero_de_sensores,posicion_X,posicion_Y,posicion_Z,clusters_fijados),size(x,2),[],[],[],[],LB,UB,[],[],options);

if clusters_fijados==0

array_config(1,5,:)=10.^((x(1:(length(x)-1)/2)));%/10);
array_config(2,5,:)=2*pi*x((length(x)-1)/2+1:length(x)-1);

else
    
array_config(1,5,:)=10.^((x(1:(length(x))/2)));%/10);
array_config(2,5,:)=2*pi*x((length(x))/2+1:length(x));
end

