clear
maxima_potencia=-1;
contador=0;
suma=0;
vector=0;
for j=[6:10 26:30]
    j=num2str(j);
for i=1:30
i=num2str(i);
load(['caso_' j '_ejecucion_' i 'clusters1.mat'])
% maximo=max(Potencia_sensores{1});
vector(end+1:end+length(Potencia_sensores{1}))=Potencia_sensores{1};
suma=suma+sum(Potencia_sensores{1});
contador=contador+length(Potencia_sensores{1});
end
end

media=suma/contador;
plot(sort(vector(2:end)))