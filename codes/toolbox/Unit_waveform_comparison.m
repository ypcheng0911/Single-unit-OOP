%% Unit waveform comparison in plx files
%   Compute the correlation coefficients of waveforms in plx files within 2
%   folders. 
%   Assign the folder paths to 'loc1' & 'loc2'. Assign a criteria for the 
%   lower boundary of correlation coefficient to 'cri'. 
%   Please make sure units in the same channel sorted in identical sequence
%   across files before Running this code.

% Haven't fixed unsorted unit problem. 2020/9/26

clear 
close all
clc

% site = 'c2h_s1d1';

loc1 = 'H:\UBO_monkey\analysis\c2h\site3_depth2\ch53';
loc2 = 'H:\UBO_monkey\analysis\c2h\site3_depth2\ch53';

cri = 0.9;    % criteria for correlation coefficients of waveforms across plx files
%==========================================================================
plx_all_1 = ls([loc1,'\*.plx']);
plx_all_2 = ls([loc2,'\*.plx']);
cd(loc1)
for i = 1:size(plx_all_1,1)
    [tscounts_1{i}, ~, ~, ~] = plx_info(plx_all_1(i,:), 0);
end
cd(loc2)
for i = 1:size(plx_all_2,1)
    [tscounts_2{i}, ~, ~, ~] = plx_info(plx_all_2(i,:), 0);
end
a = @(x) [floor((find(x(2:end,2:end)>1))/(size(x,1)-1))+1 mod((find(x(2:end,2:end)>1)),size(x,1)-1)];
ch_u_list_1 = cellfun(a, tscounts_1,'UniformOutput',false);
ch_u_list_2 = cellfun(a, tscounts_2,'UniformOutput',false);
CHU_list1=[]; CHU_list2=[];
for i = 1:length(ch_u_list_1)
    s1(i) = size(ch_u_list_1{i},1);
    CHU_list1(length(CHU_list1)+1:length(CHU_list1)+s1(i),:) = ch_u_list_1{i}; 
end
for i = 1:length(ch_u_list_2)
    s2(i) = size(ch_u_list_2{i},1);
    CHU_list2(length(CHU_list2)+1:length(CHU_list2)+s2(i),:) = ch_u_list_2{i}; 
end
all_units = unique([CHU_list1; CHU_list2],'rows');
%==========================================================================
for loc = 1:2
    switch loc
        case 1
            filename = plx_all_1;
        case 2
            filename = plx_all_2;
    end
    for f = 1:size(filename,1)
        for i = 1:size(all_units,1)
            ch = all_units(i,1);
            u = all_units(i,2);
            if ch > 64
                continue
            end
%             if ismember(ch,[5 ])   % for testing
%                 continue
%             end
            [~, ~, ~, wave.(['ch',num2str(ch),'u',num2str(u)]){loc,f}] = plx_waves(filename(f,:), ch, u);
            m_wave.(['ch',num2str(ch),'u',num2str(u)]){loc,f} = mean(wave.(['ch',num2str(ch),'u',num2str(u)]){loc,f})'; 
        end
    end
end
for j = 1:size(all_units,1)
    ch = all_units(j,1);
    u = all_units(j,2);
    temp_matrix=[];
    if ch > 64
        continue
    end
%     if ismember(ch,[5])   % for testing
%         continue
%     end
    for i = 1:size(plx_all_1,1)
        temp_matrix(:,i) = m_wave.(['ch',num2str(ch),'u',num2str(u)]){1,i};
    end
    for i = 1:size(plx_all_2,1)
        temp_matrix(:,size(plx_all_1,1)+i) = m_wave.(['ch',num2str(ch),'u',num2str(u)]){2,i};
    end
    m_wave_matrix.(['ch',num2str(ch),'u',num2str(u)]) = temp_matrix;
    R_matrix.(['ch',num2str(ch),'u',num2str(u)]) = corrcoef(temp_matrix);
end
f = fieldnames(R_matrix);
criteria = zeros(1,size(f,1));
for i = 1:size(f,1)
    criteria(i) = isempty(find(R_matrix.(f{i})<cri));
    if criteria(i) == 0
        disp([f{i},' showed different waveforms. Please see ''R_matrix'' in the Workspace.'])
    end
end
if sum(criteria) == size(f,1)
    disp('Well done!! Waveforms across files are all similar.')
end