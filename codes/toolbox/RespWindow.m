function [BO_window,AO0_window,AO1_window,AO2_window,AO3_window] = RespWindow(pre_bin,bin_size)
% Computation window for responsiveness testing 

BO_window=(pre_bin-300)/(bin_size*1000)+1:(pre_bin-200)/(bin_size*1000);
AO0_window=(pre_bin-50)/(bin_size*1000)+1:(pre_bin+50)/(bin_size*1000);       %% on response
AO1_window=(pre_bin+100)/(bin_size*1000)+1:(pre_bin+200)/(bin_size*1000);     %% initial sustain response
AO2_window=(pre_bin+900)/(bin_size*1000)+1:(pre_bin+1000)/(bin_size*1000);    %% off response
AO3_window=(pre_bin+1350)/(bin_size*1000)+1:(pre_bin+1450)/(bin_size*1000);   %% end vibration
end