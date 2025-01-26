function obj = SUresponsiveness(obj)
%-- parameter
event_n = 200;
bin_size = 0.002;  % second
pre_bin = 500;     % millisecond
bin_n = 100/ (bin_size*1000);
low_rate_cri = 5; % low-rate criteria in hz

[BO_window,AO0_window,AO1_window,AO2_window,AO3_window] = RespWindow(pre_bin,bin_size);
% BO_window = (pre_bin-300)/(bin_size*1000)+1:(pre_bin-200)/(bin_size*1000);
% AO0_window = (pre_bin-50)/(bin_size*1000)+1:(pre_bin+50)/(bin_size*1000);     %% on response
% AO1_window = (pre_bin+100)/(bin_size*1000)+1:(pre_bin+200)/(bin_size*1000);     %% initial sustain response
% AO2_window = (pre_bin+900)/(bin_size*1000)+1:(pre_bin+1000)/(bin_size*1000);    %% off response
% AO3_window = (pre_bin+1350)/(bin_size*1000)+1:(pre_bin+1450)/(bin_size*1000);   %% end vibration
cal_window = (pre_bin+100)/(bin_size*1000)+1:(pre_bin+900)/(bin_size*1000);

%-- load psth
d_psth = SUread(obj,'psth');
%-- get digit names
d_names = SUread(obj,'parameter');
d1_name = d_names.file01.file_id;
d1_name = d1_name(max(strfind(d1_name,'_'))-2:max(strfind(d1_name,'_'))-1);
d2_name = d_names.file03.file_id;
d2_name = d2_name(max(strfind(d2_name,'_'))-2:max(strfind(d2_name,'_'))-1);
%-- start computation
for f = 1:2
    spk_count{f,1} = reshape(sum(d_psth(:,:,:,BO_window,(1:10)+10*(f-1)),5),8,5,3,bin_n);  % UCA{finger_id,window} = (direction, speed, ball type, bin)
    for a_t = 1:4
        eval(sprintf('spk_count{f,a_t+1} = reshape(sum(d_psth(:,:,:,AO%d_window,(1:10)+10*(f-1)),5),8,5,3,bin_n);',a_t-1))
        %-- rank sum test: combine direction, speed
        [resp(f,a_t),~,increase(f,a_t)] = rks_comp(reshape(sum(sum(sum(spk_count{f,1}(:,:,:,:),1),2),3),1,bin_n),reshape(sum(sum(sum(spk_count{f,a_t+1}(:,:,:,:),1),2),3),1,bin_n));
        for b = 1:3
            [win_resp(f,a_t,b),~,win_increase(f,a_t,b)] = rks_comp(reshape(sum(sum(spk_count{f,1}(:,:,b,:),1),2),1,bin_n),reshape(sum(sum(spk_count{f,a_t+1}(:,:,b,:),1),2),1,bin_n));
        end
        %-- rate in all parameter sets
        for dir=1:8
            for sp=1:5
                for b=1:3
                    temp_B = reshape(spk_count{f,1}(dir,sp,b,:),1,bin_n);
                    temp_A = reshape(spk_count{f,a_t+1}(dir,sp,b,:),1,bin_n);
                    [win_resp_AP{f,a_t}(dir,sp,b),~,win_increase_AP{f,a_t}(dir,sp,b)] = rks_comp(temp_B, temp_A);
                end
            end
        end
        
    end
    temp_resp{f} = [win_resp_AP{f,1}(:),win_resp_AP{f,2}(:),win_resp_AP{f,3}(:),win_resp_AP{f,4}(:)];
    temp_increase{f} = [win_increase_AP{f,1}(:),win_increase_AP{f,2}(:),win_increase_AP{f,3}(:),win_increase_AP{f,4}(:)];
    N_sig_AP(f,:) = sum(temp_resp{f} < (0.05/3),1);
end
%-- find finger with higher spiking rate
[~,opt_f] = max([sum([spk_count{1,1}(:); spk_count{1,2}(:); spk_count{1,3}(:); spk_count{1,4}(:)]) ...
    sum([spk_count{2,1}(:); spk_count{2,2}(:); spk_count{2,3}(:); spk_count{2,4}(:)])]);
N_sig = resp < (0.05/4);
%-- rate across all parameters in one digit
low_rate(1) = sum(reshape(sum(sum(sum(sum(d_psth(:,:,:,cal_window,1:10),5),3),2),1),1,800/(1000*bin_size))) < low_rate_cri*0.8*event_n;
low_rate(2) = sum(reshape(sum(sum(sum(sum(d_psth(:,:,:,cal_window,11:20),5),3),2),1),1,800/(1000*bin_size))) < low_rate_cri*0.8*event_n;

%-- responsiveness classification
responsiveness = N_sig > 0; % (digit,time window)  on, sus, off, vib unit
%-- excitatory or inhibitory driven response
excit_or_inhib(1) = sum(spk_count{1,1}(:))~=max(cell2mat(cellfun(@(x) sum(x(:)),spk_count(1,2:5),'UniformOutput',false)));  % 1 for excitatory, 0 for inhibitory
excit_or_inhib(2) = sum(spk_count{2,1}(:))~=max(cell2mat(cellfun(@(x) sum(x(:)),spk_count(2,2:5),'UniformOutput',false)));

%-- save and update SingleUnit object
pref_d = {d1_name,d2_name,opt_f};
obj = SUset(obj,'pref_d',pref_d);
obj = SUset(obj,'responsiveness',responsiveness); % 1 for responsive, 0 for unresponsive
obj = SUset(obj,'low_rate',low_rate); % 1 for low, 0 for regular
obj = SUset(obj,'excit_or_inhib',excit_or_inhib);
end
