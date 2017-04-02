function M = pojedyncze(M, VERT, HOR)
    % Row operations (HOR)
    for i = 1:10
        v = M(i,:);
        instr = HOR{i};
        if length(instr) == 1
            % £¹czenie xów
            first_x = -1;
            last_x = -1;
            for j = 1:10
                if v(j) == 1 && first_x == -1
                    first_x = j
                    last_x = j
                elseif v(j) == 1
                    last_x = j
                end
            end
            if first_x ~= -1
                for j = first_x:last_x
                    M(i,j) = 1;
                end
            end
            % Wsadzanie pauz tam, gdzie siê nie zmieœci. dok.
            v = M(i,:);
            space = 0;
            for j = 1:10
                if v(j) == 0 || v(j) == 1
                    space = space + 1;
                else
                    space = 0;
                end
            end
            
            % ??
        end
    end
    % Column operations (VERT)
end