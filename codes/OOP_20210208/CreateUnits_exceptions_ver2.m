% create single unit object from plx files
%   For separatedly sorted files: c2h s3d1 ch9; c2h s3d2 ch53

% clear
close all
clc

% Neu = 1;
%--parameters---------------------------------
switch Neu
    case 1
        sub = 'c2h';
        r_site = 'site3_depth1';
        tar_ch = 9;
    case 2
        sub = 'c2h';
        r_site = 'site3_depth2';
        tar_ch = 53;
end
%%%% unfinished 

bin_size=0.005;  % second
pre_bin=500;
post_bin=1500;
dirs=[-135 -90 -45 0 45 90 135 180];
%---------------------------------------------
folder = fullfile('H:\UBO_monkey\analysis',sub,r_site,['ch',num2str(tar_ch)]);
cd(folder)
files=ls('*.plx');

waves = {};
ts_all = {};
raster = {};
Trial_all = struct();
psth = {};
for f=1:size(files,1)
    filename=files(f,:);
    %--plx_info
%     fullread=0;
%     [tscounts, ~, ~, ~] = plx_info(filename, fullread);
%     unit_mtx=find(tscounts(2:end,2:65)~=0);
%     [m,n]=size(tscounts);
%     ch_vec=ceil(unit_mtx/(m-1));
%     unit_vec=mod(unit_mtx,m-1);
%     unit_vec(unit_vec==0)=m-1;
    
%     u_list = [ch_vec unit_vec];
%     ch_list{f}=ch_vec;
%     unit_list{f}=unit_vec;
    
    u_name={'a','b','c','d'};
    %--load parameters
    clearvars Trial
    load([fullfile('H:\UBO_monkey\analysis',sub,r_site),'\',filename(1:end-8),'_TrialInfo.mat'])
    sp_vec=Trial.speed;
    dir_vec=Trial.direction;
    ball_type=unique(Trial.BallType);
    ball_type=ball_type{1}(1:3);
    sp_dir=[sp_vec',dir_vec'];
    Trial.file_id = filename;
    eval(sprintf('Trial_all.file%02d = Trial;',f))
    if ~ismember(size(sp_dir),[200,2],'row')
        error('Matrix size error.')
    end
    [B,index] = sortrows(sp_dir);
    %--event
    channel=67;
    unit=1;
    [event_n, ~, event_ts, ~] = plx_waves(filename, channel, unit);     
%     for u=1:length(ch_vec)
        channel=tar_ch;
        unit=1;
        %--plx_waves
        [~, ~, ts, wave] = plx_waves(filename, channel, unit);
        
        waves{f,channel,unit} = wave;
        ts_all{f,channel,unit} = ts;
        ets_all{f,channel,unit} = event_ts;
        %--raster/psth construction
        for i=1:event_n
            raster{f,channel,unit,i}=(ts(find(ts>=event_ts(i)-0.001*pre_bin & ts<event_ts(i)+0.001*post_bin))-event_ts(i))*1000; % (sec)            
        end    
        
%         waves{f,u} = wave;
%         ts_all{f,u} = ts;
%         ets_all{f,u} = event_ts;
%         %--raster/psth construction
%         for i=1:event_n
%             raster{f,u,i}=(ts(find(ts>=event_ts(i)-bin_size*pre_bin & ts<event_ts(i)+bin_size*post_bin))-event_ts(i))*1000; % (sec)            
%         end        
%     end 
end

% cellfun(@length,ch_list)
% ch_all = unique([vertcat(ch_list{:}),vertcat(unit_list{:})],'rows');

% for u=1:size(ch_all,1)
    channel=tar_ch;
    unit=1;
    unit_save_name = 2;
%--save in object---------------------------------
    site = [sub,'_',r_site([1,5,7,12])]; % abbreviation
    [A,D] = all_sites_somatosensory_areas_yupo_update(site, channel);
    area = {D,A};
    name = sprintf('ch%d_u%d',channel,unit_save_name);
    
    waveform = waves(:,channel,unit);
    spike_data = ts_all(:,channel,unit);    
    raw_data = [];
    event = ets_all(:,channel,unit);
    parameter = Trial_all;
    rasters = reshape(raster(:,channel,unit,:),size(files,1),event_n);
    
%     waveform = waves(:,u);
%     spike_data = ts_all(:,u);    
%     raw_data = [];
%     event = ets_all(:,u);
%     parameter = Trial_all;
%     rasters = reshape(raster(:,u,:),size(files,1),event_n);
        
    psth = [];
    pref_d = [];

%--create object---------------------------------
    U_name = [site,'_',name];
    obj_save_loc = 'H:\UBO_monkey\analysis\sigle_unit_objects\qualified';
    eval(sprintf('%s = SingleUnit(site,area,name,waveform,spike_data,raw_data,event,parameter,rasters,psth,pref_d);',U_name))
    eval(sprintf('save(fullfile(obj_save_loc,U_name),''%s'')',U_name))
% end
