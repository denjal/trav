function [ infoText ] = getInfoText_lap( pSource )

source  = pSource;

infoText_start        = strfind(source,'<div class="info_text">');
first_infoText_start  = infoText_start(1);
second_infoText_start = infoText_start(2);

first_infoText_end    = strfind(source(first_infoText_start:end),'</div>');
first_infoText_end    = first_infoText_start + first_infoText_end(1) + 4;

second_infoText_end   = strfind(source(second_infoText_start:end),'</div>');
second_infoText_end   = second_infoText_start + second_infoText_end(1) + 4;


% testFirst_infoText_start  = source(first_infoText_start);
% testFirst_infoText_end    = source(first_infoText_end);
% testSecond_infoText_start = source(second_infoText_start);
% testSecond_infoText_end   = source(second_infoText_end);

infoText = source(first_infoText_start:first_infoText_end);


infoText = strcat(infoText,source(second_infoText_start:second_infoText_end));


end

