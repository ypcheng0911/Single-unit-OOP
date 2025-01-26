function SU = SingleUnit(site,area,name,waveform,spike_data,raw_data,event,parameter,raster,psth,pref_d,resp,low_rate,excit_or_inhib)

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
    SU.responsiveness = resp;
    SU.low_rate = low_rate;
    SU.excit_or_inhib = excit_or_inhib;
    
    SU = class(SU,'SingleUnit');
end