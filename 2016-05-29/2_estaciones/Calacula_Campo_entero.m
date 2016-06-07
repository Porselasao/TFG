function [ Etot,Ptot,directivity_dBi,Thmax,Phmax,directivity_dBi_buscada] = Calacula_Campo_entero( array_config,freq_config,range_config,deltheta,delphi,thetabuscado,phibuscado )
%
thetabuscado=thetabuscado*pi/180;
phibuscado=phibuscado*pi/180;

          % Radius for summation of field contributions (m)
% deltheta=2;
% delphi=2;

dth=deltheta*pi/180;
dph=delphi*pi/180;
% phi_list=[0,45,90];
% N=size(phi_list,2); 

% Phi Integration Loop
phi_index=0;
Psum=0;
Pmax=0;
for phi=(dph/2):dph:(2*pi-(dph/2))          

%%% Este for para una lista de phi 3 lineas
% for n=1:N
%     phi=phi_list(1,n);    
    phi_index=phi_index+1;
    
    % Theta Integration Loop
    Theta_index=0;
 for theta=(dth/2):dth:(pi-(dth/2))  
     Theta_index=Theta_index+1;
    %  Emultiple=fieldsum(range_config,theta,phi);  % E(theta,phi)
      Emultiple=fieldsum_jf(array_config,freq_config,range_config,theta,phi);
       Etot(Theta_index,phi_index)=Emultiple(1,1);   % Add values to Etot to make vector
%       Evp(Theta_index,phi_index)=Emultiple(1,2);    % Add values to Evp to make vector
%       Ehp(Theta_index,phi_index)=Emultiple(1,3);    % Add values to Ehp to make vector
%       Elhcp(Theta_index,phi_index)=Emultiple(1,4);  % Add values to Elhcp to make vector
%       Erhcp(Theta_index,phi_index)=Emultiple(1,5);  % Add values to Erhcp to make vector
%       AR(Theta_index,phi_index)=Emultiple(1,6);     % Add values to AR to make a vector
%       Tau(Theta_index,phi_index)=Emultiple(1,7);    % Add values to Tau to make a vector
  
      Ethph=Emultiple(1,1);                        % Select Etotal
      Pthph=Ethph*conj(Ethph);                     % Convert to power
                                               % {The conjugate is used for completness here
                                               %  since fieldsum already returns E as a magnitude}
      Ptot(Theta_index,phi_index)=Pthph;   % Add values to Etot to make vector
  if Pthph>Pmax                                
   Pmax=Pthph;    % Store peak value
   Thmax=theta;   % Store theta value for the maximum
   Phmax=phi;     % Store phi value for the maximum
  end
  
  Psum=Psum+Pthph*sin(theta)*dth*dph;          % Summation

 end
end
 
% pmax=Pmax;       % Max power
% psum=Psum;       % Total radiated power
% 
% 
% 
% normd_config=10*log10(Pmax);                   % Maximum pattern value

directivity_lin=Pmax/(Psum/(4*pi));            % Directivity (linear ratio)
directivity_dBi=10*log10(directivity_lin);     % Directivity (dB wrt isotropic)

Emultiple=fieldsum_jf(array_config,freq_config,range_config,thetabuscado,phibuscado);
Pbuscada=Emultiple(1,1)*conj(Emultiple(1,1));    
directivity_dBi_buscada=10*log10(Pbuscada/(Psum/(4*pi)));
end

