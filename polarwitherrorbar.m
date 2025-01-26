function [] = polarwitherrorbar(angle,avg,error)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Revised from Mathwork sharing file.

% The first two input variables ('angle' and 'avg') are same as the input 
% variables for a standard polar plot. The last input variable is the error
% value. Note that the length of the error-bar is twice the error value we
% feed to this function. 
% In order to make sure that the scale of the plot is big enough to
% accommodate all the error bars, i used a 'fake' polar plot and made it
% invisible. It is just a cheap trick. 
% The 'if loop' is for making sure that we dont have negative values  when
% an error value is substrated from its corresponding average value. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clrs = {'b','r','y','m','g'};
clrs = [
     0        0.447        0.741  % duplicate!
         0.85        0.325        0.098
        0.929        0.694        0.125
        0.494        0.184        0.556
        0.466        0.674        0.188
        0.301        0.745        0.933
        0.635        0.078        0.184
            0        0.447        0.741  % duplicate!
            ];

n_data = length(angle);
n_avg = size(avg,2);
fake = polarplot(angle,max(avg+error).*ones(n_data,n_avg)); set(fake,'Visible','off'); hold on; 
% polarplot(angle,avg,'-sb');
for ni = 1 : n_data
    for na = 1:n_avg
        polarplot(angle,avg(:,na),'color',clrs(na,:),'linestyle','-');
        if (avg(ni,na)-error(ni,na)) < 0
            polarplot(angle(ni)*ones(1,3),[0, avg(ni,na), avg(ni,na)+error(ni,na)],'color',clrs(na,:),'linestyle','-'); 
        else
            polarplot(angle(ni)*ones(1,3),[avg(ni,na)-error(ni,na), avg(ni,na), avg(ni,na)+error(ni,na)],'color',clrs(na,:),'linestyle','-'); 
        end
    end
end
hold off