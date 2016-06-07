function [s_mobility] = movilidad(tiempo_de_simulacion,Numero_de_sensores,dim_x,dim_y,dim_z)

% Posicion_X y posicion_Y son matrices de "Numeros_de_sensores" filas que
% contienen cierta cantidad de valores en X y en Y de cada uno de los
% sensores. En concreto, esta cantidad de valores será la mínima ofrecida
% por los sensores, pues resulta que no todos los sensores se mueven por
% igual.

% Sería necesario saber por qué en unos hay más posiciones que en otros. <-- IMPORTANTE!

    s_input = struct('V_POSITION_X_INTERVAL',[0 dim_x],...%(m)
                     'V_POSITION_Y_INTERVAL',[0 dim_y],...%(m)
                     'V_POSITION_Z_INTERVAL',[0 dim_z],...%(m)
                     'V_SPEED_INTERVAL',[0.2 0.32],...%(m/s)
                     'V_PAUSE_INTERVAL',[1 1],...%pause time (s)
                     'V_WALK_INTERVAL',[1.00 1.00],...%walk time (s)
                     'V_DIRECTION_INTERVAL',[-180 180],...%(degrees)
                     'SIMULATION_TIME',tiempo_de_simulacion,...%(s)
                     'NB_NODES',Numero_de_sensores);
    s_mobility = Generate_Mobility(s_input);
    
    % En este for, vamos introduciendo en la matrices posicion_X y
    % posicion_Y las coordenadas de los sensores. De nuevo, recordamos que
    % en la fila tenemos el sensor 1, sensor 2, etc., y en las columnas
    % tenemos la coordenada 1, coordenada 2, etc.
%     for nodos=1:Numero_de_sensores
%         posicion_X(nodos,1:posiciones_totales)=s_mobility.VS_NODE(nodos).V_POSITION_X(1:posiciones_totales);
%         posicion_Y(nodos,1:posiciones_totales)=s_mobility.VS_NODE(nodos).V_POSITION_Y(1:posiciones_totales);
%         posicion_Z(nodos,1:posiciones_totales)=s_mobility.VS_NODE(nodos).V_POSITION_Z(1:posiciones_totales);
%     end
end