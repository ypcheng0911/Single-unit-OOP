function val = RSread(obj,property)
switch property
    case 'subject'
        val = obj.subject;
    case 'site'
        val = obj.site;
    case 'units'
        val = obj.unit;
end
end