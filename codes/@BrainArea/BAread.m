function val = BAread(obj,property)
switch property
    case 'name'
        val = obj.name;
    case 'units'
        val = obj.unit;
end
end