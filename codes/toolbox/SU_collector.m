% Single unit collector


% Use cd() function change current folder to data storage.
%==========================================================================
a = SingleUnit('default',[],[],[],[],[],[],[],[],[],[]);

units = ls('*c2*.mat');
for i = 1:size(units,1)
    load(units(i,:))
end

clearvars a i units