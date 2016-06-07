function [Etot,CPflag]=Antenas_todas(theta,phi,freq,Geo);

lambda=3e8/freq;
ko=2*pi/lambda;
theta_in=theta;
phi_in=phi;

switch Geo
    
    
    case 0 % Geometry definition for isotropic element
        Etot=1;
        CPflag=1;
    case 1 % Geometry definition for patch element rectangular
        % Rectangular patch parameters
        Er=1;                     % Dielectric constant for substrate
        W=0.5;                    % Patch width (m) affects H-plane beamwidth
        L=0.431;                  % Patch length (m) affects E-plane beamwidth
        h=0.05;                   % Patch height (m) affects E & H plane beamwidth
        patchr_config=[Er,W,L,h]; % Define vector of parameters
       % Rotate coords 90 deg about x-axis to match array_utils coord system
        % with coord system used in the model.


% 
%         [xff,yff,zff]=sph2cart1(999,theta,phi);
%         xffd=zff;
%         yffd=xff;
%         zffd=yff;
%         [r,thp,php]=cart2sph1(xffd,yffd,zffd);
%         phi=php;
%         theta=thp;
        theta_in=theta;
        
        % Trap potential division by zero warning
        if theta==0;theta=1e-9;end
        if phi==0;phi=1e-9;end

        Er=patchr_config(1,1);
        W=patchr_config(1,2);
        L=patchr_config(1,3);
        h=patchr_config(1,4);

        % Calculate effictive dielectric constant for microstrip
        % line of width W on dielectric material of constant Er

        Ereff=((Er+1)/2)+((Er-1)/2)*(1+12*(h/W)).^-0.5;

        % Calculate increase length dL of patch length L due to fringing
        % fields at each end, giving total effective length Leff = L + 2*dL

        F1=(Ereff+0.3)*(W/h+0.264);
        F2=(Ereff-0.258)*(W/h+0.8);
        dL=h*0.412*(F1/F2);

        Leff=L+2*dL;

        % Calculate effective width Weff for patch, uses standard Er
        % value.

        Weff=W*sqrt((Er+1)/2);

        heff=h*sqrt(Er);

        % Patch pattern function of theta and phi, note the theta and
        % phi for the function are defined differently to theta_in and phi_in

        Numtr2=sin(ko*heff.*cos(phi)/2);
        Demtr2=(ko*heff.*cos(phi))/2;
        Fphi=(Numtr2./Demtr2).*cos((ko*Leff/2).*sin(phi));

        Numtr1=sin((ko*heff/2).*sin(theta));
        Demtr1=((ko*heff/2).*sin(theta));
        Numtr1a=sin((ko*Weff/2).*cos(theta));
        Demtr1a=((ko*Weff/2).*cos(theta));
        Ftheta=((Numtr1.*Numtr1a)./(Demtr1.*Demtr1a)).*sin(theta);

        % Due to groundplane function is only valid for 
        % theta values :   0 < theta < 90   for all phi

        % Modify pattern for theta values close to 90 to give
        % smooth roll-off, standard model truncates H-plane
        % at theta=90. PatEdgeSF has value=1 except at theta close
        % to 90 where it drops (proportional to 1/x^2) to 0

        rolloff_factor=0.15;                                   % 1=sharp, 1<=softer
        theta_in_deg=theta_in*180/pi;                          % theta_in in Deg
        F1=1./(((rolloff_factor*(theta_in_deg-90)).^2)+0.001); % intermediate calc
        PatEdgeSF=1./(F1+1);                                   % Pattern scaling factor

        if theta_in < pi/2
         Etot=Ftheta*Fphi*PatEdgeSF;  % Total pattern by pattern multiplication
        else Etot=0;
        end
        CPflag=0;
        
        
  
    
    case 2 % Geometry definition for patch element circular
        Er=1;                     % Dielectric constant for substrate
        a=0.2;                    % Patch radius (m) affects H-plane beamwidth
        h=0.05;                   % Patch height (m) affects E & H plane beamwidth
        patchc_config=[Er,a,h];   % Define vector of parametersa=patchc_config(1,2);
       % Rotate coords 90 deg about x-axis to match array_utils coord system
        % with coord system used in the model.
% Para diseñar el parche
        Eo=8.854185e-12;
        v=3e8;
        h=h*100;         % Formula uses (cm)

        lambda=v/freq;
       

        F=8.791e9/(freq*sqrt(Er));

        F1=(2*h)/(pi*Er*F);
        F2=log((pi*F)/(2*h))+1.7726;

        a=F/sqrt(1+F1*F2);   % Formula gives a in cm

        patchcfg=[Er,a/100,h/100];

        %[xff,yff,zff]=sph2cart1(999,theta_in,phi_in);
        %xffd=zff;
        %yffd=xff;
        %zffd=yff;
        %[r,thp,php]=cart2sph1(xffd,yffd,zffd);
        phi=phi_in;
        theta=theta_in;      

        Er=patchc_config(1,1);     % Dielectric constant
        a=patchc_config(1,2)*100;  % Patch radius in (cm)
        h=patchc_config(1,3)*100;  % Substrate height (cm)



        % Calculate effective radius of patch

        F1=(2*h)/(pi*a*Er);
        F2=log((pi*a)/(2*h))+1.7726;
        aeff=a*sqrt(1+F1*F2)/100;     % Effective patch radius (m)

        F3=sin(ko*(h/100)*cos(theta))/(ko*(h/100)*cos(theta));

        Ja02=besselj(0,(ko*aeff*sin(theta)))-besselj(2,(ko*aeff*sin(theta)));
        Jb02=besselj(0,(ko*aeff*sin(theta)))+besselj(2,(ko*aeff*sin(theta)));

        Ftheta=-j*cos(phi)*Ja02*F3;
        Fphi=j*cos(theta)*sin(phi)*Jb02*F3;

        % Due to groundplane function is only valid for 
        % theta values :   0 < theta < 90   for all phi

        % Modify pattern for theta values close to 90 to give
        % smooth roll-off, standard model truncates H-plane
        % at theta=90. PatEdgeSF has value=1 except at theta close
        % to 90 where it drops (proportional to 1/x^2) to 0

        rolloff_factor=0.15;                                   % 1=sharp, 1<=softer
        theta_in_deg=theta_in*180/pi;                          % theta_in in Deg
        F1=1./(((rolloff_factor*(theta_in_deg-90)).^2)+0.001); % intermediate calc
        PatEdgeSF=1./(F1+1);                                   % Pattern scaling factor

        if theta_in < pi/2
          Etot=sqrt((abs(Ftheta))^2+(abs(Fphi))^2)*PatEdgeSF;  %Power sum of Etheta and Ephi
        else Etot=0;
        end
        CPflag=0;


    case 3  % Geometry definition for dipole element
        % Dipole parameters
        length=0.5;              % Length (m)
        %dipole_config=length;    % Define vector of parameters
        dlen= length;
        [xff,yff,zff]=sph2cart1(999,theta_in,phi_in);
        xffd=-zff;
        yffd=yff;
        zffd=xff;
        [r,th,ph]=cart2sph1(xffd,yffd,zffd);
        if th==0; th=1e-9;end;

        % Dipole pattern function ref C.Balanis
        F1=cos((ko*dlen/2)*cos(th));
        F2=cos(ko*dlen/2);
        Ftheta=(F1-F2)./sin(th);

        Etot=Ftheta;
        CPflag=0;
    case 4   %Geometry definition for dipole element  
        dlen=0.5;                 % Length (m)
        h=0.25;                  % Height above ground (m)
        
                % ***** Dipole 1 *****
        [xff,yff,zff]=sph2cart1(999,theta_in,phi_in);
        xffd1=-zff+h;
        yffd1=yff;
        zffd1=xff;
        [r1,th1,ph1]=cart2sph1(xffd1,yffd1,zffd1);
        if th1==0; th1=1e-9;end;

        % Dipole pattern for primary dipole
        F11=cos((ko*dlen/2)*cos(th1));
        F21=cos(ko*dlen/2);
        Amp1=((F11-F21)./sin(th1));

        % ***** Dipole 2 *****
        xffd2=-zff-h;
        yffd2=yff;
        zffd2=xff;
        [r2,th2,ph2]=cart2sph1(xffd2,yffd2,zffd2);
        if th2==0; th2=1e-9;end;

        % Dipole pattern for image dipole
        F12=cos((ko*dlen/2)*cos(th2));
        F22=cos(ko*dlen/2);
        Amp2=((F12-F22)./sin(th2));

        E1=Amp1*exp(-j*ko*r1);
        E2=Amp2*exp(-j*(ko*r2-pi));

        Esum=abs(E1+E2);

        % Due to groundplane function is only valid for 
        % theta values :   0 < theta < 90   for all phi

        if theta_in < pi/2
         Etot=Esum;
        else Etot=0;
        end
        CPflag=0;
  case 5 % Geometry definition for helix element
        % si se quiere diseñar con un pich concreto
        PitchDeg=12.5;
        C=lambda*1.2;
        S=C*sin((PitchDeg)*pi/180);
        
        N=6;                     % Number of turns
        %S=0.27;                  % Turn spacing (m)
        helix_config=[N,S];      % Define vector of parameters
        
                % Helix parameters
        N=helix_config(1,1);  % Number of turns
        S=helix_config(1,2);  % Turn spacing (m)
        C=1.2*lambda;         % Turn circumference (m)
        Lo=sqrt(C^2+S^2);     % Turn length (m)

        % Ordinary endfire condition, value of p
        % **************************************
        %p=(Lo/lambda)/(S/lambda+1);
        %
        %psi=ko*(S*cos(theta)-(Lo/p));
        %
        %F1=sin(pi/(2*N))*cos(theta);
        %F2=sin((N/2)*psi)/sin(psi/2);
        %
        %Eord=F1*F2;


        % Hansen-Woodyard increased directivity condition, value of p
        % ***********************************************************
        p=(Lo/lambda)/(S/lambda+((2*N+1)/(2*N)));

        psi=ko*(S*cos(theta)-(Lo/p));

        F1=sin(pi/(2*N))*cos(theta);
        F2=sin((N/2)*psi)/sin(psi/2);

        Ehan=abs(F1*F2);

        % Due to groundplane function is only valid for 
        % theta values :   0 < theta < 90   for all phi
        %
        % SSF is a sidelobe scaling factor, raising the 
        % sidelobe levels as the square of theta to a 
        % maximum of SSF(dB) above the standard value at theta = +/-(pi)
        % Typical values of SSF are around 15dB give good agreement with
        % NEC models and measured results. 

        SSF=15;                    % Sidlobe scaling factor dB

        F3=(10^(SSF/20)-1)/(pi^2); % Intermediate calc 
        SF=(F3*theta.^2)+1;        % Factor by which to multiply standard pattern

        if theta < pi/2
         Etot=Ehan*SF;             % Etot=Ehan or Etot=Eord here
        else Etot=0;
        end
        CPflag=1;                  % RHCP, use CPflag=-1 for LHCP
        
    case 6,% Geometry definition for rectangular aperture element.
        a=0.1;                   % Aperture dimension in x-axis (m)
        b=0.5;                   % Aperture dimension in y-axis (m)
        aprect_config=[a,b];
        X=(ko*a/2).*sin(theta).*sin(phi)+1e-9;
        Y=(ko*b/2).*sin(theta).*cos(phi)+1e-9;

        Etheta=sin(phi).*(sin(X)./X).*(sin(Y)./Y);
        Ephi=cos(theta).*cos(phi).*(sin(X)./X).*(sin(Y)./Y);

       % Etot=sqrt(abs(Etheta).^2+abs(Ephi).^2)+1e-9;

        if theta < pi/2
          Etot=sqrt((abs(Etheta))^2+(abs(Ephi))^2)+1e-9;
        else Etot=1e-9;
        end;

        CPflag=0;
    case 7,    %circular aperture element
        d=0.5;                   % Aperture diameter (m)
        apcirc_config=[d];
        dia=apcirc_config(1,1);

        a=dia/2;
        Z=(ko*a).*sin(theta);
        Etheta=cos(phi).*besselj(1,Z)./Z;
        Ephi=cos(theta).*sin(phi).*besselj(1,Z)./Z;
        if theta < pi/2
          Etot=sqrt(Etheta.^2+Ephi.^2)+1e-9;
        else Etot=1e-9;
        end;

        CPflag=0;

  
  

    case 8 % Geometry definition for rectangular waveguide element.
        a=0.1;                   % Guide dimension in x-axis (m)
        b=0.5;                   % Guide dimension in y-axis (m)
        wgr_config=[a,b];
        a=wgr_config(1,1);  % Y-axis dimension input as (a)
        b=wgr_config(1,2);  % X-axis dimension input as (b)




        X=(ko*a/2).*sin(theta).*sin(phi)+1e-9;
        Y=(ko*b/2).*sin(theta).*cos(phi)+1e-9;

        Etheta=sin(phi).*(cos(X)./((X.^2)-(pi/2).^2)).*(sin(Y)./Y);
        Ephi=cos(theta).*cos(phi).*(cos(X)./((X.^2)-(pi/2).^2)).*(sin(Y)./Y);


        if theta < pi/2
          Etot=sqrt((abs(Etheta))^2+(abs(Ephi))^2)+1e-9;
        else Etot=1e-9;
        end;

        CPflag=0;
    case 9  % Geometry definition for circular waveguide element
        d=0.5;                   % Guide diameter (m)
        wgc_config=[d];
        diameter=wgc_config(1,1);
        a=diameter/2;

        Z=(ko*a).*sin(theta);
        xi=1.841;

        Etheta=cos(phi).*besselj(1,Z)./Z;
        F1=besselj(0,Z);
        F2=besselj(1,Z)./Z;
        Ephi=cos(theta).*sin(phi).*(F1-F2)./(1-(Z./xi).^2);

        if theta < pi/2
          Etot=sqrt(Etheta.^2+Ephi.^2)+1e-9;
        else Etot=1e-9;
        end;

        CPflag=0;
        
  case 10  % Geometry definition for circular parabolic dish
        % Parabolic dish parameters
        d=4.0;                   % Dish diameter (m)
        n=2.0;                   % Aperture taper factor (unitless)
        t=10;                    % Taper value at edge of dish, relative to maximum (dB)
        dish_config=[d,n,t];
        diameter=dish_config(1,1);
        a=diameter/2;

        n=dish_config(1,2);
        t=dish_config(1,3);

        A=1-10.^(-t./20);


        u=ko*a*sin(theta);

        F1=2*(1-A);
        F2=besselj(1,u)./u;
        F3=(A.*(2.^n)).*prod(1:(n+1));
        F4=besselj((n+1),u)./(u.^(n+1));

        F5=(F1.*F2+F3.*F4);

        Etheta=cos(phi).*F5;
        Ephi=cos(theta).*sin(phi).*F5;

        if theta < pi/2
          Etot=sqrt(Etheta.^2+Ephi.^2)+1e-9;
        else Etot=1e-9;
        end;

        CPflag=0;
             
    otherwise, disp('Unknown Element Type, set to iso');Elt=0;
end
