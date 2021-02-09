function SUr = SUanova(SU)
%-- parameter
bin_size = 0.002;
pre_bin=500;
%-- call computation windows
[BO_window,AO0_window,AO1_window,AO2_window,AO3_window] = CompuWindow(pre_bin,bin_size);
cal_windows={BO_window,AO0_window,AO1_window,AO2_window,AO3_window};
%-- group info for ANOVA
dir_char = ['-135';'- 90';'- 45';'   0';'  45';'  90';' 135';' 180'];
dir_CL = repmat(dir_char,15,1);
speed_char = repelem([' 20';' 40';' 80';'160';'320'],8,1);
speed_CL = repmat(speed_char,3,1);
ball_CL = repelem(['1mm';'2mm';'4mm'],40,1);
for i = 1:120
    dir_cell{i,1}=dir_CL(i,:);
    speed_cell{i,1}=speed_CL(i,:);
    ball_cell{i,1}=ball_CL(i,:);
end
%-- load psth
d_psth = SUread(SU,'psth');
%-- prepare ANOVA data format
for window = 1:length(cal_windows)
    win_sec = length(cal_windows{window})*bin_size;  % width of window in second
    anova_uca{1,window} = reshape(sum(d_psth(:,:,:,cal_windows{window},1:10),4)/win_sec,8,5,3,10);
    anova_uca{2,window} = reshape(sum(d_psth(:,:,:,cal_windows{window},11:20),4)/win_sec,8,5,3,10);
end
uca_period = 2; % sustain response; HERE SHOULD BE MODIFIED
full_data = anova_uca(:,uca_period+1);
%-- ANOVA
[p_f1,tbl_f1,stats_f1] = anovan(full_data{1}(:),{repmat(dir_cell,10,1) repmat(speed_cell,10,1) repmat(ball_cell,10,1)},'model','full','varnames',{'Direction' 'Speed' 'BallType'},'display','off');
[p_f2,tbl_f2,stats_f2] = anovan(full_data{2}(:),{repmat(dir_cell,10,1) repmat(speed_cell,10,1) repmat(ball_cell,10,1)},'model','full','varnames',{'Direction' 'Speed' 'BallType'},'display','off');
sig_f1 = p_f1(1:3)<0.01;
sig_f2 = p_f2(1:3)<0.01;
%-- SUresult object construction: variables
results.p_f1 = p_f1;
results.p_f2 = p_f2;
results.tbl_f1 = tbl_f1;
results.tbl_f2 = tbl_f2;
results.stats_f1 = stats_f1;
results.stats_f2 = stats_f2;
results.sig_f1 = sig_f1;
results.sig_f2 = sig_f2;
SUname = [SUread(SU,'site'),'_',SUread(SU,'name')];
type = 'SU';
method = 'three-way ANOVA (full model)';
%-- SUresult object construction
SUr = SUresult(SUname,type,method,results);
end
