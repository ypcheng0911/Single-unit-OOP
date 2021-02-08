function val = MKread(obj,property)
switch property
    case 'name'
        val = obj.name;
    case 'age'
        val = obj.age;
    case 'weight'
        val = obj.weight;
    case 'gender'
        val = obj.gender;
    case 'RecordingSites'
        val = obj.RS;
end
