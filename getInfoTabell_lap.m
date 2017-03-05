function [ infoTabell ] = getInfoTabell_lap( pSource )

source = pSource;

infoTabell_start   = strfind(source,'<table class="green green_tight list">');
infoTabell_start_1 = infoTabell_start(1);
infoTabell_start_2 = infoTabell_start(2);
infoTabell_start_3 = infoTabell_start(3);

infoTabell_end = strfind(source(infoTabell_start_1:end),'</table>');
infoTabell_end = infoTabell_start_1 + infoTabell_end + 6;

infoTabell_end_1 = infoTabell_end(1);
infoTabell_end_2 = infoTabell_end(2);
infoTabell_end_3 = infoTabell_end(3);

% testInfoTabell_start_1 = source(infoTabell_start_1);
% testInfoTabell_start_2 = source(infoTabell_start_2);
% testInfoTabell_start_3 = source(infoTabell_start_3);
% testInfoTabell_end_1   = source(infoTabell_end_1);
% testInfoTabell_end_2   = source(infoTabell_end_2);
% testInfoTabell_end_3   = source(infoTabell_end_3);

infoTabell_1 = source(infoTabell_start_1:infoTabell_end_1);
infoTabell_2 = source(infoTabell_start_2:infoTabell_end_2);
infoTabell_3 = source(infoTabell_start_3:infoTabell_end_3);

infoTabell = strcat(infoTabell_1,strcat(infoTabell_2,infoTabell_3));

end

