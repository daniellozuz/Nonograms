function vect = przeanalizuj(V,instr)
    %% How many groups (calculate separators) and group's lengths
    groups = 1;
    count = 1;
    lens = [];
    len = 0;
    for i = 1:length(V)        
        i,
        if V(i) == -1 && dont_count ~= 1
            groups = groups + 1
            dont_count = 1;
            lens = [lens, len]
            len = 0
        elseif V(i) ~= -1
            dont_count = 0;
            len = len + 1
        end
    end
    if len ~= 0
        lens = [lens, len]
    end
    groups,
    %%
end