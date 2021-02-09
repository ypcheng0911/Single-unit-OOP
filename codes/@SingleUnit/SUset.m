function  obj = SUset(obj,varargin)
n = numel(varargin);
assert(rem(n,2) == 0)  % show error warning if inputs are incomplete: e.g. ('site','3b') rather than ('3b')

i = 1;
while i < n
    name = varargin{i};
    val = varargin{i+1};
    switch name
        case 'site'
            obj.site = val;
        case 'area'
            obj.area = val;
        case 'name'
            error('reset "name" is not allowed');
        case 'waveform'
            obj.waveform = val;
        case 'ts'
            obj.spike_data = val;
        case 'raw'
            obj.raw_data = val;
        case 'event'
            obj.event = val;
        case 'parameter'
            obj.parameter = val;
        case 'raster'
            obj.raster = val;
        case 'psth'
            obj.psth = val;
        case 'pref_d'
            obj.prefer_digit = val;
        case 'responsiveness'
            obj.responsiveness = val;
        case 'low_rate'
            obj.low_rate = val;
        case 'excit_or_inhib'
            obj.excit_or_inhib = val;
        otherwise
            error(['Invalid property: ',name]);
    end
    i = i + 2;
end
end
