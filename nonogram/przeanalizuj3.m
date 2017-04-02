function vect = przeanalizuj3(V,instr)
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
    % VALID still does not take into account the necessity of filling all
    % X'es present in V, but maybe it wont change the indecisiveness.
    VALI = [];
    for i = 1:N_groups
        poss = [];
        VALI = unique(VALID == i,'rows'); % Only unique vectors (but 0's considered)
        SE = {};
        for j = 1:size(VALI,1)
            % Find all possibilities
            segment = [];
            for k = 1:size(VALI,2)
                if VALI(j,k) == 1
                    segment = [segment, instr(k)];
                end
            end
            segment;
            SE{j} = segment;
        end
        SE,
        % For all segments in se try possibilities and pick all info u can get
        POSS = [];
        for j = 1:length(SE)
            segment = SE{j};
            len = lens(i);
            %Not really ;/
            if ~isempty(segment)
                segment,len,
                MA = rec2([],[],1,segment,len)
                for jj = 1:size(MA,1)
                    v = -ones(1,len);
                    for k = 1:size(MA,2)
                        v(MA(jj,k):(MA(jj,k)+segment(k)-1)) = ones(1,segment(k));
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
                        POSS = [POSS; v];
                    end
                end
            else
                POSS = [POSS; -ones(1,len)];
            end
        end
        POSS,
        % Now use POSS to change the vector, if all of POSS are the same in
        % column it is a solution.
        for j = 1:size(POSS,2)
            %j,
            col = POSS(:,j);
            if ~any(col+1) % all -1
                %push -1 into appropriate place
                V(ind(i)+j-1) = -1;
                %ind,
            end
            if ~any(col-1) % all 1
                %push 1 into appropriate place
                V(ind(i)+j-1) = 1;
            end
        end
    end
    vect = V;
end