function obj = SU_anova(site,area,name,waveform, a_data_p,a_groups_p,a_stats_p,a_p_p,a_data_np,a_groups_np,a_stats_np,a_p_np)
% SingleUnit class constructor
    SU = SingleUnit(site,area,name,waveform,[],[],[],[],[],[],[]);
    obj.anova_data_PreferDigit = a_data_p;
    obj.anova_groups_PreferDigit = a_groups_p;
    obj.anova_stats_PreferDigit = a_stats_p;
    obj.anova_pvalue_PreferDigit = a_p_p;
    obj.anova_data_nPreferDigit = a_data_np;
    obj.anova_groups_nPreferDigit = a_groups_np;
    obj.anova_stats_nPreferDigit = a_stats_np;
    obj.anova_pvalue_nPreferDigit = a_p_np;
    
    obj = class(obj,'SU_anova',SU);
end