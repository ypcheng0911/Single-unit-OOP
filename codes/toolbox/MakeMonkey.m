function MK = MakeMonkey(sub)

MonkeyRS = ls(['H:\UBO_monkey\analysis\recording_site_objects\',sub,'*']);
for r = 1:size(MonkeyRS,1)
    load(fullfile('H:\UBO_monkey\analysis\recording_site_objects',MonkeyRS(r,:)))
    eval(sprintf('RS{r,1} = %s;',MonkeyRS(r,1:8)))
end
eval(sprintf('Monkey_%s = Monkey(sub,[],[],[],[],RS);',sub))
mkdir('H:\UBO_monkey\analysis\monkey_objects')
eval(sprintf('save([''H:\\UBO_monkey\\analysis\\monkey_objects\\Monkey_%s.mat''],''Monkey_%s'',''-v7.3'')',sub,sub))
end