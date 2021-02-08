% create single unit object from plx files
% Create RecordingSite objects as well.
clear
close all
clc

%--parameters---------------------------------
obj_save_loc = ['H:\UBO_monkey\analysis\sigle_unit_objects\',date];
mkdir(obj_save_loc)
sub = 'c2h';
r_site = 'site3_depth4';
abrv_site = [sub,'_',r_site([1,5,7,12])];
% bin_size=0.005;  % second   1 or 5 ms
pre_bin=500;
post_bin=1500;
dirs=[-135 -90 -45 0 45 90 135 180];
%---------------------------------------------
folder = fullfile('H:\UBO_monkey\analysis',sub,r_site);
cd(folder)
files=ls('*.plx');
u_list = Unit_loading_list_20201019(abrv_site,1);  % tolerate or not
ch_vec = u_list(:,1);
unit_vec = u_list(:,2);

waves = {};
ts_all = {};
raster = {};
Trial_all = struct();
psth = {};
for f=1:size(files,1)
    filename=files(f,:);
    %--plx_info
    ch_list{f}=ch_vec;
    unit_list{f}=unit_vec;
    
    u_name={'a','b','c','d'};
    %--load parameters
    clearvars Trial
    load([filename(1:end-8),'_TrialInfo.mat'])
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
    for u=1:length(ch_vec)
        channel=ch_vec(u);
        unit=unit_vec(u);
        %--plx_waves
        [~, ~, ts, wave] = plx_waves(filename, channel, unit);
        
        waves{f,channel,unit} = wave;
        ts_all{f,channel,unit} = ts;
        ets_all{f,channel,unit} = event_ts;
        %--raster/psth construction
        for i=1:event_n
            raster{f,channel,unit,i}=(ts(find(ts>=event_ts(i)-0.001*pre_bin & ts<event_ts(i)+0.001*post_bin))-event_ts(i))*1000; % (sec)            
        end    
    end 
end

% cellfun(@length,ch_list)
ch_all = unique([vertcat(ch_list{:}),vertcat(unit_list{:})],'rows');

for u=1:size(ch_all,1)
    channel=ch_all(u,1);
    unit=ch_all(u,2);
%--save in object---------------------------------
    site = [sub,'_',r_site([1,5,7,12])]; % abbreviation
    [A,D] = all_sites_somatosensory_areas_yupo_update(site, channel);
    area = {D,A};
    name = sprintf('ch%d_u%d',channel,unit);
    
    waveform = waves(:,channel,unit);
    spike_data = ts_all(:,channel,unit);    
    raw_data = [];
    event = ets_all(:,channel,unit);
    parameter = Trial_all;
    rasters = reshape(raster(:,channel,unit,:),size(files,1),event_n);        
    psth = [];
    
    pref_d = [];

%--create object---------------------------------
    U_name = [site,'_',name];
    eval(sprintf('%s = SingleUnit(site,area,name,waveform,spike_data,raw_data,event,parameter,rasters,psth,pref_d);',U_name))
    eval(sprintf('%s = SUpsth_1dspe(%s);',U_name,U_name))  % calculate dpsth & update to the object
    eval(sprintf('save(fullfile(obj_save_loc,U_name),''%s'')',U_name))
    U_names{u} = U_name;
end

% exceptions
if strcmp(sub,'c2h') && strcmp(r_site,'site3_depth1')
    clear
    Neu = 1;
    CreateUnits_exceptions_ver2
elseif strcmp(sub,'c2h') && strcmp(r_site,'site3_depth2')
    clear
    Neu = 2;
    CreateUnits_exceptions_ver2
end

%% RecordingSite object construction
for u=1:size(ch_all,1)
    eval(sprintf('units{u,1} = %s;',U_names{u}))
end
eval(sprintf('%s = RecordingSite(sub,r_site,units);',abrv_site))
RS_save_loc = 'H:\UBO_monkey\analysis\recording_site_objects';
eval(sprintf('save(fullfile(RS_save_loc,abrv_site),''%s'')',abrv_site))