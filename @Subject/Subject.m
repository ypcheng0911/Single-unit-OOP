function obj = Subject(code,name,age,weight,gender,RecordingSites)

% Monkey class constructor
obj.code = code;
obj.name = name;
obj.age = age;
obj.weight = weight;
obj.gender = gender;
for i = 1:size(RecordingSites,1)  % input using cell type 
    obj.RS(i) = RecordingSites{i};
end
obj = class(obj,'Subject');
end
