function indice = encuentra_indice_maximo ( matriz )

i=1;
while i<=length(matriz(:,1))
    j=1;
    while j<=length(matriz(1,:))
        if matriz(i,j) == max(max(matriz))
            indice = i;
        end
        j=j+1;
    end
    i=i+1;
end