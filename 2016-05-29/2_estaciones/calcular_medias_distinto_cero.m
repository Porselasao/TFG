function media = calcular_medias_distinto_cero(matriz)

for i=1:length(matriz(:,1))
    suma=0;
    for j=1:length(matriz(1,:))
        if(matriz(i,j)>0)
            suma=suma+1;
        end
    end
    media(i)=sum(matriz(i,:))/suma;
end

end