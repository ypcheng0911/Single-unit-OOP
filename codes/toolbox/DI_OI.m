function [DI,prefer_dir,DI_alpha,DI_sig,OI,prefer_ori,OI_alpha,OI_sig] = DI_OI(fr,rand_rep,alpha)

if sum(fr)==0
    DI = nan;
    prefer_dir = nan;
    DI_alpha = nan;
    DI_sig = nan;
    OI = nan;
    prefer_ori = nan;
    OI_alpha = nan;
    OI_sig = nan;
else
    angle_radian = -3/4*pi:pi/4:pi;
    angle_theta = -135:45:180;
    DI=(((sum(fr.*sind(angle_theta))).^2+((sum(fr.*cosd(angle_theta))).^2)).^0.5)/sum(abs(fr));   %Pei 2010
    OI=(((sum(fr.*sind(angle_theta*2))).^2+((sum(fr.*cosd(angle_theta*2))).^2)).^0.5)/sum(abs(fr));  %Pei 2010
    
    % cos_vec = sum(fr.*cosd(angle_theta)); sin_vec = sum(fr.*sind(angle_theta));
    prefer_dir = round(atan2d(sum(fr.*sind(angle_theta)),sum(fr.*cosd(angle_theta))));
    %             if cos_vec < 0 && sin_vec > 0
    %                 prefer_dir(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta))/sum(fr.*cosd(angle_theta)))) + 180;
    %             elseif cos_vec < 0 && sin_vec < 0
    %                 prefer_dir(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta))/sum(fr.*cosd(angle_theta)))) - 180;
    %             else
    %                 prefer_dir(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta))/sum(fr.*cosd(angle_theta))));
    %             end
    
    prefer_ori= round(0.5 * atan2d(sum(fr.*sind(angle_theta*2)),sum(fr.*cosd(angle_theta*2))));
    %             if cos_vec > 0 && sin_vec > 0
    %                 prefer_ori(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta*2))/sum(fr.*cosd(angle_theta*2)))/2);
    %             elseif cos_vec < 0 && sin_vec > 0
    %                 prefer_ori(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta*2))/sum(fr.*cosd(angle_theta*2)))/2) + 90;
    %             elseif cos_vec < 0 && sin_vec < 0
    %                 prefer_ori(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta*2))/sum(fr.*cosd(angle_theta*2)))/2) - 90;
    %             elseif cos_vec > 0 && sin_vec < 0
    %                 prefer_ori(i,bl,spe) = round(atand(sum(fr.*sind(angle_theta*2))/sum(fr.*cosd(angle_theta*2)))/2) + 180;
    %             end
    
    %             [~,prefer_dir(i,bl,spe)] = max(fr);  % direction 1~8
    %             [~,prefer_ori(i,bl,spe)] = max(fr(1:4)+fr(5:8)); % orientation 1~4
    
    %--- random
    for ri=1:rand_rep
        fr_rand=fr(randperm(length(fr)));
        DI_rand_temp(ri)=(((sum(fr_rand.*sin(angle_radian))).^2+((sum(fr_rand.*cos(angle_radian))).^2)).^0.5)/sum(abs(fr_rand));
        fr_rand=fr(randperm(length(fr)));
        OI_rand_temp(ri)=(((sum(fr_rand.*sin(angle_radian*2))).^2+((sum(fr_rand.*cos(angle_radian*2))).^2)).^0.5)/sum(abs(fr_rand));
        %     ad_fr_rand=ad_fr(randperm(length(ad_fr)));
        %     ad_DI_rand_temp(i)=(((sum(ad_fr_rand.*sin(angle_radian))).^2+((sum(ad_fr_rand.*cos(angle_radian))).^2)).^0.5)/sum(ad_fr_rand);
        %     ad_fr_rand=ad_fr(randperm(length(ad_fr)));
        %     ad_bDI_rand_temp(i)=(((sum(ad_fr_rand.*sin(angle_radian*2))).^2+((sum(ad_fr_rand.*cos(angle_radian*2))).^2)).^0.5)/sum(ad_fr_rand);
    end
    DI_alpha = length(find(DI_rand_temp >= DI))/rand_rep;
    if  DI_alpha <= alpha %|| DI_lowercut<0.05
        DI_sig = 1;
    else
        DI_sig = 0;
    end
    OI_alpha = length(find(OI_rand_temp >= OI))/rand_rep;
    if OI_alpha <= alpha  %|| OI_lowercut<0.05
        OI_sig = 1;
    else
        OI_sig = 0;
    end
end
end