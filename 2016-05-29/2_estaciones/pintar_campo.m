%% Ejemplo de representación

cargar=1;

if cargar
clc
clear all
close all

cd resultados
load caso_3_ejecucion_1clusters1.mat
caso='Caso base';
cd ..
cargar=1;
end

% Se ha de seleccionar para el campo Etot{} el siguiente orden:
% {contador_antenas,contador_sensores,contador_phi,contador_theta}

for i=1:tiempo_de_simulacion
    plot3(posicion_X{1}(:,i),posicion_Y{1}(:,i),posicion_Z{1}(:,i),'.')
    axis([0 30 0 30 0 30])
    grid on;
end

c_antenas=2;
c_sensor=1;
c_phi=2;
c_theta=1;
instante=1;

representacion_polar=1;
representacion_2D=1;
representacion_3D=0;
normalizado=1;
funcion_theta=1;

vector_thetas=theta;
vector_phis=phi;

for i=1:tiempo_de_simulacion
    eficiencia(i)=minimo_beam{c_antenas,c_sensor,c_phi,c_theta,i}./minimo_beam1{c_antenas,c_sensor,c_phi,c_theta,i};
end

for i=1:tiempo_de_simulacion
    clustercillo(i)=max(idx_global{c_antenas,c_sensor,c_phi,c_theta,i});
end

maximo_cluster=max(clustercillo)

phi_apuntado=vector_phis(c_phi)
theta_apuntado=vector_thetas(c_theta)

eficiencia
eficiencia_minima=min(eficiencia)
eficiencia_media=mean(eficiencia)

if cargar
k=1;
[Etot{c_antenas,c_sensor,c_phi,c_theta,instante,k},Ptot{c_antenas,c_sensor,c_phi,c_theta,instante,k},directividad{c_antenas,c_sensor,c_phi,c_theta,instante,k},Thmax{c_antenas,c_sensor,c_phi,c_theta,instante,k},Phmax{c_antenas,c_sensor,c_phi,c_theta,instante,k},directividad_buscada{c_antenas,c_sensor,c_phi,c_theta,instante,k}] = ...
    Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,c_phi,c_theta,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas(c_theta),vector_phis(c_phi));
            
i=1;
[Etot1{c_antenas,c_sensor,c_phi,c_theta,instante,i},Ptot1{c_antenas,c_sensor,c_phi,c_theta,instante,i},directividad1{c_antenas,c_sensor,c_phi,c_theta,instante,i},Thmax1{c_antenas,c_sensor,c_phi,c_theta,instante,i},Phmax1{c_antenas,c_sensor,c_phi,c_theta,instante,i},directividad_buscada1{c_antenas,c_sensor,c_phi,c_theta,instante,i}] = Calacula_Campo_entero(array_resultado1{c_antenas,c_sensor,c_phi,c_theta,instante}(:,:,i),freq_config,range_config,deltheta1,delphi1,thetabuscado,phibuscado);
end
%% Diagrama de radiación en 2D (polar)

if funcion_theta
    
vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
t=vector_phi/360*2*pi;


if representacion_polar

figure;
titulo='Diagrama de radiación (polar). \it\theta = 90º, \phi (º). ';
for i=1:(tiempo_de_simulacion)
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
    if normalizado
        polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:) Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,1)]/max(Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:)),'r');
        polar(t(1:end),[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,1)]/max(Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:)),LineSpec);
    else
        polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:) Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,1)],'r');
        polar(t(1:end),[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,1)],LineSpec);
    end
    hold off
    title([titulo caso])
end



end

if representacion_2D
t=t(1:end)*360/(2*pi);
figure
for i=1:(tiempo_de_simulacion)
    if normalizado
        plot(t,[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,1)]/max(Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:)))
    else
        plot(t,[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta)+1,1)])
    end
        grid on;
end
end

else
   
vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
t=vector_phi/360*2*pi;


if representacion_polar
figure;
titulo='Diagrama de radiación (polar). \it\theta = 90º, \phi (º). ';
for i=1:(tiempo_de_simulacion)
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
    if normalizado
        polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(1,vector_phis(c_phi)+1)]/max(Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)'),'r');
        polar(t(1:end),[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(1,vector_phis(c_phi)+1)]/max(Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)'),LineSpec);
    else
        polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)'],'r');
        polar(t(1:end),[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)'],LineSpec);
    end
    hold off
    title([titulo caso])
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