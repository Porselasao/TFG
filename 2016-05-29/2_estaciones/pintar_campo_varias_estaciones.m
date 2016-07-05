%% Ejemplo de representación

cargar=1;
close all
if cargar
% clc
clear
close all

cd resultados
load caso_53_ejecucion_1clusters1.mat
caso='Caso 7. ';
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
estacion_script=estacion_no_deseada;

c_antenas=1;
c_sensor=1;
instante=1;

representacion_polar=1;
representacion_2D=1;
representacion_3D=0;
normalizado=1;
funcion_theta=0;

for i=1:length(estacion_script(:,1))
[distancia_deseada(i),vector_thetas(i),vector_phis(i)]=cart2sph2(estacion_script((i),:)-mejor_centro_cluster);
end

if cargar
for i=1:length(estacion_script(:,1))
[Etot{c_antenas,c_sensor,1,1,1,1,i},yei,you,yai,yiu,kkkk] = ...
  Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas(i),vector_phis(i));
        
[Etot1{c_antenas,c_sensor,1,1,1,1,i},aaa,b,c,d,e] = ...
    Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,1),freq_config,range_config,deltheta1,delphi1,vector_thetas(i),vector_phis(i));

end
end
%% Diagrama de radiación en 2D (polar)

   
if c_antenas==1
    tipo_de_antena='isotrópicas';
else
    tipo_de_antena='dipolo';
end

vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
t=vector_theta/360*2*pi;


if representacion_polar
figure;
% titulo=[caso num2str(sensores) ' sensores, antenas ' tipo_de_antena ' Diagrama de radiación (polar). \it\theta = ' num2str(vector_thetas(c_theta)) ' º, \phi = (º)'];%...
for i=1:length(estacion_script(:,1))
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
    x=[vector_thetas(i) vector_thetas(i)]/360*2*pi;
    y=[0 1.5];
    vector_thetas(i)=round(vector_thetas(i));
    vector_phis(i)=round(vector_phis(i));
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis(i)) 'º, \theta = ' num2str(vector_thetas(i))])
    
%     titulo=[caso num2str(sensores) ' sensores, antenas ' tipo_de_antena ', estación: ' num2str(i) ', \it\phi = ' num2str(vector_phis(i)) 'º, \theta = (º)'];
    titulo=[caso num2str(sensores) ' sensores, antenas ' tipo_de_antena '. \it\phi = ' num2str(vector_phis(i)) 'º, \theta = (º)'];
    
    polar(t,[Etot1{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)' Etot1{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis(i)+1)]/max(Etot1{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)'),'r');
    polar(t,[Etot{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)' Etot{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis(i)+1)]/max(Etot{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)'),LineSpec);
    
    polar(x,y,'k')
    hold off
    title([titulo])
    figure;
end
end

if representacion_2D
t=t*360/(2*pi);
figure
for i=1:length(estacion_script(:,1))
    figure;
    x=[vector_thetas(i) vector_thetas(i)]/360*2*pi;
    y=[0 1.5];
    vector_thetas(i)=round(vector_thetas(i));
    vector_phis(i)=round(vector_phis(i));
    plot(t,[Etot{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)' Etot{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis(i)+1)]/max(Etot{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)'));
    titulo=[caso 'Diagrama de radiación bidimensional, ' num2str(sensores) ' sensores, antenas ' tipo_de_antena '. \it\phi = ' num2str(vector_phis(i)) 'º, \theta = (º)'];
    hold on
    plot(t,[Etot{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)' Etot{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis(i)+1)]/max(Etot{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis(i)+1)'),'LineWidth',2);
    plot(x*360/(2*pi),y,'k','LineWidth',2)
    hold off;
    grid on;
    title(titulo,'FontSize',14);
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis(i)) 'º, \theta = ' num2str(vector_thetas(i))],'FontSize',14)
    axis([0 180 0 1.1])
    set(gca,'FontSize',14)
end
end

close 3
close 4