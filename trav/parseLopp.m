clc
clear

tevdagId  = '560015';
loppId    = '1060058';
sourceUrl = strcat(strcat(strcat(strcat('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=',tevdagId),'&loppId='),loppId),'&source=S#lopp')
source    = urlread(sourceUrl);

%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');
%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060100&source=S#lopp');
%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060101&source=S#lopp');
%source  = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=553081&loppId=1039232&source=S#lopp');

%%

%%%%%%%%%%%%%%%%%%%
%    GET DATA     %
%%%%%%%%%%%%%%%%%%%

%%% Infotext %%%

infoText = getInfoText_lap( source );
%%

%%% Placeringstabell %%%

placeringsTabell = getPlaceringsTabell_lap( source );

%%

%%% Infotabell %%%

infoTabell = getInfoTabell_lap( source );

%%
clc
%%%%%%%%%%%%%%%%%%%
%    SORT DATA   %
%%%%%%%%%%%%%%%%%%%

[sorted_placeringsTabell, headers] = sortPlaceringsTabell_lap( placeringsTabell ) ;


tbl = array2table(sorted_placeringsTabell(2:end,:),'VariableNames',headers)
struct_tbl = table2struct(tbl);
% saveAsFilename = strcat(tevdagId,strcat('__',strcat(loppId,'.mat')));
% save(saveAsFilename,'struct_tbl');

