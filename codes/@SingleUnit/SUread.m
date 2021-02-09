function val = SUread(SU, property)
switch property
    case 'site'
        val = SU.site;
    case 'area'
        val = SU.area;
    case 'name'
        val = SU.name;
    case 'waveform'
        val = SU.waveform;
    case 'ts'
        val = SU.spike_data;
    case 'raw'
        val = SU.raw_data;
    case 'event'
        val = SU.event;
    case 'parameter'
        val = SU.parameter;
    case 'raster'
        val = SU.raster;
    case 'psth'
        val = SU.psth;
    case 'pref_d'
        val = SU.prefer_digit;
    case 'responsiveness'
        val = SU.responsiveness;
    case 'low_rate'
        val = SU.low_rate;
    case 'excit_or_inhib'
        val = SU.excit_or_inhib;
end
end