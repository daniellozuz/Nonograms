%% Initialization
clear;close all;clc;tic;

VERT = {[2],[1,4],[4,3],[5],[2],[5],[1,1,1],[1,1,1],[1,1],[1]};
HOR = {[1,3],[2,1,1],[1,3],[2,1,1],[2,2],[6,1],[4],[2],[1],[1]};

M = zeros(10);
% Zero - no idea
% One  - hit
% -One - empty

visualize(M,VERT,HOR);
pause(2)

%% Beginning X'es
% Row operations (HOR)
for r = 1:10
    v = M(r,:);             % piece of a board
    instr = HOR{r};         % instructions
    if ~isempty(instr)
        % V1
        v1 = zeros(1,10);
        indeks = 1;
        for i = 1:length(instr)
            for j = 1:instr(i)
                v1(indeks) = i;
                indeks = indeks + 1;
            end
            if i ~= length(instr)
                v1(indeks) = 0;
                indeks = indeks + 1;
            end
        end
        % V2
        v2 = zeros(1,10);
        indeks = 1;
        for i = length(instr):-1:1
            for j = 1:instr(i)
                v2(11-indeks) = i;
                indeks = indeks + 1;
            end
            if i ~= 1
                v2(11-indeks) = 0;
                indeks = indeks + 1;
            end
        end
        % Porownanie
        V = zeros(1,10);
        for i = 1:10
            if (v1(i) ~= 0 && v2(i) ~= 0 && v1(i) == v2(i))
                V(i) = 1;
                M(r,i) = 1;
            end
        end
    else
        M(r,:) = -1;
    end
end

% Column operations (VERT)
for c = 1:10
    v = M(:,c);             % piece of a board
    instr = VERT{c};         % instructions
    % Beginning
    if ~isempty(instr)
        % v1
        v1 = zeros(1,10);
        indeks = 1;
        for i = 1:length(instr)
            for j = 1:instr(i)
                v1(indeks) = i;
                indeks = indeks + 1;
            end
            if i ~= length(instr)
                v1(indeks) = 0;
                indeks = indeks + 1;
            end
        end
        % v2
        v2 = zeros(1,10);
        indeks = 1;
        for i = length(instr):-1:1
            for j = 1:instr(i)
                v2(11-indeks) = i;
                indeks = indeks + 1;
            end
            if i ~= 1
                v2(11-indeks) = 0;
                indeks = indeks + 1;
            end
        end
        % Porownanie
        V = zeros(1,10);
        for i = 1:10
            if (v1(i) ~= 0 && v2(i) ~= 0 && v1(i) == v2(i))
                V(i) = 1;
                M(i,c) = 1;
            end
        end
    else
        M(:,c) = -1;
    end
end

visualize(M,VERT,HOR);
pause(2)

%% Beginning -'es
% Row operations (HOR)
for r = 1:10
    V = M(r,:);             % piece of a board
    instr = HOR{r};         % instructions
    if length(instr) == 1 && sum(V>0) > 0
        vv = [];
        for i = 1:(11-instr)
            v = [-ones(1,i-1) ones(1,instr) -ones(1,11-instr-i)];
            % z tych wszystkich wybierz te ktore coveruja macierz
            if sum(V - v < 2) == 10
                vv = [vv; v];
            end
        end
        % jesli wszystkie v maja wspolne minusy, wsadz je
        check = zeros(1,10);
        for i = 1:size(vv,1)
            check = check + vv(i,:)
        end
        for i = 1:10
            if check(i) == -size(vv,1)
                M(r,i) = -1;
            end
        end
    end
end

% Column operations (VERT)
for c = 1:10
    V = M(:,c)';             % piece of a board
    instr = VERT{c};         % instructions
    if length(instr) == 1 && sum(V>0) > 0
        vv = [];
        for i = 1:(11-instr)
            v = [-ones(1,i-1) ones(1,instr) -ones(1,11-instr-i)];
            % z tych wszystkich wybierz te ktore coveruja macierz
            if sum(V - v < 2) == 10
                vv = [vv; v];
            end
        end
        % jesli wszystkie v maja wspolne minusy, wsadz je
        check = zeros(1,10);
        for i = 1:size(vv,1)
            check = check + vv(i,:)
        end
        for i = 1:10
            if check(i) == -size(vv,1)
                M(i,c) = -1;
            end
        end
    end
end

toc;
visualize(M,VERT,HOR);