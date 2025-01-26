function val = SUanovaread(obj)
    val.data_p = obj.anova_data_PreferDigit;
    val.group_p = obj.anova_groups_PreferDigit;
    val.stat_p = obj.anova_stats_PreferDigit;
    val.pvalue_p = obj.anova_pvalue_PreferDigit;
    
    val.data_np = obj.anova_data_nPreferDigit;
    val.group_np = obj.anova_groups_nPreferDigit;
    val.stat_np = obj.anova_stats_nPreferDigit;
    val.pvalue_np = obj.anova_pvalue_nPreferDigit;
end