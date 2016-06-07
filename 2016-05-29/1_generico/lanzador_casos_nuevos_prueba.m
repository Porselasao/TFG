function lanzador_casos_nuevos_prueba(ejec,numero,clusters_fijados)

ejec=str2num(ejec);
numero=str2num(numero); % Solo para .exe
clusters_fijados=str2num(clusters_fijados);  % Solo para .exe

rng(numero*10000+ejec*100+clusters_fijados);


    %Potencia fija 2D   200 gen 100 pob
if numero==100
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=16;theta=45;phi=[0];
    
elseif numero==101
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=18;theta=45;phi=[0];
    
elseif numero==102
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=20;theta=45;phi=[0];
    
elseif numero==103
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=22;theta=45;phi=[0];
    
elseif numero==104
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=24;theta=45;phi=[0];
    
elseif numero==105
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=26;theta=45;phi=[0];
    
elseif numero==106
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=28;theta=45;phi=[0];
    
elseif numero==107
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=30;theta=45;phi=[0];
    
    %Potencia alea 3D   200 gen 100 pob
elseif numero==108
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=16;theta=45;phi=[0];
    
elseif numero==109
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=18;theta=45;phi=[0];
    
elseif numero==110
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=20;theta=45;phi=[0];
    
elseif numero==111
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=22;theta=45;phi=[0];
    
elseif numero==112
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=24;theta=45;phi=[0];
    
elseif numero==113
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=26;theta=45;phi=[0];
   
elseif numero==114
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=28;theta=45;phi=[0];
    
elseif numero==115
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=30;theta=45;phi=[0];
    
   
    %Potencia fija 2D   400 gen 100 pob
elseif numero==116
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=32;theta=45;phi=[0];
    
elseif numero==117
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=34;theta=45;phi=[0];
    
elseif numero==118
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=36;theta=45;phi=[0];
    
elseif numero==119
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=38;theta=45;phi=[0];
    
elseif numero==120
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=40;theta=45;phi=[0];
    
elseif numero==121
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=42;theta=45;phi=[0];
    
elseif numero==122
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=44;theta=45;phi=[0];
    
elseif numero==123
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=46;theta=45;phi=[0];
    
elseif numero==124
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=48;theta=45;phi=[0];
    
elseif numero==125
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=50;theta=45;phi=[0];
    
    %Potencia alea 3D   400 gen 100 pob
elseif numero==126
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=32;theta=45;phi=[0];
    
elseif numero==127
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=34;theta=45;phi=[0];
    
elseif numero==128
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=36;theta=45;phi=[0];
    
elseif numero==129
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=38;theta=45;phi=[0];
    
elseif numero==130
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=40;theta=45;phi=[0];
    
elseif numero==131
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=42;theta=45;phi=[0];
    
elseif numero==132
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=44;theta=45;phi=[0];
    
elseif numero==133
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=46;theta=45;phi=[0];
    
elseif numero==134
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=48;theta=45;phi=[0];
    
elseif numero==135
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;theta=45;phi=[0];


    
    %Potencia fija 2D   400 gen 200 pob
elseif numero==136
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=32;theta=45;phi=[0];
    
elseif numero==137
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=34;theta=45;phi=[0];
    
elseif numero==138
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=36;theta=45;phi=[0];
    
elseif numero==139
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=38;theta=45;phi=[0];
    
elseif numero==140
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=40;theta=45;phi=[0];
    
elseif numero==141
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=42;theta=45;phi=[0];
    
elseif numero==142
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=44;theta=45;phi=[0];
    
elseif numero==143
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=46;theta=45;phi=[0];
    
elseif numero==144
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=48;theta=45;phi=[0];
    
elseif numero==145
    antenas=[0];sensores_fijos=1;potencia_fija=1;dimension=2;sensores=50;theta=45;phi=[0];
    
    %Potencia alea 3D   400 gen 200 pob
elseif numero==146
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=32;theta=45;phi=[0];
    
elseif numero==147
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=34;theta=45;phi=[0];
    
elseif numero==148
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=36;theta=45;phi=[0];
    
elseif numero==149
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=38;theta=45;phi=[0];
    
elseif numero==150
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=40;theta=45;phi=[0];
    
elseif numero==151
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=42;theta=45;phi=[0];
    
elseif numero==152
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=44;theta=45;phi=[0];
    
elseif numero==153
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=46;theta=45;phi=[0];
    
elseif numero==154
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=48;theta=45;phi=[0];
    
elseif numero==155
    antenas=[0];sensores_fijos=1;potencia_fija=0;dimension=3;sensores=50;theta=45;phi=[0];

end

tiempo_de_simulacion=1;deltheta=90;delphi=90;deltheta1=90;delphi1=90;

% if (numero<=115)
%     generaciones=200;poblacion=100;
% elseif (numero>=116 && numero<=135)
%     generaciones=400;poblacion=100;
% elseif (numero>=136 && numero<=155)
%     generaciones=400;poblacion=200;
% end

generaciones=2;poblacion=2;

casos(ejec,numero,antenas,sensores_fijos,potencia_fija,dimension,sensores,theta,phi,tiempo_de_simulacion,deltheta,delphi,deltheta1,delphi1,generaciones,poblacion,clusters_fijados)
disp('Finished');

