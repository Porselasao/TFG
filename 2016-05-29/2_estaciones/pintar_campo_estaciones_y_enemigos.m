%% Ejemplo de representación

cargar=0;
close all
if cargar
% clc
clear
close all

cd resultados
load caso_213_ejecucion_2clusters1.mat
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
[Etot_base{c_antenas,c_sensor,1,1,1,1,i},yei,you,yai,yiu,kkkk] = ...
  Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas_base(i),vector_phis_base(i));
end
 
[Etot1_base{c_antenas,c_sensor,1,1,1,1,i},aaa,b,c,d,e] = ...
    Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,1),freq_config,range_config,deltheta1,delphi1,vector_thetas_base(i),vector_phis_base(i));


for i=1:length(nodo_enemigo(:,1))
[Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i},yei,you,yai,yiu,kkkk] = ...
  Calacula_Campo_entero(array_resultado{c_antenas,c_sensor,1}(:,:,mejor_idx==k),freq_config,range_config,deltheta,delphi,vector_thetas_enemigo(i),vector_phis_enemigo(i));
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
for i=1:length(estacion_base(:,1))
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
    x=[vector_thetas_base(i) vector_thetas_base(i)]/360*2*pi;
    y=[0 1.5];
    vector_thetas_base(i)=round(vector_thetas_base(i));
    vector_phis_base(i)=round(vector_phis_base(i));
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis_base(i)) 'º, \theta = ' num2str(vector_thetas_base(i))])
    
    titulo=[caso num2str(sensores) ' sensores, estación base ' num2str(i) '. \it\phi = ' num2str(vector_phis_base(i)) 'º, \theta = (º)'];
    
    polar(t,[Etot1_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)' Etot1_base{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_base(i)+1)]/max(Etot1_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)'),'r');
    polar(t,[Etot_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)' Etot_base{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_base(i)+1)]/max(Etot_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)'),LineSpec);
    
    polar(x,y,'k')
    hold off
    title([titulo])
    figure;
end

for i=1:length(nodo_enemigo(:,1))
    LineSpec.LineWidth=2;
    P=polar(t,1.00001*ones(size(t)));
    set(P, 'Visible', 'off')
    hold on
    clear x
    x=[vector_thetas_enemigo(i) vector_thetas_enemigo(i)]/360*2*pi;
    y=[0 1.5];
    vector_thetas_enemigo(i)=round(vector_thetas_enemigo(i));
    vector_phis_enemigo(i)=round(vector_phis_enemigo(i));
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis_enemigo(i)) 'º, \theta = ' num2str(vector_thetas_enemigo(i))])
    
    titulo=[caso num2str(sensores) ' sensores, nodo enemigo ' num2str(i) '. \it\phi = ' num2str(vector_phis_enemigo(i)) 'º, \theta = (º)'];
    
    polar(t,[Etot1_base{c_antenas,c_sensor,1,1,1,1,1}(:,vector_phis_base(1)+1)' Etot1_base{c_antenas,c_sensor,1,1,1,1,1}(1,vector_phis_base(1)+1)]/max(Etot1_base{c_antenas,c_sensor,1,1,1,1,1}(:,vector_phis_base(1)+1)'),'r');
    polar(t,[Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_enemigo(i)+1)' Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_enemigo(i)+1)]/max(Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_enemigo(i)+1)'),LineSpec);
    
    polar(x,y,'k')
    hold off
    title([titulo])
    figure;
end
end

if representacion_2D
t=t*360/(2*pi);

for i=1:length(estacion_base(:,1))
    clear x
    vector_thetas_base(i)=round(vector_thetas_base(i));
    vector_phis_base(i)=round(vector_phis_base(i));
    x=[vector_thetas_base(i) vector_thetas_base(i)]/360*2*pi;
    y=[0 1.5];
%     plot(t,[Etot_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)' Etot_base{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_base(i)+1)]/max(Etot_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)'));
    titulo=[caso 'Diagrama de radiación bidimensional, ' num2str(sensores) ' sensores, estación base ' num2str(i) '. \it\phi = ' num2str(vector_phis_base(i)) 'º, \theta = (º)'];
    hold on
    plot(t,[Etot_base{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_base(i)+1)' Etot_base{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_base(i)+1)]/max(max(Etot_base{c_antenas,c_sensor,1,1,1,1,i})),'LineWidth',2);
    plot(x*360/(2*pi),y,'k','LineWidth',2)
    hold off;
    grid on;
    title(titulo,'FontSize',14);
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis_base(i)) 'º, \theta = ' num2str(vector_thetas_base(i))],'FontSize',14)
    axis([0 180 0 1.1])
    set(gca,'FontSize',14,'Color',[1 1 1])
    figure;
    set(i,'Color',[1 1 1])
end

for i=1:length(nodo_enemigo(:,1))
    clear x
    vector_thetas_enemigo(i)=round(vector_thetas_enemigo(i));
    vector_phis_enemigo(i)=round(vector_phis_enemigo(i));
    x=[vector_thetas_enemigo(i) vector_thetas_enemigo(i)]/360*2*pi;
%     if i==1
%         x=[vector_thetas_enemigo(i)-3 vector_thetas_enemigo(i)-3]/360*2*pi;
%     else
%         x=[vector_thetas_enemigo(i)-3 vector_thetas_enemigo(i)-3]/360*2*pi;
%     end
    y=[0 1.5];
%     plot(t,[Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_enemigo(i)+1)' Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_enemigo(i)+1)]/max(Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_enemigo(i)+1)'));
    titulo=[caso 'Diagrama de radiación bidimensional, ' num2str(sensores) ' sensores, nodo enemigo ' num2str(i) '. \it\phi = ' num2str(vector_phis_enemigo(i)) 'º, \theta = (º)'];
    hold on
    plot(t,[Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(:,vector_phis_enemigo(i)+1)' Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i}(1,vector_phis_enemigo(i)+1)]/max(max(Etot_enemigo{c_antenas,c_sensor,1,1,1,1,i})),'LineWidth',2);
    plot(x*360/(2*pi),y,'k','LineWidth',2)
    hold off;
    grid on;
    title(titulo,'FontSize',14);
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis_enemigo(i)) 'º, \theta = ' num2str(vector_thetas_enemigo(i))],'FontSize',14)
    xlabel(['Dirección de radiación \it\phi = ' num2str(vector_phis_enemigo(i)) 'º, \theta = ' num2str(vector_thetas_enemigo(i))],'FontSize',14)
    axis([0 180 0 1.1])
    set(gca,'FontSize',14)
    set(i+1,'Color',[1 1 1])
%     if length(nodo_enemigo(:,1))~=1
    figure;
%     end
end
end
close