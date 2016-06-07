function sincronismo = calcular_sincronismo(Numero_de_sensores)

if Numero_de_sensores<=1
    sincronismo=1;
elseif Numero_de_sensores<=2
    sincronismo=1.1; 
elseif Numero_de_sensores<=3
    sincronismo=1.13; 
elseif Numero_de_sensores<=4
    sincronismo=1.14; 
elseif Numero_de_sensores<=5
    sincronismo=1.15; 
elseif Numero_de_sensores<=7
    sincronismo=1.17; 
elseif Numero_de_sensores<=10
    sincronismo=1.2; 
elseif Numero_de_sensores<=15
    sincronismo=1.25; 
elseif Numero_de_sensores<=20
    sincronismo=1.3;
elseif Numero_de_sensores<=30
    sincronismo=1.4;
elseif Numero_de_sensores<=50
    sincronismo=1.6;
elseif Numero_de_sensores<=100
    sincronismo=2.1;
end

end