function val = BAread(obj,property)
switch property
    case 'name'
        val = obj.name;
    case 'units'
        val = obj.units;
end
end
