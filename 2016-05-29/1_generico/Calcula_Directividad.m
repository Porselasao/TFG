function [directivity_dBi,Thmax,Phmax,directivity_dBi_buscada] = Calcula_Directividad(array_config,freq_config,range_config,deltheta,delphi,thetabuscado,phibuscado )


%  Todos los valores angulares deben ser introducidos en grados.
thetabuscado=thetabuscado*pi/180;
phibuscado=phibuscado*pi/180;
dth=deltheta*pi/180;
dph=delphi*pi/180;


% Phi Integration Loop
phi_index=0;
Psum=0;
Pmax=0;
for phi=(dph/2):dph:(2*pi-(dph/2))          
  
    phi_index=phi_index+1;
    
     % Theta Integration Loop
     Theta_index=0;
     for theta=(dth/2):dth:(pi-(dth/2))  
         Theta_index=Theta_index+1;
         % fieldsum_jf debe ser los angulos en radianes
         Emultiple=fieldsum_jf(array_config,freq_config,range_config,theta,phi);
         
         Ethph=Emultiple(1,1);                        % Select Etotal
         Pthph=Ethph*conj(Ethph);                     % Convert to power

         if Pthph>Pmax                                
            Pmax=Pthph;    % Store peak value
            Thmax=theta;   % Store theta value for the maximum
            Phmax=phi;     % Store phi value for the maximum
        end

      Psum=Psum+Pthph*sin(theta)*dth*dph;          % Summation

     end
end
 

directivity_lin=Pmax/(Psum/(4*pi));            % Directivity (linear ratio)
directivity_dBi=10*log10(directivity_lin);     % Directivity (dB wrt isotropic)

Emultiple=fieldsum_jf(array_config,freq_config,range_config,thetabuscado,phibuscado);
Pbuscada=Emultiple(1,1)*conj(Emultiple(1,1));    
directivity_dBi_buscada=10*log10(Pbuscada/(Psum/(4*pi)));



