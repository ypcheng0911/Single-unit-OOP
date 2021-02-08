function [F_ratio,spe_F_ratio,spe_std_F,Sig_F] = speed_FFT(filename,tar_ch,tar_unit,plot_ny)
% try F1/F0 ratio
% F1 first harmonic in Fourier analysis
% fix ball, check Fourier transfer, power spectrum harmonics
if nargin < 4
    plot_ny = 'y';
end
%%  PIPELINE
trialname = filename(max(strfind(filename,'\'))+1:min(strfind(filename,'.'))-1);
sub = filename(min(strfind(filename,'c')):min(strfind(filename,'c'))+3);
site = filename(strfind(filename,'site'):strfind(filename,'site')+11);
sp_mm = str2num(filename(strfind(filename,'sg')+2));
load(['H:\UBO_monkey\analysis\',sub,'\',site,'\',trialname,'_TrialInfo.mat'])

% load(['H:\UBO_monkey\analysis\c2h\site3_depth3\',trialname,'_TrialInfo.mat'])

%--- event
channel=67;
unit=1;
[event_n,~,event_ts,~] = plx_waves(filename, channel, unit);

%%
%--- signal
% tar_ch = 9;
% unit=1;
[~,~,tar_ts,~] = plx_waves(filename, tar_ch, tar_unit);
% record_t = NS6.MetaTags.DataDurationSec;
%-- more than recording time, ensuring coverage while not loading NS6
record_t = 460;

bin = 0.001;
% bin_n = ceil(record_t/bin);
% h = hist(tar_ts,bin_n);
h = hist(tar_ts,[0:bin:record_t-bin]);

%--- FFT parameters
Fs = 1/bin;
T = 1/Fs;
L = length(h);  % 12684226 data points for entire recording
n = 1024;

Y = abs(fft((h-mean(h)*hann(length(h))'),n)/L);
Y1 = Y(:,1:n/2+1);
Y1(:,2:end-1) = 2*Y1(:,2:end-1);
f = 0:Fs/n:Fs/2-Fs/n;

% figure
% plot(f,Y1(1:n/2))
% % xlim([0 100])
% ylabel('|Y1|')
% xlabel('Frequency (Hz)')
%----------------------------
for i = 1:ceil(length(h)/n)
    if i ~= ceil(length(h)/n)
        Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:n*i)-mean(h(n*(i-1)+1:n*i)))),n)/n);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:n*i)-mean(h(n*(i-1)+1:n*i)))*hann(length(n))'),n)/n);
        Y1_loop(i,:) = Y_loop(i,1:n/2+1);
        Y1_loop(i,2:end-1) = Y1_loop(i,2:end-1).^2;
    else
        Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:end)-mean(h(n*(i-1)+1:end)))),n)/n);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:end)-mean(h(n*(i-1)+1:end)))*hann(length(n))'),n)/n);
        Y1_loop(i,:) = Y_loop(i,1:n/2+1);
        Y1_loop(i,2:end-1) = Y1_loop(i,2:end-1).^2;
    end
end
f = 0:Fs/n:Fs/2-Fs/n;
Y_abs = mean(Y1_loop,1);
Y_psd = Y_abs/sum(Y_abs);
if strcmp(plot_ny,'y')
    figure
    subplot(211)
    plot(f,Y_abs(1:n/2))
    xlim([1 500])
    ylabel('|Y1|^2')
    xlabel('Frequency (Hz)')
    subplot(212)
    plot(f,Y_psd(1:n/2))
    xlim([1 500])
    ylabel('% PSD')
    xlabel('Frequency (Hz)')
end
%-- Local peak to global average ratio
tar_feq = [5 10 20 40 80 160 320];
for i = 1:length(tar_feq)
    %-- Local maximum of sti frequencies
    F_ratio(i) = max(Y_abs(max(find(f<tar_feq(i)-2.5)):min(find(f>tar_feq(i)+2.5))))/mean(Y_abs);
end

%% --- PSD under specific speeds
spe_set = [20 40 80 160 320];
skip_on = 0.1/bin;
l_sti = 0.8/bin;
% figgg = figure;
for sp = 1:length(spe_set)
    idx_spe = find(Trial.speed==spe_set(sp));
    stamps_int = event_ts(idx_spe);
    
    for i = 1:length(idx_spe)
        spe_Y_loop(i,:) = abs(fft(((h(round(stamps_int(i)/bin)+skip_on+1:round(stamps_int(i)/bin)+skip_on+l_sti)-mean(h(round(stamps_int(i)/bin)+skip_on+1:round(stamps_int(i)/bin)+skip_on+l_sti)))),n)/l_sti);
        %         Y_loop(i,:) = abs(fft(((h(n*(i-1)+1:n*i)-mean(h(n*(i-1)+1:n*i)))*hann(length(n))'),n)/n);
        spe_Y1_loop(i,:) = spe_Y_loop(i,1:n/2+1);
        spe_Y1_loop(i,2:end-1) = spe_Y1_loop(i,2:end-1).^2;
    end
    spe_Y_abs = mean(spe_Y1_loop,1);
    spe_Y_psd = spe_Y_abs/sum(spe_Y_abs);
    
    if strcmp(plot_ny,'y')
        figure
        plot(f,spe_Y_abs(1:n/2))
        xlim([1 500])
        ylabel('|Y1|^2')
        xlabel('Frequency (Hz)')
        title([num2str(sp_mm),' mm ball, ',num2str(spe_set(sp)),' mm/s'])
    end
    
    for j = 1:length(tar_feq)
        %-- Local maximum of sti frequencies
        spe_F_ratio(sp,j) = max(spe_Y_abs(max(find(f<tar_feq(j)-2.5)):min(find(f>tar_feq(j)+2.5))))/mean(spe_Y_abs);
        spe_std_F(sp,j) = std(spe_Y_abs);
    end
end
%-- spF greater than 3 STDs
Sig_F = spe_F_ratio > ones(size(spe_F_ratio)) + 3*spe_std_F;

end