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
    case 'rating'
        val = SU.rating;
end
end