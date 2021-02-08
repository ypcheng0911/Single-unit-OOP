% Calculate psth of SingleUnit objects
%   [psth, d_psth] = SUpsth(SU)  
%   psth(file, bin, iteration)
%   d_psth(finger_stimulated, direction, speed, ball_type, bin, repetition)
%
%   Assign d_psth back to objects.

function  [SU, psth, d_psth, bin_size] = SUpsth_1dspe(SU)

ts=SU.spike_data;  % 12x1 cell
event=SU.event;
%---
bin_size=0.002;  % second   1 or 5 ms
pre_bin=500;
post_bin=1500;
dirs=[-135 -90 -45 0 45 90 135 180];
spes=[20 40 80 160 320];
balls={'sg1';'sg2';'sg4'};
bin_n = (pre_bin+post_bin)/(bin_size*1000);
%---
psth=zeros(12,bin_n,200);
d_psth=zeros(8,5,3,bin_n,20);
% d_psth=single(d_psth);
for f = 1:12
    eval(sprintf('file_ids(f,:)=SU.parameter.file%02d.file_id;',f));   
    para(f,:)=file_ids(f,1:min(findstr(file_ids(f,:),'.'))-1);
    fing_id(f,:)=para(f,strfind(para(f,:),'_d')+1:strfind(para(f,:),'_d')+2);
end
[~,firstR,~]=unique(para(:,1:end-3),'rows');
[~,~,fing_list]=unique(fing_id,'rows');
secondR=setdiff(1:12,firstR);
for f = 1:12
    fing_sti = fing_list(f);
    spike_temp = ts{f};
    sti_temp = event{f};
    
    eval(sprintf('dir_list = SU.parameter.file%02d.direction;',f))
    eval(sprintf('spe_list = SU.parameter.file%02d.speed;',f))
    eval(sprintf('ball = SU.parameter.file%02d.BallType;',f))
    eval(sprintf('rep = SU.parameter.file%02d.n_repetition;',f))
    if ismember(f,secondR)
        rep = rep+5;
    end
    % 5 dim fing rep stack  or  4 dim fing rep, dir spe
    if fing_sti==2
        rep=rep+10;
    end
    %==    
    ball=unique(ball);
    bl=[];
    bl=find(strcmp(balls,ball{1}(1:3)));
    %---
    for i=1:length(sti_temp)
        d_temp=dir_list(i);
        d=[];
        d=find(dirs==d_temp);
        s_temp=spe_list(i);
        s=[];
        s=find(spes==s_temp);
        r=rep(i);
        for b=1:bin_n
            psth(f,b,i)=length(find(spike_temp >= sti_temp(i)-pre_bin*0.001+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*0.001+bin_size*b));   
%             % 6 dim
%             d_psth(fing_sti,d,s,bl,b,r)=length(find(spike_temp > sti_temp(i)-pre_bin*bin_size+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*bin_size+bin_size*b)); 
%             % 5 dim in 1 dim cell
%             d_psth{fing_sti}(d,s,bl,b,r)=length(find(spike_temp > sti_temp(i)-pre_bin*bin_size+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*bin_size+bin_size*b)); 

            % 5 dim fing rep stack
            d_psth(d,s,bl,b,r)=length(find(spike_temp >= sti_temp(i)-pre_bin*0.001+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*0.001+bin_size*b)); 
            %=== debug ===
            test(d,s,bl,b,r)=bl;
            
            %=============
%             % 4 dim in 2 dim cell, hard for later process
%             d_psth{fing_sti,d}(s,bl,b,r)=length(find(spike_temp > sti_temp(i)-pre_bin*bin_size+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*bin_size+bin_size*b)); 
%             % 4 dim, fing rep stack, dir spe stack
%             d_psth(d+8*(s-1),bl,b,r)=length(find(spike_temp > sti_temp(i)-pre_bin*bin_size+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*bin_size+bin_size*b));
%             % 2 dim: trial x parameters  
%             d_psth(b+2001*(i-1+200*(f-1)),:)=[fing_sti,d,s,bl,b,r,length(find(spike_temp > sti_temp(i)-pre_bin*bin_size+bin_size*(b-1) & spike_temp < sti_temp(i)-pre_bin*bin_size+bin_size*b))];

        end        
    end
end
SU = SUset(SU,'psth',d_psth);
% PSTH = sum(psth,3);
% figure
% plot(PSTH(1,:))
end