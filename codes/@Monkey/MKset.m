function obj = MKset(obj,varargin)
n = numel(varargin);
assert(rem(n,2) == 0)  % show error warning if inputs are incomplete: e.g. ('site','3b') rather than ('3b')

i = 1;
while i < n
    name = varargin{i};
    val = varargin{i+1};
    switch name
        case 'code'
            error('reset "subject code" is not allowed');
        case 'name'
%             obj.name = val;
            error('reset "name" is not allowed');
        case 'age'
            obj.age = val;
        case 'weight'
            obj.weight = val;
        case 'gender'
            obj.gender = val;
        case 'RecordingSites'
            for j = 1:size(val,1)
                obj.RS(j) = val{j};
            end
        otherwise
            error(['Invalid property: ',name]);
    end
    i = i + 2;
end
end            
            