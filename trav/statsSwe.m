% str = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');
% str2 = webread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');


str = urlread('http://stats.swehockey.se/Players/Statistics/ScoringLeaders/7132');

%%
clc
str(str == ' ') = [];
tableStart_idx   = strfind(str,'<tableclass="tblContent">');
tableObjects_idx = strfind(str,'</table>');

for i = 1:length(tableObjects_idx)
    if tableStart_idx < tableObjects_idx(i)
        tableEnd_idx = tableObjects_idx(i);
        break
    end
end

tableContent = str(tableStart_idx:tableEnd_idx);
%%