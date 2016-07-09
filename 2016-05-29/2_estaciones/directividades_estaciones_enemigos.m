

%% Ejemplo de representación

cargar=1;
close all
if cargar
% clc
clear
close all

cd resultados
load caso_213_ejecucion_1clusters1.mat
caso='Caso 8. ';
cd ..
cargar=1;
end

% Se ha de seleccionar para el campo Etot{} el siguiente orden:
% {contador_antenas,contador_sensores,contador_phi,contador_theta}

% for i=1:tiempo_de_simulacion
%     plot3(posicion_X{1}(:,i),posicion_Y{1}(:,i),posicion_Z{1}(:,i),'.')
%     axis([0 30 0 30 0 30])
%     grid on;
% end
% estacion_script=estacion;
estacion_base=estacion;
nodo_enemigo=estacion_no_deseada;

c_antenas=1;
c_sensor=1;
instante=1;

representacion_polar=0;
representacion_2D=1;
representacion_3D=0;
normalizado=1;
funcion_theta=0;
for i=1:length(estacion_base(:,1))
    [distancia_base(i),vector_thetas_base(i),vector_phis_base(i)]=cart2sph2(estacion_base((i),:)-mejor_centro_cluster);
end
for i=1:length(nodo_enemigo(:,1))
    [distancia_enemigo(i),vector_thetas_enemigo(i),vector_phis_enemigo(i)]=cart2sph2(nodo_enemigo((i),:)-mejor_centro_cluster);
end

if cargar
for i=1:length(estacion_base(:,1))
                    
[Etot_base{c_antenas,c_sensor,1,1,1,1,i},potencia,directividad_max,tmax,phmax,directividad_deseada_estacion(i)] = ...
  Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas_base(i),vector_phis_base(i));
end
 
for i=1:length(nodo_enemigo(:,1))
[Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i},yei,you,yai,yiu,directividad_deseada_enemigo(i)] = ...
  Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas_enemigo(i),vector_phis_enemigo(i));
end

directividades=[directividad_deseada_estacion directividad_deseada_enemigo];
end
