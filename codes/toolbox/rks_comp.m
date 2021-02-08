function [p,h,comp] = rks_comp(x,y)
%% Ranksum test and testing whether x < y
    [p,h] = ranksum(x,y);
    comp = sum(x) < sum(y);
end