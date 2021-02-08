function [F_ratio,spe_F_ratio,spe_std_F,Sig_F,peak_freq,peak_F] = speed_FFT_overlap_all_trials(filename01,filename02,tar_ch,tar_unit,plot_ny,hide)
% try F1/F0 ratio
% F1 first harmonic in Fourier analysis
% fix ball, check Fourier transfer, power spectrum harmonics
if nargin < 5
    plot_ny = 'y';
    hide = 'n';
end
%%  PIPELINE
trialname01 = filename01(max(strfind(filename01,'\'))+1:min(strfind(filename01,'.'))-1);
trialname02 = filename02(max(strfind(filename02,'\'))+1:min(strfind(filename02,'.'))-1);

sub = filename01(min(strfind(filename01,'c')):min(strfind(filename01,'c'))+3);
site = filename01(strfind(filename01,'site'):strfind(filename01,'site')+11);
sp_mm = str2num(filename01(strfind(filename01,'sg')+2));
Trial01 = load(['H:\UBO_monkey\analysis\',sub,'\',site,'\',trialname01,'_TrialInfo.mat'],'Trial');
Trial02 = load(['H:\UBO_monkey\analysis\',sub,'\',site,'\',trialname02,'_TrialInfo.mat'],'Trial');

% load(['H:\UBO_monkey\analysis\c2h\site3_depth3\',trialname,'_TrialInfo.mat'])

%--- event
channel=67;
unit=1;
[~,~,event_ts01,~] = plx_waves(filename01, channel, unit);
[~,~,event_ts02,~] = plx_waves(filename02, channel, unit);

%%
%--- signal
% tar_ch = 9;
% unit=1;
[~,~,tar_ts01,~] = plx_waves(filename01, tar_ch, tar_unit);
[~,~,tar_ts02,~] = plx_waves(filename02, tar_ch, tar_unit);

if tar_ts01==-1 & tar_ts02==-1
    F_ratio = nan;
    spe_F_ratio = nan;
    spe_std_F = nan;
    Sig_F = nan;
    peak_freq = nan;
    peak_F = nan;
    return
end

% record_t = NS6.MetaTags.DataDurationSec;
%-- more than recording time, ensuring coverage while not loading NS6
record_t = 460;

bin = 0.001;
% bin_n = ceil(record_t/bin);
% h = hist(tar_ts,bin_n);
h01 = hist(tar_ts01,[0:bin:record_t-bin]);
h02 = hist(tar_ts02,[0:bin:record_t-bin]);

%--- FFT parameters
Fs = 1/bin;
T = 1/Fs;
L01 = length(h01);  % 12684226 data points for entire recording
L02 = length(h02);  % 12684226 data points for entire recording
n = 1024;

H = [h01,h02];
LH = length(H);
Y = abs(fft((H-mean(H)*hann(LH)'),n)/LH);
Y1 = Y(:,1:n/2+1);
Y1(:,2:end-1) = 2*Y1(:,2:end-1);
f = 0:Fs/n:Fs/2-Fs/n;

% figure
% plot(f,Y1(1:n/2))
% % xlim([0 100])
% ylabel('|Y1|')
% xlabel('Frequency (Hz)')
%----------------------------
for i = 1:ceil(LH/n)
    if i ~= ceil(LH/n)
        Y_loop(i,:) = abs(fft(((H(n*(i-1)+1:n*i)-mean(H(n*(i-1)+1:n*i)))),n)/n);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:n*i)-mean(h(n*(i-1)+1:n*i)))*hann(length(n))'),n)/n);
        Y1_loop(i,:) = Y_loop(i,1:n/2+1);
        Y1_loop(i,2:end-1) = Y1_loop(i,2:end-1).^2;
    else
        Y_loop(i,:) = abs(fft(((H(n*(i-1)+1:end)-mean(H(n*(i-1)+1:end)))),n)/n);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:end)-mean(h(n*(i-1)+1:end)))*hann(length(n))'),n)/n);
        Y1_loop(i,:) = Y_loop(i,1:n/2+1);
        Y1_loop(i,2:end-1) = Y1_loop(i,2:end-1).^2;
    end
end
f = 0:Fs/n:Fs/2-Fs/n;
Y_abs = mean(Y1_loop,1);
Y_psd = Y_abs/sum(Y_abs);
if strcmp(plot_ny,'y')
    switch hide
        case 'n'
            figure('position',[50,50,1800,800]);
        case 'y'
            figure('position',[50,50,1800,800],'visible','off');
    end
    subplot(231)
    plot(f,Y_abs(1:n/2))
    xlim([1 500])
    ylabel('|Y1|^2')
    xlabel('frequency (Hz)')
    title('entire recording session')
    %     subplot(212)
    %     plot(f,Y_psd(1:n/2))
    %     xlim([1 500])
    %     ylabel('% PSD')
    %     xlabel('frequency (Hz)')
end
%-- Local peak to global average ratio
tar_feq = [5 10 20 40 80 160 320];
for i = 1:length(tar_feq)
    %-- Local maximum of sti frequencies
    F_ratio(i) = max(Y_abs(max(find(f<tar_feq(i)-2.5)):min(find(f>tar_feq(i)+2.5))))/mean(Y_abs);
end

%% --- PSD under specific speeds
spe_set = [20 40 80 160 320];
% skip_on = 0.1/bin;
% l_sti = 0.8/bin;
skip_on = 0/bin;
l_sti = 1/bin;

for sp = 1:length(spe_set)
    idx_spe01 = find(Trial01.Trial.speed==spe_set(sp));
    stamps_int01 = event_ts01(idx_spe01);
    
    for i = 1:length(idx_spe01)
        spe_Y_loop(i,:) = abs(fft(((h01(round(stamps_int01(i)/bin)+skip_on+1:round(stamps_int01(i)/bin)+skip_on+l_sti)-mean(h01(round(stamps_int01(i)/bin)+skip_on+1:round(stamps_int01(i)/bin)+skip_on+l_sti)))),n)/l_sti);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:n*i)-mean(h(n*(i-1)+1:n*i)))*hann(length(n))'),n)/n);
        spe_Y1_loop(i,:) = spe_Y_loop(i,1:n/2+1);
        spe_Y1_loop(i,2:end-1) = spe_Y1_loop(i,2:end-1).^2;
    end
    
    idx_spe02 = find(Trial02.Trial.speed==spe_set(sp));
    stamps_int02 = event_ts02(idx_spe02);
    for i = 1:length(idx_spe02)
        spe_Y_loop(length(idx_spe01)+i,:) = abs(fft(((h02(round(stamps_int02(i)/bin)+skip_on+1:round(stamps_int02(i)/bin)+skip_on+l_sti)-mean(h02(round(stamps_int02(i)/bin)+skip_on+1:round(stamps_int02(i)/bin)+skip_on+l_sti)))),n)/l_sti);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:n*i)-mean(h(n*(i-1)+1:n*i)))*hann(length(n))'),n)/n);
        spe_Y1_loop(length(idx_spe01)+i,:) = spe_Y_loop(length(idx_spe01)+i,1:n/2+1);
        spe_Y1_loop(length(idx_spe01)+i,2:end-1) = spe_Y1_loop(length(idx_spe01)+i,2:end-1).^2;
    end
    spe_Y_abs = mean(spe_Y1_loop,1);
    spe_Y_psd = spe_Y_abs/sum(spe_Y_abs);
    
    if strcmp(plot_ny,'y')
        hold on
        subplot(2,3,sp+1)
        plot(f,spe_Y_abs(1:n/2))
        xlim([1 500])
        ylabel('|Y1|^2')
        xlabel('frequency (Hz)')
        title([num2str(sp_mm),' mm ball, ',num2str(spe_set(sp)),' mm/s'])
    end
    
    spe_Y_plot{sp} = spe_Y_abs(1:n/2);
    
    
    for j = 1:length(tar_feq)
        %-- Local maximum of sti frequencies
        spe_F_ratio(sp,j) = max(spe_Y_abs(max(find(f<tar_feq(j)-2.5)):min(find(f>tar_feq(j)+2.5))))/mean(spe_Y_abs);
        spe_std_F(sp,j) = std(spe_Y_abs);
    end
    peak_freq(sp) = min(f(find(max(spe_Y_abs(1:n/2))==spe_Y_abs(1:n/2))));
    peak_F(sp) = max(spe_Y_abs(1:n/2))/mean(spe_Y_abs);
end
if strcmp(plot_ny,'y')
    switch hide
        case 'n'
            figure('position',[1200 150 800 400]);
        case 'y'
            figure('position',[1200 150 800 400],'visible','off');
    end
end
for sp = 1:length(spe_set)
    if strcmp(plot_ny,'y')
        hold on
        plot(f,spe_Y_plot{sp})
        xlim([1 500])
        ylabel('|Y1|^2')
        xlabel('frequency (Hz)')
        title([num2str(sp_mm),' mm ball'])
        if sp==5
            legend('20','40','80','160','320')
        end
    end
end

%-- spF greater than 3 STDs
Sig_F = spe_F_ratio > ones(size(spe_F_ratio)) + 3*spe_std_F;

end