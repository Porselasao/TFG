function casos(ejec,numero,antenas,sensores_fijos,potencia_fija,dimension,sensores,theta,phi,tiempo_de_simulacion,deltheta,delphi,deltheta1,delphi1,generaciones,poblacion,clusters_fijados)

antenas
sensores_fijos
potencia_fija
dimension
sensores

if dimension>=1
    dim_x=30;
end
if dimension>=2
    dim_y=30;
else
    dim_y=0;
end
if dimension==3
    dim_z=30;
else
    dim_z=0;
end

if clusters_fijados <= sensores

TODO;
ejec=num2str(ejec);
numero=num2str(numero);
clusters_fijados=num2str(clusters_fijados);
caso=['caso_' numero '_ejecucion_' ejec 'clusters' clusters_fijados];
clear -regexp Etot Ptot

save(caso);

end
end