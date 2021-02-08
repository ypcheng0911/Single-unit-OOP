function [out] = addfield(in1, in2)
    if ~isstruct(in1) || ~isstruct(in2)
        error('Inputs should be structs.')
    end
    f1 = fieldnames(in1);
    f2 = fieldnames(in2);
    n1 = size(f1,1);
    n2 = size(f2,1);
    out = struct;
    for i=1:n1
        out.(f1{i}) = in1.(f1{i});
    end
    for i=1:n2
        out.(f2{i}) = in2.(f2{i});
    end
end