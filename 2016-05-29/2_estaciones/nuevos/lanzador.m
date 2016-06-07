function lanzador(ejec,numero,clusters_fijados)

% ejec=str2num(ejec);
% numero=str2num(numero); % Solo para .exe
% clusters_fijados=str2num(clusters_fijados);  % Solo para .exe

rng(numero*10000+ejec*100+clusters_fijados);

global estacion;
global estacion_si;
global estacion_no_deseada;
global estacion_no_deseada_si;

estacion(1,:)=[100 40 80];
estacion_no_deseada(1,:)=[100 40 80];

tiempo_de_simulacion=1;
deltheta=1;
delphi=1;
deltheta1=1;
delphi1=1;
generaciones=1000;
poblacion=200;
    
if numero==37
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=5;
elseif numero==102
    estacion_si=1;
    estacion_no_deseada_si=1;
%     estacion(2,:)=[-6 40 120];
%     estacion(3,:)=[-30 6 0];
  estacion_no_deseada(1,:)=[0 40 80];
%    estacion_no_deseada(2,:)=[100 0 80];
    
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
    
elseif numero==38
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=10;
    
elseif numero==39
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=5;
    
elseif numero==40
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=10;
    
elseif numero==41
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;
    
elseif numero==42
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
    
elseif numero==43
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=5;
    
elseif numero==44
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==45
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=3;sensores=5;
    
elseif numero==46
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=3;sensores=10;
    
elseif numero==47
    estacion_si=1;
    estacion_no_deseada_si=0;
    estacion(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;
    
elseif numero==48
    estacion_si=1;
    estacion_no_deseada_si=0;
    estacion(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
    
elseif numero==49
    estacion_si=1;
    estacion_no_deseada_si=0;
    estacion(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=5;
    
elseif numero==50
    estacion_si=1;
    estacion_no_deseada_si=0;
    estacion(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==51
    estacion_si=0;
    estacion_no_deseada_si=1;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;
    
elseif numero==52
    estacion_si=0;
    estacion_no_deseada_si=1;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
    
elseif numero==53
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;
    
elseif numero==54
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
    
elseif numero==55
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=5;
    
elseif numero==56
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==57
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=50;
    
elseif numero==58
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=50;generaciones=400;
    
elseif numero==59
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=100;
    
elseif numero==60
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=100;generaciones=400;
    
elseif numero==61
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[1 2 4 5 6 7 8 9 10];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
 
    
    
elseif numero==65
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=20;
    
elseif numero==66
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=20;
    
elseif numero==67
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=20;
    
elseif numero==68
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==69
    estacion_si=1;
    estacion_no_deseada_si=0;
    estacion(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=20;
    
elseif numero==70
    estacion_si=1;
    estacion_no_deseada_si=0;
    estacion(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==71
    estacion_si=0;
    estacion_no_deseada_si=1;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=20;
    
elseif numero==72
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=20;
    
elseif numero==73
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
    
    
elseif numero==222
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;
    tiempo_de_simulacion=1;deltheta=30;delphi=30;deltheta1=30;delphi1=30;generaciones=2;poblacion=2;

elseif numero==230
    estacion_si=0;
    estacion_no_deseada_si=1;
    estacion_no_deseada(2,:)=[-30 40 120];
    
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;
    tiempo_de_simulacion=1;deltheta=30;delphi=30;deltheta1=30;delphi1=30;generaciones=5;poblacion=5;
    
elseif numero==235
    estacion_si=1;
    estacion_no_deseada_si=0;
    
    antenas=[1 2 4 5 6 7 8 9 10];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;
    tiempo_de_simulacion=1;deltheta=30;delphi=30;deltheta1=30;delphi1=30;generaciones=2;poblacion=2;
    
end

casos(ejec,numero,antenas,sensores_fijos,potencia_fija,dimension,sensores,tiempo_de_simulacion,deltheta,delphi,deltheta1,delphi1,generaciones,poblacion,clusters_fijados)
disp('Finished');

