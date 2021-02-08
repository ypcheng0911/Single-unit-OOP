function SU = SingleUnit(site,area,name,waveform,spike_data,raw_data,event,parameter,raster,psth,pref_d)

% SingleUnit class constructor
    SU.site = site;
    SU.area = area;
    SU.name = name;
    SU.waveform = waveform;
    SU.spike_data = spike_data;
    SU.raw_data = raw_data;
    
    SU.event = event;
    SU.parameter = parameter;
    
    SU.raster = raster;
    SU.psth = psth;
    SU.prefer_digit = pref_d;
    
    SU = class(SU,'SingleUnit');
end