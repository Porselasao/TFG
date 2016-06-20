clear

cd resultados
c_caso=1;
for i=1:6
    Potencia_global{i}=0;
end
for caso_num = [39,40,43,44,66,68]
    for ejecucion_num = 1:30
        caso_cargar=['caso_' num2str(caso_num) '_ejecucion_' num2str(ejecucion_num) 'clusters1.mat'];
        load(caso_cargar);
        clear caso_cargar
        Potencia_global{c_caso}(end+1:end+length(Potencia_sensores{1}))=Potencia_sensores{1};
    end
    c_caso=c_caso+1;
end
cd ..

c_caso=1;
for i=1:6
    Potencia_global2{i}=Potencia_global{i}(2:length(Potencia_global{i}));
end

for i=1:6
    desv_tipica(i)=std(Potencia_global2{i});
end