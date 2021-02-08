function obj = BrainArea(name,units)

% BrainArea class constructor
obj.name = name;
for i = 1:size(units,1)
    obj.unit(i) = units{i};
end
obj = class(obj,'BrainArea'); 
end