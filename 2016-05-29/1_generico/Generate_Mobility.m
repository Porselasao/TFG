function s_mobility = Generate_Mobility(s_input)
    %The Random Waypoint mobility model.
    global s_mobility_tmp;
    global nodeIndex_tmp;
    global speed_z;
        
    s_mobility.NB_NODES = s_input.NB_NODES;
    s_mobility.SIMULATION_TIME = s_input.SIMULATION_TIME;
    s_mobility.V_POSITION_X_INTERVAL=s_input.V_POSITION_X_INTERVAL;
    s_mobility.V_POSITION_Y_INTERVAL=s_input.V_POSITION_Y_INTERVAL;
    s_mobility.V_POSITION_Z_INTERVAL=s_input.V_POSITION_Z_INTERVAL;
    
    for nodeIndex_tmp = 1:s_mobility.NB_NODES
        speed_z=unifrnd(s_input.V_SPEED_INTERVAL(1),s_input.V_SPEED_INTERVAL(2));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%Initialize:
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION = [];

        previousX = unifrnd(s_input.V_POSITION_X_INTERVAL(1),s_input.V_POSITION_X_INTERVAL(2));
        previousY = unifrnd(s_input.V_POSITION_Y_INTERVAL(1),s_input.V_POSITION_Y_INTERVAL(2));
        previousZ = unifrnd(s_input.V_POSITION_Z_INTERVAL(1),s_input.V_POSITION_Z_INTERVAL(2));
        previousDuration = 0;
        previousTime = 0;
        Out_setRestrictedWalk_random_waypoint(previousX,previousY,previousZ,previousDuration,previousTime,s_input);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Promenade     
        while (s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end) < s_input.SIMULATION_TIME)
            if (s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING(end) == false)%Maintenant c'est le temps d'être mobile
                previousX = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(end);
                previousY = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(end);
                previousZ = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(end);
                previousDuration = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end);
                previousTime = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end);
                Out_setRestrictedWalk_random_waypoint(previousX,previousY,previousZ,previousDuration,previousTime,s_input);
            else
                %%%%%%%%Node is taking a pause:
                previousDirection = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(end);
                previousSpeed = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(end);
                previousX = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(end);
                previousY = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(end);
                previousZ = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(end);
                previousTime = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end);
                previousDuration = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end);
                distance = previousDuration*previousSpeed;
                distance_z = previousDuration*speed_z;
                %%%
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end+1,1) = previousTime + previousDuration;
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(end+1,1) = (previousX + distance*cosd(previousDirection));
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(end+1,1) = (previousY + distance*sind(previousDirection));
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(end+1,1) = (previousZ + distance_z);
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(end+1,1) = 0;
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(end+1,1) = 0;
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING(end+1,1) = false;
                s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end+1,1) = Out_adjustDuration_random_waypoint(s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end),unifrnd(s_input.V_PAUSE_INTERVAL(1),s_input.V_PAUSE_INTERVAL(2)),s_input);
            end
        end
        %%%%%%%%%%%%%%%%%%To have speed vectors as well rather than
        %%%%%%%%%%%%%%%%%%only the scalar value:
        nb_speed = length(s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE);
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_X = zeros(nb_speed,1);
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Y = zeros(nb_speed,1);
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Z = speed_z;
        for s = 1:nb_speed
            speed = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(s);
            direction = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(s);
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_X(s) = speed*cosd(direction);
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Y(s) = speed*sind(direction);
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Z(s) = speed_z; %%
        end

        %%%%%%%%%%%%%%%%%%To remove null pauses:
        v_index = s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(1:end-1) == 0;
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_X(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Y(v_index) = [];
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Z(v_index) = [];

        %%%%%%%%%%%%%%%%%%To remove the too small difference at the end, if
        %%%%%%%%%%%%%%%%%%there is one:
        if ((s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end) - s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end-1)) < 1e-14)
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_X(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Y(end) = [];
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Z(end) = [];
        end
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end) = s_input.SIMULATION_TIME;
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end) = 0;
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(end) = 0;
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_X(end) = 0;
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Y(end) = 0;
        s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Z(end) = 0;
        
        s_mobility.VS_NODE(nodeIndex_tmp) = struct('V_TIME',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME,...
                                              'V_POSITION_X',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X,...
                                              'V_POSITION_Y',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y,...
                                              'V_POSITION_Z',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z,...
                                              'V_SPEED_X',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_X,...
                                              'V_SPEED_Y',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Y,...
                                              'V_SPEED_Z',s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_Z);
    end
    
    clear s_mobility_tmp;
    clear nodeIndex_tmp;
end

function duration = Out_adjustDuration_random_waypoint(time,duration,s_input)
%     if ((time+duration) > s_input.SIMULATION_TIME)
%         duration = s_input.SIMULATION_TIME - time;
%     end
end

function Out_setRestrictedWalk_random_waypoint(previousX,previousY,previousZ,previousDuration,previousTime,s_input)

    global s_mobility_tmp;
    global nodeIndex_tmp;
    global speed_z;
    
    
    
    
    x_tmp = previousX;
    y_tmp = previousY;
    z_tmp = previousZ;
    time_tmp = previousTime + previousDuration;
    duration_tmp = Out_adjustDuration_random_waypoint(time_tmp,unifrnd(s_input.V_WALK_INTERVAL(1),s_input.V_WALK_INTERVAL(2)),s_input);
    direction_tmp = unifrnd(s_input.V_DIRECTION_INTERVAL(1),s_input.V_DIRECTION_INTERVAL(2));
    speed = unifrnd(s_input.V_SPEED_INTERVAL(1),s_input.V_SPEED_INTERVAL(2));
    distance_tmp = speed*duration_tmp;
    distance_tmp_z = speed_z*duration_tmp;  %%añadido
%     if (distance_tmp == 0)
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end+1,1) = time_tmp;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(end+1,1) =  x_tmp;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(end+1,1) =  y_tmp;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(end+1,1) =  z_tmp;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(end+1,1) = direction_tmp;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(end+1,1) = speed;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING(end+1,1) = true;
%         s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end+1,1) = duration_tmp;
%     else
        %The loop begins:
        flag_mobility_finished = false;
        while (~flag_mobility_finished)
            x_dest = x_tmp + distance_tmp*cosd(direction_tmp);
            y_dest = y_tmp + distance_tmp*sind(direction_tmp);
            z_dest = z_tmp + distance_tmp_z;
            flag_mobility_was_outside = false;
            if (x_dest > s_input.V_POSITION_X_INTERVAL(2))
                flag_mobility_was_outside = true;
                direction_tmp = 180 - direction_tmp;
                x_dest = x_tmp + distance_tmp*cosd(direction_tmp);
                y_dest = y_tmp + distance_tmp*sind(direction_tmp);
            end
            if (x_dest < s_input.V_POSITION_X_INTERVAL(1))
                flag_mobility_was_outside = true;
                direction_tmp = 180 - direction_tmp;
                x_dest = x_tmp + distance_tmp*cosd(direction_tmp);
                y_dest = y_tmp + distance_tmp*sind(direction_tmp);
            end
            if (y_dest > s_input.V_POSITION_Y_INTERVAL(2))
                flag_mobility_was_outside = true;
                direction_tmp = -direction_tmp;
                x_dest = x_tmp + distance_tmp*cosd(direction_tmp);
                y_dest = y_tmp + distance_tmp*sind(direction_tmp);
            end
            if (y_dest < s_input.V_POSITION_Y_INTERVAL(1))
                flag_mobility_was_outside = true;
                direction_tmp = -direction_tmp;
                x_dest = x_tmp + distance_tmp*cosd(direction_tmp);
                y_dest = y_tmp + distance_tmp*sind(direction_tmp);
            end
            if (z_dest > s_input.V_POSITION_Z_INTERVAL(2))  %% Añadido
                flag_mobility_was_outside = true;
                z_dest = z_tmp - distance_tmp_z;
                speed_z = -speed_z;
                direction_tmp = direction_tmp;
            end
            if (z_dest < s_input.V_POSITION_Y_INTERVAL(1))  %% Añadido
                z_dest = z_tmp - distance_tmp_z;
                speed_z = -speed_z;
                direction_tmp = direction_tmp;
            end
            

            current_distance = abs(diff([x_tmp x_dest]) + 1i*diff([y_tmp y_dest])); %% ¿Introducir z en el cálculo de la distancia? No, porque existe distance_tmp_z
            current_duration = Out_adjustDuration_random_waypoint(time_tmp,(current_distance)/speed,s_input);
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_TIME(end+1,1) = time_tmp;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_X(end+1,1) = x_tmp;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Y(end+1,1) = y_tmp;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_POSITION_Z(end+1,1) = z_tmp;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DIRECTION(end+1,1) = direction_tmp;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_SPEED_MAGNITUDE(end+1,1) = speed;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_IS_MOVING(end+1,1) = true;
            s_mobility_tmp.VS_NODE(nodeIndex_tmp).V_DURATION(end+1,1) = current_duration;

                time_tmp = time_tmp + current_duration;
                duration_tmp = duration_tmp - current_duration;
                distance_tmp = distance_tmp - current_distance;
                distance_tmp_z = speed_z*duration_tmp;
                x_tmp = x_dest;
                y_tmp = y_dest;
                z_tmp = z_dest;
                flag_mobility_finished = true;

%         end
        %the loop ended
        end
end
