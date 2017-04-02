function vect = przeanalizuj2(V,instr)
% Not working for przeanalizuj2([0 0 0 0],[])
    %% Calculate groups lengths and indices of their beginnings
    lens = [];
    ind = [];
    len = 0;
    for i = 1:length(V)        
        if V(i) ~= -1
            if len == 0
                ind = [ind, i];
            end
            len = len + 1;
        elseif len ~= 0
            lens = [lens, len];
            len = 0;
        end
    end
    if len ~= 0
        lens = [lens, len];
    end
    lens,ind,
    
    %% Create all possible assignments (place instructions in groups, number them in ascending order)
    N_groups = length(lens);
    N_instructions = length(instr);
    MATRI = rec([],[],1,N_instructions,N_groups);
    MATRI,
    
    %% Check which of the possibilities are valid (instructions fit into groups)
    VALID = [];
    for i = 1:size(MATRI,1)
        sums = zeros(1, N_groups);
        spaces = -ones(1, N_groups);
        p = MATRI(i,:);
        for j = 1:length(p)
            sums(p(j)) = sums(p(j)) + instr(j);
            spaces(p(j)) = spaces(p(j)) + 1;
        end
        for j = 1:length(spaces)
            if spaces(j) > 0
                sums(j) = sums(j) + spaces(j);
            end
        end
        %sums,spaces,
        if sum(sums <= lens) == length(lens)
            VALID = [VALID; p];
        end
    end
    VALID,
    
    %% If an instruction appears in a specific group in all valid possibilities, try packing it there, make X'es in a subgroup
    sure = zeros(1,length(instr));
    for i = 1:size(VALID,2)
        col = VALID(:,i);
        sub = VALID(1,i) * ones(length(col),1);
        col,sub,
        if ~any(col-sub)
            sure(i) = VALID(1,i);
        end
    end
    sure,
    % In sure there are instruction places listed.
    for i = 1:N_groups
        segment = [];
        for j = 1:length(sure)
            if sure(j) == i
                segment = [segment, instr(j)];
                len = lens(i);
            end
        end
        segment,len, % only if segment is not empty
        if ~isempty(segment)
            MA = rec2([],[],1,segment,len)
            M = [];
            for j = 1:size(MA,1)
                v = -ones(1,len);
                for k = 1:size(MA,2)
                    v(MA(j,k):(MA(j,k)+segment(k)-1)) = ones(1,segment(k));
                end
                %Check if good
                good = 1;
                for k = 1:length(v)
                    if (v(k) == 1 && V(k+ind(i)-1) == -1) || (v(k) == -1 && V(k+ind(i)-1) == 1)
                        good = 0;
                        break
                    end
                end
                if good
                    M = [M; v];
                end
            end
            M,
            % Check if all the same in columns of M
            for j = 1:size(M,2)
                %j,
                col = M(:,j);
                if ~any(col+1) % all -1
                    %push -1 into appropriate place
                    V(ind(i)+j-1) = -1
                    %ind,
                end
                if ~any(col-1) % all 1
                    %push 1 into appropriate place
                    V(ind(i)+j-1) = 1
                end
            end
            V,
        end
    end
    VALID,
    vect = V;
end