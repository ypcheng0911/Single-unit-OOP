function [p,h,comp] = ttest_comp(x,y)
%% t test and testing whether x < y
    [h,p] = ttest(x,y);
    comp = sum(x) < sum(y);
end