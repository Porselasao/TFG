function [geom,gpflg]=Todas_geom()

lambda=3e8/freq_config;

switch Geo
     case 0 % Geometry definition for isotropic element
        geom(1:3,1)=[0 ; 0  ;0  ]; % 
        geom(1:3,2)=[0 ; 0  ;0  ]; % 
        gpflg=0;
   case 1 % Geometry definition for patch element rectangular
        % Rectangular patch parameters
        Er=1;                     % Dielectric constant for substrate
        W=0.5;                    % Patch width (m) affects H-plane beamwidth
        L=0.431;                  % Patch length (m) affects E-plane beamwidth
        h=0.05;                   % Patch height (m) affects E & H plane beamwidth
        patchr_config=[Er,W,L,h]; % Define vector of parameters
        W=patchr_config(1,2);
        L=patchr_config(1,3);
        h=patchr_config(1,4);

        geom(1:3,1)=[-0.5*L ;-0.5*W  ;h  ]; % Bottom left
        geom(1:3,2)=[-0.5*L ; 0.5*W  ;h  ]; % Top left
        geom(1:3,3)=[ 0.5*L ; 0.5*W  ;h  ]; % Top right
        geom(1:3,4)=[ 0.5*L ;-0.5*W  ;h  ]; % Bottom right
        geom(1:3,5)=[-0.5*L ;-0.5*W  ;h  ]; % Bottom left

        gpflg=1;
    case 2 % Geometry definition for patch element circular
        Er=1;                     % Dielectric constant for substrate
        a=0.2;                    % Patch radius (m) affects H-plane beamwidth
        h=0.05;                   % Patch height (m) affects E & H plane beamwidth
        patchc_config=[Er,a,h];   % Define vector of parametersa=patchc_config(1,2);
        h=patchc_config(1,3);
        radius=a;
        segno=0;
        geom(1:3,1)=[radius;0;h];           % circle to start on X-axis

        for seg=1:12                        % Use 12 line segments per turn
          segno=segno+1;                    % Segment number index
          rotang=(seg/12)*2*pi;             % Angle round circle
          xh=radius*cos(rotang);            % X-coord of segment node
          yh=radius*sin(rotang);            % Y-coord of segment node
          zh=h;                             % Z-coord of segment node
          geom(1:3,segno+1)=[xh;yh;zh];     % Load coordinate array 
        end

        gpflg=1;

   

    case 3  % Geometry definition for dipole element
        % Dipole parameters
        length=0.5;              % Length (m)
        %dipole_config=length;    % Define vector of parameters
        dlen= length;
        geom(1:3,1)=[-0.5*dlen ; 0  ;0  ]; % Left hand end
        geom(1:3,2)=[ 0.5*dlen ; 0  ;0  ]; % Right hand end
        gpflg=0;
    case 4   %Geometry definition for dipole element  
        len=0.5;                 % Length (m)
        h=0.25;                  % Height above ground (m)
        dipoleg_config=[len,h];  % Define vector of parameters
        dlen=dipoleg_config(1,1);
        dhgt=dipoleg_config(1,2);
        geom(1:3,1)=[-0.5*dlen ; 0  ;dhgt  ]; % Left hand end
        geom(1:3,2)=[ 0.5*dlen ; 0  ;dhgt  ]; % Right hand end
        gpflg=1;     
         
    case 5 % Geometry definition for helix element
        N=6;                     % Number of turns
        S=0.27;                  % Turn spacing (m)
        helix_config=[N,S];      % Define vector of parameters
        
        N=helix_config(1,1);
        S=helix_config(1,2);
        C=1.2*lambda;

        radius=C/(2*pi);
        segno=0;
        geom(1:3,1)=[radius;0;0];           % Helix start on X-axis

        for turn=1:N                        % Construct turn by turn
         for seg=1:12                       % Use 12 line segments per turn
          segno=segno+1;                    % Segment number index
          rotang=(seg/12)*2*pi;             % Angle round helix
          xh=radius*cos(rotang);            % X-coord of segment node
          yh=radius*sin(rotang);            % Y-coord of segment node
          zh=segno*S/12;                    % Z-coord of segment node
          geom(1:3,segno+1)=[xh;yh;zh];     % Load coordinate array 
         end
        end 

        gpflg=1;
        
    case 6,% Geometry definition for rectangular aperture element.
        a=0.1;                   % Aperture dimension in x-axis (m)
        b=0.5;                   % Aperture dimension in y-axis (m)
        aprect_config=[a,b];
        br=aprect_config(1,1);
        ar=aprect_config(1,2);
        geom(1:3,1)=[-0.5*ar ;-0.5*br  ;0  ]; % Bottom left
        geom(1:3,2)=[-0.5*ar ; 0.5*br  ;0  ]; % Top left
        geom(1:3,3)=[ 0.5*ar ; 0.5*br  ;0  ]; % Top right
        geom(1:3,4)=[ 0.5*ar ;-0.5*br  ;0  ]; % Bottom right
        geom(1:3,5)=[-0.5*ar ;-0.5*br  ;0  ]; % Bottom left
        gpflg=1;    
    case 7,    %circular aperture element
        d=0.5;                   % Aperture diameter (m)
        apcirc_config=[d];
        dia=apcirc_config(1,1);

        radius=dia/2;
        segno=0;
        geom(1:3,1)=[radius;0;0];           % Circle start on X-axis

        for seg=1:24                        % Use 24 line segments 
          segno=segno+1;                    % Segment number index
          rotang=(seg/24)*2*pi;             % Angle round helix
          xh=radius*cos(rotang);            % X-coord of segment node
          yh=radius*sin(rotang);            % Y-coord of segment node
          zh=0;                             % Z-coord of segment node
          geom(1:3,segno+1)=[xh;yh;zh];     % Load coordinate array 
        end
        gpflg=1;
    case 8 % Geometry definition for rectangular waveguide element.
        a=0.1;                   % Guide dimension in x-axis (m)
        b=0.5;                   % Guide dimension in y-axis (m)
        wgr_config=[a,b];
        br=wgr_config(1,1);
        ar=wgr_config(1,2);


        geom(1:3,1)=[-0.5*ar ;-0.5*br  ;0  ]; % Bottom left
        geom(1:3,2)=[-0.5*ar ; 0.5*br  ;0  ]; % Top left
        geom(1:3,3)=[ 0.5*ar ; 0.5*br  ;0  ]; % Top right
        geom(1:3,4)=[ 0.5*ar ;-0.5*br  ;0  ]; % Bottom right
        geom(1:3,5)=[-0.5*ar ;-0.5*br  ;0  ]; % Bottom left

        gpflg=1;
    case 9  % Geometry definition for circular waveguide element
        d=0.5;                   % Guide diameter (m)
        wgc_config=[d];
        dia=wgc_config(1,1);
        radius=dia/2;
        segno=0;
        geom(1:3,1)=[radius;0;0];           % Circle start on X-axis

        for seg=1:24                        % Use 12 line segments per turn
          segno=segno+1;                    % Segment number index
          rotang=(seg/24)*2*pi;             % Angle round helix
          xh=radius*cos(rotang);            % X-coord of segment node
          yh=radius*sin(rotang);            % Y-coord of segment node
          zh=0;                             % Z-coord of segment node
          geom(1:3,segno+1)=[xh;yh;zh];     % Load coordinate array 
        end

       gpflg=1;
    case 10  % Geometry definition for circular parabolic dish
        % Parabolic dish parameters
        d=4.0;                   % Dish diameter (m)
        n=2.0;                   % Aperture taper factor (unitless)
        t=10;                    % Taper value at edge of dish, relative to maximum (dB)
        dish_config=[d,n,t];
        dia=dish_config(1,1);
        radius=dia/2;
        segno=0;
        geom(1:3,1)=[radius;0;0];           % Circle start on X-axis
        for seg=1:24                        % Use 24 line segments 
          segno=segno+1;                    % Segment number index
          rotang=(seg/24)*2*pi;             % Angle round helix
          xh=radius*cos(rotang);            % X-coord of segment node
          yh=radius*sin(rotang);            % Y-coord of segment node
          zh=0;                             % Z-coord of segment node
          geom(1:3,segno+1)=[xh;yh;zh];     % Load coordinate array 
        end
        geom(1:3,segno+2)=[nan;nan;nan];                               % Line break
        rot120=120*pi/180;
        geom(1:3,segno+3)=[radius*cos(0);radius*sin(0);0];             % Strut1 end1
        geom(1:3,segno+4)=[0;0;radius/1.5];                            % Strut1 end2
        geom(1:3,segno+5)=[nan;nan;nan];                               % Line break
        geom(1:3,segno+6)=[radius*cos(rot120);radius*sin(rot120);0];   % Strut2 end1
        geom(1:3,segno+7)=[0;0;radius/1.5];                            % Strut2 end2 
        geom(1:3,segno+8)=[nan;nan;nan];                               % Line break
        geom(1:3,segno+9)=[radius*cos(-rot120);radius*sin(-rot120);0]; % Strut2 end1
        geom(1:3,segno+10)=[0;0;radius/1.5];                           % Strut2 end2 
        gpflg=1;
        
    
    otherwise, disp('Unknown Element Type, set to iso');Elt=0;
end
