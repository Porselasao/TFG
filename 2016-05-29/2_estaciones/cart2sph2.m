function [r1,theta1,phi1] = cart2sph2(posicionXYZ)

% Creada por FPR, pasa de cartesianas a esféricas en condiciones

    x=posicionXYZ(1);
    y=posicionXYZ(2);
    z=posicionXYZ(3);
    
    [r1,theta1,phi1]=cart2sph1(x,y,z);
    
    theta1=theta1/pi*180;
    phi1=phi1/pi*180;

    if phi1<0
        phi1=phi1+360;
    end
end