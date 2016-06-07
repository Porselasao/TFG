%% Ejemplo de representación

clc
clear
load campo.mat;
% close all

caso='Caso base';

Etot=Etot_deseada{1};
% Etot1=Etot_deseada_1;

antenas=1;
sensor=1;
theta=1;
phi=1;
c_estacion=1;
cluster=1;
theta_a_buscar=round(phi_cluster{antenas,sensor,1,c_estacion,cluster})
phi_a_buscar=round(theta_cluster{antenas,sensor,1,c_estacion,cluster})


representacion_polar=1;
representacion_2D=1;
representacion_3D=0;


for instante=1:tiempo_de_simulacion
    if estacion_si
        eficiencia{instante}=minimo_beam_deseada{antenas,sensor,instante}./(minimo_beam1{antenas,sensor,instante});
    end
    if estacion_no_deseada_si
%         eficiencia_no_deseada{instante}=minimo_beam_no_deseada{antenas,sensor,instante}./(minimo_beam1_no_deseada{antenas,sensor,instante});
    end
end

for instante=1:tiempo_de_simulacion
    if estacion_si
        estacion1(instante)=eficiencia{instante}(1);
%         estacion2(instante)=eficiencia{instante}(2);
    end
    if estacion_no_deseada_si
%         estacion1_no_deseada(instante)=eficiencia_no_deseada{instante}(1);
%         estacion2_no_deseada(instante)=eficiencia_no_deseada{instante}(2);
%         estacion3_no_deseada(instante)=eficiencia_no_deseada{instante}(2);

    end
end
eficiencia{1}

estacion1
% estacion1_no_deseada



%% Diagrama de radiación en 2D (polar)

vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
t=vector_phi/360*2*pi;

if representacion_polar

figure;
titulo='Diagrama de radiación (polar). \it\theta = 90º, \phi (º). ';
for i=1:(tiempo_de_simulacion)
    
    vector_thetas=57;
    vector_phis=0;
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
%     polar(t,[Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),1) Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),:)],LineSpec);
    polar(t(1:end),[Etot(vector_thetas(theta),:) Etot(vector_thetas(theta),1)],LineSpec);
    %     plot(t(1:72),[Etot{antenas,sensor,phi,theta}(18,:,i)])
    hold off
    title([titulo caso])
    pause
end
end

if representacion_2D
t=t(1:end)*360/(2*pi);
figure
for i=1:(tiempo_de_simulacion)
    vector_thetas=57;
    vector_phis=0;
    plot(t,[Etot(vector_thetas(theta),:) Etot(vector_thetas(theta),cluster)])
    pause
end
end

if representacion_polar
t=vector_phi/360*2*pi;
figure;
titulo='Diagrama de radiación sin beamforming. ';
for i=1:(tiempo_de_simulacion)
    vector_thetas=[round(theta_cluster{antenas,sensor,i,c_estacion,cluster})];
    vector_phis=0;
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
%     polar(t,[Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),1) Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),:)],LineSpec);
    polar(t(1:end),[Etot1{antenas,sensor,i,cluster}(vector_thetas(theta),:) Etot1{antenas,sensor,i,cluster}(vector_thetas(theta),1)],LineSpec);
    %     plot(t(1:72),[Etot{antenas,sensor,phi,theta}(18,:,i)])
    hold off
    title([titulo caso])
    pause
end
end

if representacion_2D
t=t(1:end)*360/(2*pi);
figure
for i=1:(tiempo_de_simulacion)
    vector_thetas=[round(theta_cluster{antenas,sensor,i,c_estacion,cluster})];
    vector_phis=0;
    plot(t,[Etot1{antenas,sensor,i,cluster}(vector_thetas(theta),:) Etot1{antenas,sensor,i,cluster}(vector_thetas(theta),1)])
    pause
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

    rho=Etot{antenas,sensor,i,1};
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

    rho1=Etot1{antenas,sensor}(:,:,i);
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