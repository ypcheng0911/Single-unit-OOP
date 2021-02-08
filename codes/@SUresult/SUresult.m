function obj = SUresult(SUname,type,method,results)

% SUresult class constructor: save results for SU, RS, BA, MK
obj.SUname = SUname;
obj.type = type; % SU, RS, BA, MK
obj.method = method; % anova, etc
obj.results = results;
end