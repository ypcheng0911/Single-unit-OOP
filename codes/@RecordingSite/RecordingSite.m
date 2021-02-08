function obj = RecordingSite(sub,site,units)

% RecordingSite class constructor
obj.subject = sub;
obj.site = site;
for i = 1:size(units,1)
    obj.unit(i) = units{i};
end
obj = class(obj,'RecordingSite'); 
end