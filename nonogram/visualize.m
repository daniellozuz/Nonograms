function visualize(M,VERT,HOR,iter)
    if iter ~= 0
        clf
    end
    title(['Iteracja numer ', num2str(iter)])
    MAX_V = 0;
    for i = 1:length(VERT)
        max_V = length(VERT{i});
        if max_V > MAX_V
            MAX_V = max_V;
        end
    end
    MAX_H = 0;
    for i = 1:length(HOR)
        max_H = length(HOR{i});
        if max_H > MAX_H
            MAX_H = max_H;
        end
    end
    
    % Board
    for i = 1:size(M,1)
        for j = 1:size(M,2)
            if M(i,j) == 1
                text(j-0.7,(size(M,1)+1-i)-0.5,'X','FontSize', 16);
            elseif M(i,j) == -1
                text(j-0.6,(size(M,1)+1-i)-0.5,'.','FontSize', 16);
            end
        end
    end
    axis([-MAX_H,size(M,2)+1,-1,size(M,1)+MAX_V])
    % Grid
    for i = 0:size(M,1)
        line([0, size(M,1)],[i,i],'Color', [0.9,0.9,0.9]);
        line([i, i],[0,size(M,1)],'Color', [0.9,0.9,0.9]);
        if mod(i,5) == 0
            line([0, size(M,1)], [i,i], 'Color', [0.9,0.9,0.9], 'LineWidth', 2);
            line([i, i], [0,size(M,1)], 'Color', [0.9,0.9,0.9], 'LineWidth', 2);
        else
            line([0, size(M,1)], [i,i], 'Color', [0.9,0.9,0.9], 'LineWidth', 1);
            line([i, i], [0,size(M,1)], 'Color', [0.9,0.9,0.9], 'LineWidth', 1);
        end
    end
    % Numbers
    for i = 1:size(M,2)
        v = VERT{i};
        if ~isempty(v)
            for j = 1:length(v)
                text(i-0.7,(size(M,1)+1+length(v)-j)-0.5,num2str(v(j)),'FontSize', 16);
            end
        end
    end
    for i = 1:size(M,1)
        v = HOR{i};
        if ~isempty(v)
            for j = 1:length(v)
                text(j-0.7-length(v),size(M,1)+1-i-0.5,num2str(v(j)),'FontSize', 16);
            end
        end
    end
end