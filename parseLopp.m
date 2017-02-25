
source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');




%%
clc

%%% Infotext %%%

infoText_start        = strfind(source,'<div class="info_text">');
first_infoText_start  = infoText_start(1);
second_infoText_start = infoText_start(2);

first_infoText_end    = strfind(source(first_infoText_start:end),'</div>');
first_infoText_end    = first_infoText_start + first_infoText_end(1) + 4;

second_infoText_end   = strfind(source(second_infoText_start:end),'</div>');
second_infoText_end   = second_infoText_start + second_infoText_end(1) + 4;


testFirst_infoText_start  = source(first_infoText_start);
testFirst_infoText_end    = source(first_infoText_end);
testSecond_infoText_start = source(second_infoText_start);
testSecond_infoText_end   = source(second_infoText_end);

infoText = source(first_infoText_start:first_infoText_end);

infoText = strcat(infoText,source(second_infoText_start:second_infoText_end))
%%

clc
%%% Placeringstabell %%%
placeringTabell_start = strfind(source,'<table cellspacing="0" cellpadding="0" class="green">');
placeringTabell_end   = strfind(source(placeringTabell_start:end),'</table>');
placeringTabell_end   = placeringTabell_start + placeringTabell_end(1) + 6;

testFirst_plac_start = source(placeringTabell_start);
testFirst_plac_end   = source(placeringTabell_end);

table_placering = source(placeringTabell_start:placeringTabell_end);

%%
clc

%%% Infotabell %%%
infoTabell_start   = strfind(source,'<table class="green green_tight list">');
infoTabell_start_1 = infoTabell_start(1);
infoTabell_start_2 = infoTabell_start(2);
infoTabell_start_3 = infoTabell_start(3);

infoTabell_end = strfind(source(infoTabell_start_1:end),'</table>');
infoTabell_end = infoTabell_start_1 + infoTabell_end + 6;

infoTabell_end_1 = infoTabell_end(1);
infoTabell_end_2 = infoTabell_end(2);
infoTabell_end_3 = infoTabell_end(3);

testInfoTabell_start_1 = source(infoTabell_start_1);
testInfoTabell_start_2 = source(infoTabell_start_2);
testInfoTabell_start_3 = source(infoTabell_start_3);
testInfoTabell_end_1   = source(infoTabell_end_1);
testInfoTabell_end_2   = source(infoTabell_end_2);
testInfoTabell_end_3   = source(infoTabell_end_3);

infoTabell_1 = source(infoTabell_start_1:infoTabell_end_1);
infoTabell_2 = source(infoTabell_start_2:infoTabell_end_2);
infoTabell_3 = source(infoTabell_start_3:infoTabell_end_3);

infoTabell = strcat(infoTabell_1,strcat(infoTabell_2,infoTabell_3));
%%




