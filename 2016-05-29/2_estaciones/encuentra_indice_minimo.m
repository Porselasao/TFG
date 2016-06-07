function indice = encuentra_indice_minimo ( vector )

i=1;
while i<=length(vector)
    if vector(i) == min(vector)
        indice = i;
    end
    i=i+1;
end