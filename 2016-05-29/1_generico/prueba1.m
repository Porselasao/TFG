function lanzador(ejec,numero,clusters_fijados)

numero=str2num(numero); % Solo para .exe
clusters_fijados=str2num(clusters_fijados);  % Solo para .exe
ejec=str2num(ejec);

rng((numero^ejec)*clusters_fijados);
a=rand;
disp(a)

ejec=num2str(ejec);
numero=num2str(numero);
clusters_fijados=num2str(clusters_fijados);
caso=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados];
save(caso);
disp('Finished')