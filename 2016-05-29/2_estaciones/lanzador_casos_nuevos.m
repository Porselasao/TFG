function lanzador_casos_nuevos(ejec,numero,clusters_fijados)

ejec=str2num(ejec);
numero=str2num(numero); % Solo para .exe
clusters_fijados=str2num(clusters_fijados);  % Solo para .exe

rng(numero*10000+ejec*100+clusters_fijados);

global estacion;
global estacion_si;
global estacion_no_deseada;
global estacion_no_deseada_si;

estacion(1,:)=[115 65 45];
estacion(2,:)=[115 -50 45];
estacion(3,:)=[-100 65 45];
estacion(4,:)=[-100 -50 45];
estacion(5,:)=[-150 -150 45];

estacion_no_deseada(1,:)=[120 -80 20];
estacion_no_deseada(2,:)=[-120 -90 20];
estacion_no_deseada(3,:)=[130 -180 30];
estacion_no_deseada(4,:)=[-140 190 10];
estacion_no_deseada(5,:)=[200 150 20];

tiempo_de_simulacion=1;deltheta=1;delphi=1;deltheta1=1;delphi1=1;generaciones=200;poblacion=100;
global elegir_mejor_estacion;
elegir_mejor_estacion=0;

% Una deseada y varias no deseadas
if numero==201
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==202
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==203
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==204
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:2,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==205
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:2,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==206
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:2,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==207
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:3,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==208
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:3,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==209
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:3,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==210
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:4,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==211
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:4,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==212
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:4,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==213
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:5,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    
elseif numero==214
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:5,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==215
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1,:);
    estacion_no_deseada=estacion_no_deseada(1:5,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;

% Varias deseadas y varias no deseadas    
    
elseif numero==220
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:2,:);
    estacion_no_deseada=estacion_no_deseada(1,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==221
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:2,:);
    estacion_no_deseada=estacion_no_deseada(1,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==222
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:3,:);
    estacion_no_deseada=estacion_no_deseada(1:2,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==223
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:3,:);
    estacion_no_deseada=estacion_no_deseada(1:2,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==224
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:4,:);
    estacion_no_deseada=estacion_no_deseada(1:3,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==225
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:4,:);
    estacion_no_deseada=estacion_no_deseada(1:3,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
elseif numero==226
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:5,:);
    estacion_no_deseada=estacion_no_deseada(1:4,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    
elseif numero==227
    estacion_si=1;
    estacion_no_deseada_si=1;
    estacion=estacion(1:5,:);
    estacion_no_deseada=estacion_no_deseada(1:4,:);
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;

% Múltiples estaciones deseadas para elegir

elseif numero==231
    estacion_si=1;
    estacion_no_deseada_si=0;
    elegir_mejor_estacion=1;
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;
    

elseif numero==232
    estacion_si=1;
    estacion_no_deseada_si=0;
    elegir_mejor_estacion=1;
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;
    

elseif numero==233
    estacion_si=1;
    estacion_no_deseada_si=0;
    elegir_mejor_estacion=1;
    
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;
    
end

casos(ejec,numero,antenas,sensores_fijos,potencia_fija,dimension,sensores,tiempo_de_simulacion,deltheta,delphi,deltheta1,delphi1,generaciones,poblacion,clusters_fijados)
disp('Finished');

