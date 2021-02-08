function val = SURread(obj,property)
switch property
    case 'name'
        val = obj.SUname;
    case 'type'
        val = obj.type;
    case 'method'
        val = obj.method;
    case 'results'
        val = obj.results;
end
end