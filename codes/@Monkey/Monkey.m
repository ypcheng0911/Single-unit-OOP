function obj = Monkey(name,age,weight,gender,RecordingSites)

% Monkey class constructor
obj.name = name;
obj.age = age;
obj.weight = weight;
obj.gender = gender;
for i = 1:size(RecordingSites,1)  % input using cell type 
    obj.RS(1) = RecordingSites{i};
end
obj = class(obj,'Monkey');
end