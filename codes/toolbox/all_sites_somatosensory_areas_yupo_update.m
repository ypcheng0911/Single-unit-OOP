function [Area depth] = all_sites_somatosensory_areas_yupo_update(blockname, channel)
% channel = str2num(channelName(8:end-1));
channel;
shank1 = [19 17 21 11 5 9 27 1]; %top to buttom
shank2 = [25 2 6 23 29 31 10 13];
shank3 = [12 18 28 8 16 14 32 4];
shank4 = [22 26 7 30 3 24 15 20];
shank5 = [40 44 36 57 42 61 46 49];
shank6 = [48 54 58 38 52 50 62 34];
shank7 = [64 39 41 60 33 35 51 56];
shank8 = [47 45 53 43 55 59 63 37];
Matr = [shank1 shank2 shank3 shank4 shank5 shank6 shank7 shank8];
Matr = reshape(Matr, 8, 8);

row1 = Matr(1,:);
row2 = Matr(2,:);
row3 = Matr(3,:);
row4 = Matr(4,:);
row5 = Matr(5,:);
row6 = Matr(6,:);
row7 = Matr(7,:);
row8 = Matr(8,:);


if strmatch('c2i_s1d2', blockname)
    a1 = [];
    a2 = [];
    b3 = [19 17 21 11 5 9 25 2 6 23 29 31 12 18 28 8 16 14 22 26 7 30 3 24 40 44 36 57 42 61 48 54 58 38 52 50 64 39 41 60 33 47 45 53 43 55];
    others = [27 1 10 13 32 4 15 20 46 49 62 34 35 51 56 59 63 37];
    depth = 3400;
elseif strmatch('c2i_s3d1', blockname)
    a1 = [];
    a2 = [];
    b3 = [shank1(1:7) shank2(1:7) shank3(1:7) shank4(1:7)];
    others = [1 13 4 20 shank5 shank6 shank7 shank8];
    depth = [];
elseif strmatch('c2i_s2d1', blockname)
    a1 = [];
    a2 = [];
    b3 = [shank1 shank2 shank3 shank4];
    others = [shank5 shank6 shank7 shank8];
    depth = 3300;
elseif strmatch('c2i_s1d1', blockname)
    a1 = [shank5 shank6 shank7 shank8];
    a2 = [shank1 shank2 shank3 shank4];
    b3 = [];
    others = [];
    depth = [];
elseif strmatch('c2g_s1d2', blockname)
    a1 = [22 40 48 64 47];
    a2 = [];
    b3 = [shank1 shank2 shank3 shank4(2:8) shank5(2:8) shank6(2:8) shank7(2:8) shank8(2:8)];
    others = [];
    depth = [];
elseif strmatch('c2g_s2d1', blockname)
    a1 = [];
    a2 = [shank1 shank2 shank3 shank4 shank5 shank6 shank7 shank8];
    b3 = [];
    others = [];
    depth = 1600;
elseif strmatch('c2g_s3d1', blockname)
    a1 = [shank4(1:5) shank5 shank6 shank7 shank8];
    a2 = [shank1 shank2 shank3 shank4(6:8)];
    b3 = [];
    others = [];
    depth = 1400;
elseif strmatch('c2g_s3d2', blockname)
    a1 = [shank4(1:3) shank5 shank6 shank7 shank8];
    a2 = [shank1 shank2 shank3 shank4(4:8)];
    b3 = [];
    others = [];
    depth = 2000;
elseif strmatch('c2g_s4d1', blockname)   %% checked with 嶽鵬
    a1 = [22 40 44 48 54 58 64 39 41 47 45 53];
    a2 = [];
    b3 = [25 2 6 12 18 28 8 16 14 26 7 30 3 24 15 20 36 57 42 61 46 49 38 52 50 62 34 60 33 35 51 56 43 55 59 63 37];
    others = [19 17 21 11 5 23 29 31 32 9 27 1 10 13 4];
    depth = 3500;
elseif strmatch('c2h_s1d2', blockname)
    a1 = [shank1 shank2 shank3 shank4 shank5 shank6(4:8)];
    a2 = [shank6(1:3) shank7 shank8];
    b3 = [];
    others = [];
    depth = 2504;
elseif strmatch('c2h_s2d1', blockname)
    a1 = [shank1 shank2 shank3 shank4 shank5 shank6 shank7(4:7)];
    a2 = [shank7(1:3) shank7(8) shank8];
    b3 = [];
    others = [];
    depth = 1600;
elseif strmatch('c2h_s3d1', blockname)
    a1 = [1:64];
    a2 = [];
    b3 = [];
    others = [];
    depth = 1100;
elseif strmatch('c2h_s3d2', blockname)
    a1 = [1:64];
    a2 = [];
    b3 = [];
    others = [];
    depth = 2203;
elseif strmatch('c2h_s3d3', blockname)
    a1 = [];
    a2 = [];
    b3 = [1:64];
    others = [];
    depth = 3805;
elseif strmatch('c2h_s3d4', blockname)
    a1 = [];
    a2 = [];
    b3 = [shank1 shank2 shank3 shank4(1:7) shank5(1:7) shank6(1:7) shank7(1:7) shank8(1:7)];
    others = [20 49 34 56 37];
    depth = 4605;
elseif strmatch('c2h_s1d1', blockname)
    a1 = [shank1 shank2 shank3 shank4 shank5 52 50 62 34];
    a2 = [48 54 58 38 shank7 shank8];
    b3 = [];
    others = [];
    depth = 1804;
elseif strmatch('c2e_99_104', blockname)
    a1 = [shank5(3:8) shank6 shank7 shank8 20];
    a2 = [shank1 shank2 shank3 shank4(1:7) 40 44];
    b3 = [];
    others = [];
    depth = [];
    % c2e還有些沒寫的先不寫了
% elseif
%     a1 = [];
%     a2 = [];
%     b3 = [];
%     others = [];
% elseif
%     a1 = [];
%     a2 = [];
%     b3 = [];
%     others = [];
    
end
%%
if find(a1 == channel)
    Area = 1;
elseif find(a2 == channel)
    Area = 2;
elseif find(b3 == channel)
    Area = 3;
elseif find(others == channel)
    Area = 4;
end
% Area = get_area(a1, a2, b3, others, channel);
return

% function Area = get_area(a1, a2, b3, others, channel)
% if find(a1 == channel)
%     Area = 1;
% elseif find(a2 == channel)
%     Area = 2;
% elseif find(b3 == channel)
%     Area = 3;
% elseif find(others == channel)
%     Area = 4;
% end
% return
    
    