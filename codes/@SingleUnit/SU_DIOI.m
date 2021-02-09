function SUr = SU_DIOI(SU)
%-- parameters
adjusted_fr = 2;
uca_method = 'm';
rand_rep = 10000;
DI_OI_alpha = 0.05;
bin_size=0.002;
pre_bin=500;
%-- load psth
d_psth = SUread(SU,'psth');
[BO_window,AO0_window,AO1_window,AO2_window,~] = CompuWindow(pre_bin,bin_size);
cal_windows={BO_window,AO0_window,AO1_window,AO2_window};
%-- under curve area computation (cumulative firing rates)
for bl = 1:3
    for wind = [1 3] % baseline and sustain response
        win_sec = length(cal_windows{wind})*0.002;
        if strcmp(uca_method,'s')
            UCA{1,bl,wind} = reshape(sum(sum( d_psth(:,:,bl,cal_windows{wind},1:10),5),4),8,5);  % UCA{finger_id,time window} = (direction, speed, ball type)
            UCA{2,bl,wind} = reshape(sum(sum( d_psth(:,:,bl,cal_windows{wind},11:20),5),4),8,5);
        end
        if strcmp(uca_method,'m')
            UCA{1,bl,wind} = reshape(mean(sum( d_psth(:,:,bl,cal_windows{wind},1:10),4)/win_sec,5),8,5);  % UCA{finger_id,time window} = (direction, speed, ball type)
            UCA{2,bl,wind} = reshape(mean(sum( d_psth(:,:,bl,cal_windows{wind},11:20),4)/win_sec,5),8,5);
            %             UCAsem{1,bl,wind} = std(sum( d_psth(:,:,bl,cal_windows{wind},1:10),4)/win_sec,0,5)/((10-1)^0.5);
            %             UCAsem{2,bl,wind} = std(sum( d_psth(:,:,bl,cal_windows{wind},11:20),4)/win_sec,0,5)/((10-1)^0.5);
        end
    end
end
%-- compute DI & OI for each digit
% pref_d_info = SUread(SU,'pref_d'); % for preferred digit only
% pref_d = pref_d_info{3};
for d = 1:2
    for bl = 1:3
        for spe = 1:5
            fr = UCA{d,bl,1}(:,spe)';
            if adjusted_fr == 1
                baseline = UCA{d,bl,1}(:,spe)';
                fr = fr - baseline;
            elseif adjusted_fr == 2
                minfr = min(fr);
                fr = fr - minfr;
            elseif adjusted_fr == 3
                maxfr = max(fr);
                fr = fr/maxfr;
            end
            %-- call function
            eval(sprintf('[results.d%02d.DIs(bl,spe),results.d%02d.prefer_dir(bl,spe),results.d%02d.DI_alpha(bl,spe),results.d%02d.DI_sig_temp(bl,spe),results.d%02d.OIs(bl,spe),results.d%02d.prefer_ori(bl,spe),results.d%02d.OI_alpha(bl,spe),results.d%02d.OI_sig_temp(bl,spe)] = DI_OI(fr,rand_rep,DI_OI_alpha);',d,d,d,d,d,d,d,d))
        end
    end
end
%-- method discription
switch adjusted_fr
    case 0
        adj_fr_s = 'raw';
    case 1
        adj_fr_s = 'adjusted: subtract baseline';
    case 2
        adj_fr_s = 'adjusted: subtract minimum';
    case 3
        adj_fr_s = 'ratio';
end
switch DI_OI_alpha
    case 0.05
        alpha_text = ', alpha: 0.05';
    case 0.01
        alpha_text = ', alpha: 0.01';
    case 0.001
        alpha_text = ', alpha: 0.001';
end
%-- SUresult object construction: variables
SUname = [SUread(SU,'site'),'_',SUread(SU,'name')];
type = 'SU';
method = ['DI & OI calculation, ',adj_fr_s,alpha_text];
%-- SUresult object construction
SUr = SUresult(SUname,type,method,results);
end
