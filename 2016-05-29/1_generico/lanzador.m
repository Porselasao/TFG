function lanzador(ejec,numero,clusters_fijados)

ejec=str2num(ejec);
numero=str2num(numero); % Solo para .exe
clusters_fijados=str2num(clusters_fijados);  % Solo para .exe

rng(numero*10000+ejec*100+clusters_fijados);

tiempo_de_simulacion=1;deltheta=1;delphi=1;deltheta1=1;delphi1=1;generaciones=200;poblacion=100;

if numero==1
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=2;theta=45;phi=[0 45];
    
elseif numero==2
%     antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=5;theta=45;phi=[0 45];
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=5;theta=45;phi=[45];
    
elseif numero==3
%     antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=10;theta=45;phi=[0 45];
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=10;theta=45;phi=[45];
    
elseif numero==4
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=20;theta=45;phi=[0 45];
    
elseif numero==5
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=50;theta=45;phi=[0 45];
    
elseif numero==6
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=2;theta=45;phi=[0 45];
    
elseif numero==7
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=5;theta=45;phi=[0 45];
    
elseif numero==8
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=10;theta=45;phi=[0 45];
    
elseif numero==9
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=20;theta=45;phi=[0 45];
    
elseif numero==10
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=2;sensores=50;theta=45;phi=[0 45];
    
elseif numero==11
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=2;sensores=2;theta=45;phi=[0 45];
    
elseif numero==12
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=2;sensores=5;theta=45;phi=[0 45];
    
elseif numero==13
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=2;sensores=10;theta=45;phi=[0 45];
    
elseif numero==14
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=2;sensores=20;theta=45;phi=[0 45];
    
elseif numero==15
    antenas=[0 3];sensores_fijos=0;potencia_fija=1;dimension=2;sensores=50;theta=45;phi=[0 45];
    
elseif numero==16
    antenas=[0 3];sensores_fijos=0;potencia_fija=0;dimension=2;sensores=2;theta=45;phi=[0 45];
    
elseif numero==17
    antenas=[0 3];sensores_fijos=0;potencia_fija=0;dimension=2;sensores=5;theta=45;phi=[0 45];
    
elseif numero==18
    antenas=[0 3];sensores_fijos=0;potencia_fija=0;dimension=2;sensores=10;theta=45;phi=[0 45];
    
elseif numero==19
    antenas=[0 3];sensores_fijos=0;potencia_fija=0;dimension=2;sensores=20;theta=45;phi=[0 45];
    
elseif numero==20
    antenas=[0 3];sensores_fijos=0;potencia_fija=0;dimension=2;sensores=50;theta=45;phi=[0 45];
    
elseif numero==21
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=2;theta=45;phi=[0 45];
    
elseif numero==22
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;theta=45;phi=[0 45];
    
elseif numero==23
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=10;theta=45;phi=[0 45];
    
elseif numero==24
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=20;theta=45;phi=[0 45];
    
elseif numero==25
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=50;theta=45;phi=[0 45];
    
elseif numero==26
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=2;theta=45;phi=[0 45];
    
elseif numero==27
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=5;theta=45;phi=[0 45];
    
elseif numero==28
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;theta=45;phi=[0 45];
    
elseif numero==29
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;theta=45;phi=[0 45];
    
elseif numero==30
    antenas=[0 3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;theta=45;phi=[0 45];
    
elseif numero== 225
    antenas=[3];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=10;theta=45;phi=[0];
    tiempo_de_simulacion=1;deltheta=1;delphi=1;deltheta1=1;delphi1=1;generaciones=2;poblacion=2;

elseif numero==230
    antenas=[0 3];sensores_fijos=1;potencia_fija=1;dimension=3;sensores=5;theta=45;phi=[0 45];
    tiempo_de_simulacion=1;deltheta=30;delphi=30;deltheta1=30;delphi1=30;generaciones=2;poblacion=2;
    
    
end

casos(ejec,numero,antenas,sensores_fijos,potencia_fija,dimension,sensores,theta,phi,tiempo_de_simulacion,deltheta,delphi,deltheta1,delphi1,generaciones,poblacion,clusters_fijados)
disp('Finished');

