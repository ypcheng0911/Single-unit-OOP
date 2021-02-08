% Calculate response properties of SingleUnit PSTH

function [UCA, updated_SU , d_psth] = SUpsth_1dspe_analysis(SU,method)

%     tic
    [~, d_psth, updated_SU, bin_size] = SUpsth_1dspe(SU);
%     toc
    
    % bin_size=0.001;  % second
    pre_bin=500;
    % post_bin=1500;
    cal_window=(pre_bin+100)/(bin_size*1000)+1:(pre_bin+900)/(bin_size*1000);
%----------------- storage test ------------------------------------------
%     % 6 dim
%     UCA {1} = reshape(sum(sum(d_psth(1,:,:,:,cal_window,:),6),5),8,5,3);
%     UCA {2} = reshape(sum(sum(d_psth(2,:,:,:,cal_window,:),6),5),8,5,3);
%     % 5 dim in 1 dim cell
%     UCA {1} = reshape(sum(sum(d_psth{1}(:,:,:,cal_window,:),5),4),8,5,3);
%     UCA {2} = reshape(sum(sum(d_psth{2}(:,:,:,cal_window,:),5),4),8,5,3);

    % 5 dim fing rep stack
    if strcmp(method,'s')
        UCA {1} = reshape(sum(sum(d_psth(:,:,:,cal_window,1:10),5),4),8,5,3);
        UCA {2} = reshape(sum(sum(d_psth(:,:,:,cal_window,11:20),5),4),8,5,3);
    end
    if strcmp(method,'m')
        UCA {1} = reshape(mean(sum(d_psth(:,:,:,cal_window,1:10),4)/0.8,5),8,5,3);
        UCA {2} = reshape(mean(sum(d_psth(:,:,:,cal_window,11:20),4)/0.8,5),8,5,3);
    end
    
%     % 4 dim in 2 dim cell,  wrong syntax
%     UCA {1} = reshape(sum(sum([d_psth{1,:}(:,:,cal_window,:)],4),3),8,5,3);
%     UCA {2} = reshape(sum(sum([d_psth{2,:}(:,:,cal_window,:)],4),3),8,5,3);
%       % 4 dim, fing rep stack, dir spe stack
%       UCA {1} = reshape(sum(sum(d_psth(:,:,cal_window,1:10),4),3),8,5,3);
%       UCA {2} = reshape(sum(sum(d_psth(:,:,cal_window,11:20),4),3),8,5,3);
    
%     % 2 dim: trial x parameters  
%     para=d_psth(:,end-1);
%     rate=d_psth(:,end);
% %     for i = 1:length(rate)/10
% %         sum_rate = sum(rate(10*(i-1)+1:10*i));
% %     end    
%     for i=1:8
%         for j=1:5
%             for k=1:3
%                 UCA{1}(i,j,k) = sum(sum(rate(find(para(:,1)==1 & para(:,2)==i & para(:,3)==j & para(:,4)==k))));
%                 UCA{2}(i,j,k) = sum(sum(rate(find(para(:,1)==2 & para(:,2)==i & para(:,3)==j & para(:,4)==k))));
%             end
%         end
%     end
    
%     % 2 dim: trial x parameters  
%     para=d_psth(:,end-1);
%     [s_para,ind]=sortrows(para);
%     rate=d_psth(ind,end);
% %     for i = 1:length(rate)/10
% %         sum_rate = sum(rate(10*(i-1)+1:10*i));
% %     end    
%     for i=1:8
%         for j=1:5
%             for k=1:3
%                 UCA{1}(i,j,k) = sum(sum(rate(find(s_para(:,1)==1 & s_para(:,2)==i & s_para(:,3)==j & s_para(:,4)==k))));
%                 UCA{2}(i,j,k) = sum(sum(rate(find(s_para(:,1)==2 & s_para(:,2)==i & s_para(:,3)==j & s_para(:,4)==k))));
%             end
%         end
%     end
    
end
