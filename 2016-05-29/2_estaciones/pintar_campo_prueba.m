%% Ejemplo de representación

cargar=0;

if cargar
% clc
clear all
% close all

cd resultados
load caso_37_ejecucion_1clusters1.mat
caso='Caso 1. ';
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

c_antenas=2;
c_sensor=1;
instante=1;

representacion_polar=1;
representacion_2D=0;
representacion_3D=0;
normalizado=1;
funcion_theta=0;


[distancia_deseada,vector_thetas,vector_phis]=cart2sph2(estacion(1,:)-mejor_centro_cluster(1,:));
% vector_thetas=theta_clister_deseada;
% vector_phis=phi;


% for i=1:tiempo_de_simulacion
%     eficiencia(i)=minimo_beam{c_antenas,c_sensor,c_phi,c_theta,i}./minimo_beam1{c_antenas,c_sensor,c_phi,c_theta,i};
% end
% 
% for i=1:tiempo_de_simulacion
%     clustercillo(i)=max(idx_global{c_antenas,c_sensor,c_phi,c_theta,i});
% end

% % maximo_cluster=max(clustercillo)
% % 
% % phi_apuntado=vector_phis(c_phi)
% % theta_apuntado=vector_thetas(c_theta)

% eficiencia
% % eficiencia_minima=min(eficiencia)
% % eficiencia_media=mean(eficiencia)

if cargar
[Etot{c_antenas,c_sensor,1,1,1,1},yei,you,yai,yiu,kkkk] = ...
  Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas,vector_phis);
           
i=1;
[Etot1{c_antenas,c_sensor,1,1,1,1},aaa,b,c,d,e] = ...
    Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,1),freq_config,range_config,deltheta1,delphi1,0,0);
                                 

end
%% Diagrama de radiación en 2D (polar)

if funcion_theta

else
   
if c_antenas==1
    tipo_de_antena='isotrópicas.';
else
    tipo_de_antena='dipolo.';
end

vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
t=vector_theta/360*2*pi;


x=[16-1 16-1]/360*2*pi;
y=[0 1.5];

vector_thetas=round(vector_thetas);
vector_phis=round(vector_phis);

if representacion_polar
figure;
% titulo=[caso num2str(sensores) ' sensores, antenas ' tipo_de_antena ' Diagrama de radiación (polar). \it\theta = ' num2str(vector_thetas(c_theta)) ' º, \phi = (º)'];%...
titulo=[caso num2str(sensores) ' sensores, antenas ' tipo_de_antena ' \it\phi = ' num2str(vector_phis(1)) 'º, \theta = (º)'];
for i=1:(tiempo_de_simulacion)
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
    
    polar(t(1:end),[Etot1{c_antenas,c_sensor,1,1,1,1}(:,vector_phis(1)+1)' Etot1{c_antenas,c_sensor,1,1,1,1}(1,vector_phis(1)+1)]/max(Etot1{c_antenas,c_sensor,1,1,1,1}(:,vector_phis(1)+1)'),'r');
    
    polar(x,y,'k')
    title(['Diagrama de radiación de un sensor que usa beamforming'])
    polar(t(1:end),[Etot{c_antenas,c_sensor,1,1,1,1}(:,vector_phis(1)+1)' Etot{c_antenas,c_sensor,1,1,1,1}(1,vector_phis(1)+1)]/max(Etot1{c_antenas,c_sensor,1,1,1,1}(:,vector_phis(1)+1)'),LineSpec);
    hold off
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis(1)) 'º, \theta = ' num2str(vector_thetas(1))])
end
end

if representacion_2D
t=t(1:end)*360/(2*pi);
figure
for i=1:(tiempo_de_simulacion)
    if normalizado
        plot(t,[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(1,vector_phis(c_phi)+1)']/max(Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)'))
    else
        plot(t,[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(1,vector_phis(c_phi)+1)'])
    end
        grid on;
end
end

    
    
end











%% Representación en 3D del diagrama de radiación


if representacion_3D

vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
    
for j=1:length(vector_phi)
    matriz_theta(:,j)=vector_theta;
end

for i=1:length(vector_theta)
    matriz_phi(i,:)=vector_phi;
end

figure;
titulo=('Diagrama de radiación. ');
for i=1:tiempo_de_simulacion

    rho=Etot{c_antenas,c_sensor,c_phi,c_theta,i,1};
    rho(:,end+1)=rho(:,1);
    rho(end+1,:)=rho(1,:);
    t = rho.*sind(matriz_theta);
    x = t.*cosd(matriz_phi);
    y = t.*sind(matriz_phi);
    z = rho.*cosd(matriz_theta);
    title([titulo caso])
    surf(x,y,z)
%     view(120,25)
    view(0,90)
    axis([-1 1 -1 1 -1 1])
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    title([titulo caso])
    drawnow;
    pause(0.5);
end
 view(0,90)

figure;
titulo=('Diagrama de radiación sin beamforming. ');
for i=1:tiempo_de_simulacion

    rho1=Etot1{c_antenas,c_sensor,c_phi,c_theta}(:,:,i);
    rho1(:,end+1)=rho1(:,1);
    rho1(end+1,:)=rho1(1,:);
    t = rho1.*sind(matriz_theta);
    x = t.*cosd(matriz_phi);
    y = t.*sind(matriz_phi);
    z = rho1.*cosd(matriz_theta);
    title([titulo caso])
    surf(x,y,z)
    view(120,25)
    axis([-1 1 -1 1 -1 1])
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    title([titulo caso])
    drawnow;
    pause(0.5);
end

end