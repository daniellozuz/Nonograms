function [VE] = rec2(VE, w, s, instr, len)
l = length(instr);
    if isempty(w)
        VE = [];
    end
    if l == 1
        for i = s:(len-instr(1)+1)
            v = [w, i];
            VE = [VE; v];
        end
    else
        for i = s:(len-sum(instr)-length(instr)+2)
            v = [w, i];
            VE = rec2(VE, v, i+instr(1)+1, instr(2:length(instr)), len);
        end
    end
end