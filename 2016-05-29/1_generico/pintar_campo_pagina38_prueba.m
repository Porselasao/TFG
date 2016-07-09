%% Ejemplo de representación

% clear
cargar=0;
if cargar
Numero_de_sensores = 5;
array_config4=- ones(3,5,Numero_de_sensores);
posicion_X=[-2 -1 0 1 2];
posicion_Y=[0 0 0 0 0];
posicion_Z=[0 0 0 0 0];
tipo_antena=0;

fase=0;

for i=1:5
    array_config2(:,:,i)=place_element(array_config4,posicion_X(i),posicion_Y(i),posicion_Z(i),tipo_antena, 1,fase);
    fase=fase+180;
end
array_config=array_config2;


% Se ha de seleccionar para el campo Etot{} el siguiente orden:
% {contador_antenas,contador_sensores,contador_phi,contador_theta}

% for i=1:tiempo_de_simulacion
%     plot3(posicion_X{1}(:,i),posicion_Y{1}(:,i),posicion_Z{1}(:,i),'.')
%     axis([0 30 0 30 0 30])
%     grid on;
% end

c_antenas=1;
c_sensor=1;
c_phi=1;
c_theta=1;
instante=1;

representacion_polar=1;
representacion_2D=0;
representacion_3D=0;
normalizado=1;
funcion_theta=0;

vector_thetas=45;
vector_phis=45;

% for i=1:tiempo_de_simulacion
%     eficiencia(i)=minimo_beam{c_antenas,c_sensor,c_phi,c_theta,i}./minimo_beam1{c_antenas,c_sensor,c_phi,c_theta,i};
% end
% 
% for i=1:tiempo_de_simulacion
%     clustercillo(i)=max(idx_global{c_antenas,c_sensor,c_phi,c_theta,i});
% end

% maximo_cluster=max(clustercillo)
% 
% phi_apuntado=vector_phis(c_phi)
% theta_apuntado=vector_thetas(c_theta)

% eficiencia
% eficiencia_minima=min(eficiencia)
% eficiencia_media=mean(eficiencia)
freq_config=300e6;
range_config=999; % Punto de campo lejano cuanto m?s grande m?s preciso y m?s lento
deltheta=1;
delphi=1;
deltheta1=1;
delphi1=1;

k=1;
[Etot{c_antenas,c_sensor,c_phi,c_theta,instante,k},Ptot{c_antenas,c_sensor,c_phi,c_theta,instante,k},directividad{c_antenas,c_sensor,c_phi,c_theta,instante,k},Thmax{c_antenas,c_sensor,c_phi,c_theta,instante,k},Phmax{c_antenas,c_sensor,c_phi,c_theta,instante,k},directividad_buscada{c_antenas,c_sensor,c_phi,c_theta,instante,k}] = ...
    Calacula_Campo_entero(array_config,freq_config,range_config,deltheta,delphi,vector_thetas(c_theta),vector_phis(c_phi));
            
i=1;
% [Etot1{c_antenas,c_sensor,c_phi,c_theta,instante,i},Ptot1{c_antenas,c_sensor,c_phi,c_theta,instante,i},directividad1{c_antenas,c_sensor,c_phi,c_theta,instante,i},Thmax1{c_antenas,c_sensor,c_phi,c_theta,instante,i},Phmax1{c_antenas,c_sensor,c_phi,c_theta,instante,i},directividad_buscada1{c_antenas,c_sensor,c_phi,c_theta,instante,i}] = Calacula_Campo_entero(array_config(:,:,1),freq_config,range_config,deltheta1,delphi1,thetabuscado,phibuscado);
end
%% Diagrama de radiación en 2D (polar)

if c_antenas==0
    tipo_de_antena='isotrópicas.';
else
    tipo_de_antena='dipolo.';
end


if funcion_theta
    
else
   
if c_antenas==1
    tipo_de_antena='isotrópicas.';
else
    tipo_de_antena='dipolo.';
end

vector_theta = 0:deltheta:180;
vector_phi = 0:delphi:360;
% t=vector_phi/360*2*pi;
t=vector_phi/360*2*pi;
x=[vector_phis(c_phi) vector_phis(c_phi)]/360*2*pi;
y=[0 0.99];


if representacion_polar
figure;
% titulo=[caso num2str(sensores) ' sensores, antenas ' tipo_de_antena ' Diagrama de radiación (polar). \it\theta = ' num2str(vector_thetas(c_theta)) ' º, \phi = (º)'];%...
titulo=[num2str(Numero_de_sensores) ' sensores, antenas ' tipo_de_antena ' \it\phi = ' num2str(vector_phis(c_phi)) 'º, \theta = (º)'];
% for i=1:(tiempo_de_simulacion)
i=1;
    LineSpec.LineWidth=2;
    P=polar(t,0.99*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
%     a=[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(1,vector_phis(c_phi)+1)];
    polar(t(1:end),0.99*[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:) Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),1)]/max(Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(vector_thetas(c_theta),:)'),LineSpec);

    LineSpec2.Marker='.';
    LineSpec2.MarkerSize=15;
    LineSpec2.Color='r';
    polar(0,0.5,LineSpec2)
    polar(0,0.25,LineSpec2)
    polar(0,0,LineSpec2)
    polar(pi,0.25,LineSpec2)
    polar(pi,0.5,LineSpec2)
    
    
    polar(x,y,'k')
    hold off
    title([titulo])
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