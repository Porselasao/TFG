%% Ejemplo de representación

clc
% clear all
close all

% load caso_24.mat

caso='Caso base';

% Se ha de seleccionar para el campo Etot{} el siguiente orden:
% {contador_antenas,contador_sensores,contador_phi,contador_theta}

% for i=1:tiempo_de_simulacion
%     plot3(posicion_X{1}(:,i),posicion_Y{1}(:,i),posicion_Z{1}(:,i),'.')
%     axis([0 30 0 30 0 30])
%     grid on;
%     pause
% end

c_antenas=1;
c_sensor=1;
c_phi=2;
c_theta=1;
instante=5;

representacion_polar=1;
representacion_2D=1;
representacion_3D=1;

% vector_thetas=[45];% 90];
% vector_phis=[45]; %15

vector_thetas=theta;
vector_phis=phi;


% Numero_de_sensores=10;
% 
for i=1:tiempo_de_simulacion
    eficiencia(i,:)=minimo_beam{c_antenas,c_sensor,c_phi,c_theta,i}./minimo_beam1{c_antenas,c_sensor,c_phi,c_theta,i};
end

% for instante=1:tiempo_de_simulacion
%     for k=1:max(idx_global{antenas,sensor,phi,theta,instante})
%         minimo_cluster_prueba{instante}(k)=min(Tiempo_de_vida_beam{antenas,sensor,phi,theta,instante,k});
%     end
%     minimo_beam_prueba{antenas,sensor,phi,theta,instante}=min(minimo_cluster_prueba{instante});
% end
% 
% for i=1:tiempo_de_simulacion
%     eficiencia(i,:)=minimo_beam_prueba{antenas,sensor,phi,theta,i}./minimo_beam1{antenas,sensor,phi,theta,i};
% end
for i=1:tiempo_de_simulacion
    clustercillo(i)=max(idx_global{c_antenas,c_sensor,c_phi,c_theta,i});
end

maximo_cluster=max(clustercillo)

phi_apuntado=vector_phis(c_phi)

eficiencia
eficiencia_minima=min(eficiencia)
eficiencia_media=mean(eficiencia)
% max(max(idx_global{antenas,sensor,phi,theta}))

% %% Diagrama original 2D
% 
% % figure;
% % titulo='Diagrama de radiación. ';
% % for i=1:(tiempo_de_simulacion)
% %     surf(delphi:delphi:360,deltheta:deltheta:180,reshape(Etot{antenas,sensores,phi,theta}(:,:,i),size(Etot{antenas,sensores,phi,theta},1),size(Etot{antenas,sensores,phi,theta},2)))
% %     xlabel('\it\phi')
% %     ylabel('\it\theta')
% %     title([titulo caso])
% %     view(90,90)
% %     drawnow;
% %     pause(0.1)
% % end
% 
% %% Diagrama de potencia
% 
% % figure;
% % titulo='Diagrama de potencia. ';
% % for i=1:(tiempo_de_simulacion)
% %     surf(delphi:delphi:360,deltheta:deltheta:180,reshape(Ptot{antenas,sensores,phi,theta}(:,:,i),size(Ptot{antenas,sensores,phi,theta},1),size(Ptot{antenas,sensores,phi,theta},2)))
% %     xlabel('\it\phi')
% %     ylabel('\it\theta')
% %     title([titulo caso])
% %     view(90,90)
% %     drawnow;
% %     pause(0.1)
% % end
% 
%% Diagrama de radiación en 2D (polar)

vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
t=vector_phi/360*2*pi;

if representacion_polar

    figure;
titulo='Diagrama de radiación (polar). \it\theta = 90º, \phi (º). ';
title(titulo)
for i=1:(2)
    LineSpec.LineWidth=2;
    subplot(1,2,i)
    P=polar(t,1*ones(size(t)));
%     title(titulo)
    set(P, 'Visible', 'off')
    hold on
    polar(t(1:end),[Etot{c_antenas,c_sensor,c_phi,c_theta,instante,i}(vector_thetas(c_theta),:) Etot{c_antenas,c_sensor,c_phi,c_theta,instante,i}(vector_thetas(c_theta),1)]);
    hold on
    polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,instante,i}(vector_thetas(c_theta),:) Etot1{c_antenas,c_sensor,c_phi,c_theta,instante,i}(vector_thetas(c_theta),1)],'r');
    title('Cluster ')
    hold off
%     title([titulo caso])
    pause
end
    
figure;
titulo='Diagrama de radiación (polar). \it\theta = 90º, \phi (º). ';
for i=1:(tiempo_de_simulacion)
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
%     polar(t,[Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),1) Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),:)],LineSpec);
    polar(t(1:end),[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),1)],LineSpec);
    polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:) Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),1)],LineSpec);
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
    plot(t,[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),1)])
    pause
end
end

if representacion_polar
t=vector_phi/360*2*pi;
figure;
titulo='Diagrama de radiación sin beamforming. ';
for i=1:(tiempo_de_simulacion)
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
%     polar(t,[Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),1) Etot{antenas,sensor,phi,theta,instante,1}(vector_thetas(theta),:)],LineSpec);
    polar(t(1:end),[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:) Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),1)],LineSpec);
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
    plot(t,[Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:) Etot1{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),1)])
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
% %% Aproximación a la directividad deseada
% 
% figure;
% titulo='Aproximación a la directividad deseada. ';
% plot(directivity_dBi{antenas,sensor,phi,theta},'LineWidth',2)
% hold on;
% plot(directivity_dBi_buscada{antenas,sensor,phi,theta},'r','LineWidth',2)
% grid on
% title([titulo caso])
% xlabel('Tiempo')
% ylabel('Directividad (dB)')
% legend('Directividad obtenida','Directividad buscada')
% 
% %% Máximos de los diagramas de radiación
% 
% figure;
% titulo='Máximos de los diagramas de radiación. ';
% plot(Thmax{antenas,sensor,phi,theta}*180/pi,'r','LineWidth',2)
% hold on;
% grid on;
% plot(Phmax{antenas,sensor,phi,theta}*180/pi,'LineWidth',2)
% title([titulo caso]);
% xlabel('Tiempo')
% ylabel('Ángulo (º)')
% legend('\it\theta máximo','\it\phi máximo')
% 
% %% Tiempo de vida de cada sensor con y sin beanforming
% 
% figure;
% titulo='Tiempo de vida de los sensores. ';
% plot(minimo_sensor,'LineWidth',2)
% hold on
% plot(minimo_sensor1,'r','LineWidth',2)
% axis([1 Numero_de_sensores 0 max(max([minimo_sensor; minimo_sensor1]))+0.05]);
% hold off
% grid on
% legend('Con Beanforming','Sin Beanforming')
% title([titulo caso])
% xlabel('Sensor')
% ylabel('Tiempo de vida')
% 
% % Así estaba antes
% 
% % for i=1:length(minimo_beam{antenas,sensores,phi,theta})
% %     tiempo1(i)=minimo_beam1{sensores}(antenas);
% % end
% % 
% % figure;
% % titulo='Tiempo de vida de los sensores. ';
% % plot(minimo_beam{antenas,sensores,phi,theta},'LineWidth',2)
% % hold on
% % plot(tiempo1,'r','LineWidth',2)
% % hold off
% % grid on
% % legend('Con Beanforming','Sin Beanforming')
% % title([titulo caso])
% % xlabel('Tiempo')
% % ylabel('Tiempo de vida')
% 
% %% Eficiencia de cada sensor al usar beanforming
% 
% figure;
% titulo='Eficiencia de cada sensor en %. ';
% plot(minimo_sensor./minimo_sensor1*100,'LineWidth',2)
% grid on
% title([titulo caso])
% xlabel('Sensor')
% ylabel('Eficiencia (%)')
% 
% % Así estaba antes
% 
% % figure;
% % titulo='Eficiencia de cada sensor en %. ';
% % plot(minimo_beam{antenas,sensores,phi,theta}./tiempo1*100,'LineWidth',2)
% % grid on
% % title([titulo caso])
% % xlabel('Tiempo')
% % ylabel('Eficiencia (%)')