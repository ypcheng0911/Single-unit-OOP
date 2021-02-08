% Display object contents

function [info]=SUdisplay(SingleUnit,display)

area={'a1','a2','3b','other'};

info.site = SingleUnit.site;
info.depth = SingleUnit.area{1};
info.area = area{SingleUnit.area{2}};
info.name = SingleUnit.name;

if display==1
    
    disp(['exp site: ',SingleUnit.site]);
    disp(['depth: ',num2str(SingleUnit.area{1}),'um']);
    disp(['area: ',area{SingleUnit.area{2}}]);
    disp(['unit name: ',SingleUnit.name]);
    
    figure
    hold on
    for i=1:size(SingleUnit.waveform{1},1)
        plot(SingleUnit.waveform{1}(i,:),'b')
    end
    plot(mean(SingleUnit.waveform{1}),'linewidth',2,'color','r')
end
end