
source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');
%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060100&source=S#lopp');



%%
clc
%%%%%%%%%%%%%%%%%%%
%    GET DATA     %
%%%%%%%%%%%%%%%%%%%

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

placeringsTabell = source(placeringTabell_start:placeringTabell_end);

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
clc
%%%%%%%%%%%%%%%%%%%
%    WRITE DATA   %
%%%%%%%%%%%%%%%%%%%

tr_long   = '<tr class="header">';
bstr      = '</tr>';

header_start = strfind(placeringsTabell,tr_long);
header_end   = strfind(placeringsTabell(header_start:end),bstr);
header_end   = header_start + header_end(1) + 3;

testHeader_start = placeringsTabell(header_start);
testHeader_end   = placeringsTabell(header_end);

part_header = placeringsTabell(header_start:header_end);


th      = '<th>';
th_long = '<th class="center">';
bsth    = '</th>';

nr_headers = length(strfind(part_header, '<th'));

idx_from     = strfind(part_header,th) + length(th);
idx_to       = strfind(part_header,bsth) - 1;
alt_idx_from = strfind(part_header,th_long) + length(th_long);

idx_from = sort([idx_from alt_idx_from]);

headers = cell(nr_headers,1);
for i = 1:nr_headers
    headers(i) = {part_header(idx_from(i):idx_to(i))};
end
headers;

even = '<tr class=""';
odd  = '<tr class="odd"';

nr_even  = length(strfind(placeringsTabell,even));
nr_odd   = length(strfind(placeringsTabell,odd));
nrOfRows = nr_even + nr_odd;

part_even = strfind(placeringsTabell,even);
part_odd  = strfind(placeringsTabell,odd);

for i = 1:nrOfRows/2
    row = placeringsTabell(part_even(i):part_odd(i));
    
    if eq(i,nrOfRows/2)
        end_idx = strfind(placeringsTabell(part_odd(i):end),bstr);
        end_idx = part_odd(i) + end_idx(1) + 4;
        row = placeringsTabell(part_odd(i):end_idx);
    end
    
    col = strfind(row,'<td');
    
    for j = 1:length(col)
        cellVal = row(col(j):col(j+1)) 
    end
    
end
row;

