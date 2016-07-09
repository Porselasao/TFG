%% Ejemplo de representación

% clear
cargar=1;
posicion_X=[-9 -7 -5 -3 -1 1 3 5 7 9];
posicion_Y=[-2.23974923001422 1.79702676853675 1.55098003973841 -3.37388264805369 -3.81002318441623 -0.0163594801785705 4.59743958516081 -1.59614273333867 0.852677509797774 -2.76188060508863];
posicion_Z=zeros(1,10);
if cargar
Numero_de_sensores = 10;
array_config4=- ones(3,5,Numero_de_sensores);
tipo_antena=0;

fase=0;

for i=1:Numero_de_sensores
    array_config2(:,:,i)=place_element(array_config4,posicion_X(i),posicion_Y(i),posicion_Z(i),tipo_antena, 1,fase);
    fase=fase+90;
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
t=vector_theta/360*2*pi;
x=[vector_thetas(c_theta) vector_thetas(c_theta)]/360*2*pi;
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
    polar(t(1:end),0.99*[Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)' Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(1,vector_phis(c_phi)+1)]/max(Etot{c_antenas,c_sensor,c_phi,c_theta,i,1}(:,vector_phis(c_phi)+1)'),LineSpec);

    LineSpec2.Marker='.';
    LineSpec2.MarkerSize=15;
    LineSpec2.Color='r';
    
    for j=1:Numero_de_sensores
        [amplitud(j),theta(j),phi(j)]=cart2sph2([posicion_X(j) posicion_Y(j) posicion_Z(j)]);
    end
    amplitud=amplitud/max(amplitud)*0.3;
    for j=1:Numero_de_sensores
    polar(phi(j)/360*2*pi,abs(amplitud(j)),LineSpec2)
    end
    
    
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