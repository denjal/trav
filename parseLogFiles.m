
source = webread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');




%%
clc

%%% INFO_TEXT %%%

infoText_start            = strfind(source,'<div class="info_text">');
first_infoText_start_idx  = infoText_start(1);
second_infoText_start_idx = infoText_start(2);

first_infoText_end_idx    = strfind(source(first_infoText_start_idx:end),'</div>');
first_infoText_end_idx    = first_infoText_start_idx + first_infoText_end_idx(1) + 4;

second_infoText_end_idx   = strfind(source(second_infoText_start_idx:end),'</div>');
second_infoText_end_idx   =  second_infoText_start_idx + second_infoText_end_idx(1) + 4;


testFirst_start = source(first_infoText_start_idx);
testFirst_end   = source(first_infoText_end_idx);
testSecond_start = source(second_infoText_start_idx);
testSecond_end   = source(second_infoText_end_idx);

infoText = source(first_infoText_start_idx:first_infoText_end_idx);

infoText = strcat(infoText,source(second_infoText_start_idx:second_infoText_end_idx))


%%



