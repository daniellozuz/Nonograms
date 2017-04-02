function [VE] = rec(VE, w, s, l, e)
    if isempty(w)
        VE = [];
    end
    if l == 1
        for i = s:e
            v = [w, i];
            VE = [VE; v];
        end
    else
        for i = s:e
            v = [w, i];
            VE = rec(VE, v, i, l-1, e);
        end
    end
end