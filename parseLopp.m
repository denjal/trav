clc
clear

tevdagId  = '560015';
loppId    = '1060058';
sourceUrl = strcat(strcat(strcat(strcat('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=',tevdagId),'&loppId='),loppId),'&source=S#lopp');
source    = urlread(sourceUrl);

%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060056&source=S#lopp');
%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060100&source=S#lopp');
%source = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=560015&loppId=1060101&source=S#lopp');
%source  = urlread('https://www.travsport.se/sresultat?kommando=tevlingsdagVisa&tevdagId=553081&loppId=1039232&source=S#lopp');

%%
clc
%%%%%%%%%%%%%%%%%%%
%    GET DATA     %
%%%%%%%%%%%%%%%%%%%

%%% Infotext %%%

getInfoText_Lap( source );
%%

%%% Placeringstabell %%%

getPlaceringsTabell_lap( source );

%%

%%% Infotabell %%%

getInfoTabell_lap( source );

%%

%%%%%%%%%%%%%%%%%%%
%    SORT DATA   %
%%%%%%%%%%%%%%%%%%%

tr_long   = '<tr class="header">';
s_tr      = '</tr>';

header_start = strfind(placeringsTabell,tr_long);
header_end   = strfind(placeringsTabell(header_start:end),s_tr);
header_end   = header_start + header_end(1) + 3;

testHeader_start = placeringsTabell(header_start);
testHeader_end   = placeringsTabell(header_end);

part_header = placeringsTabell(header_start:header_end);


th      = '<th>';
th_long = '<th class="center">';
s_th    = '</th>';

nr_headers = length(strfind(part_header, '<th'));

idx_from     = strfind(part_header,th) + length(th);
idx_to       = strfind(part_header,s_th) - 1;
alt_idx_from = strfind(part_header,th_long) + length(th_long);

idx_from = sort([idx_from alt_idx_from]);

headers = cell(nr_headers + 1,1);
i = 1;
skipped = false;

while i < nr_headers+2
    if(eq(i,3))
        str  = part_header(idx_from(i):idx_to(i));
        str = strsplit(str, ' ');
        headers(i)   = str(1);
        headers(i+1) = str(2);
        i = i + 1;
        skipped = true;
    else
        if skipped
            headers(i) = {part_header(idx_from(i-1):idx_to(i-1))};
        else
            headers(i) = {part_header(idx_from(i):idx_to(i))};
        end
    end
    i = i + 1;
end
headers = strrep(headers(:),'Häst','Hast');
headers = strrep(headers(:),'(Tränare)','Tranare');
%tbl = array2table(1:length(headers),'VariableNames', headers(:));


find_row = '<tr class=';

part_row_idx       = strfind(placeringsTabell,find_row);
part_row_clean_idx = strfind(placeringsTabell,strcat(find_row,'"clean"'));
rm_row_idx         = find(eq(part_row_idx,part_row_clean_idx));
part_row_idx(rm_row_idx) = [];

nrOfRows =  length(part_row_idx);

td = '<td';
std = '/td>';
right = '>';
left = '<';
a = '<a';
bsa = '/a>';
strong = '<strong';
s_strong = '/strong>';
sko_gif = 'Sko.gif';
ejSko_gif = 'EjSko.gif';

created_tbl = false;


for i = 1:(nrOfRows)
    
    if eq(i,nrOfRows)
        rowEnd_idx = strfind(placeringsTabell(part_row_idx(i):end),s_tr);
        rowEnd_idx = part_row_idx(i) + rowEnd_idx(1) + length(s_th);
        part_row = placeringsTabell(part_row_idx(i):rowEnd_idx);
    else
        part_row = placeringsTabell(part_row_idx(i):part_row_idx(i+1));
    end
    
    part_col = strfind(part_row,td);
    
    row = cell(1,length(part_col)+1);
    
    j = 1;
    skip_iter = 1;
    while j < length(part_col) +1
        
        if eq(j,9)
            break
        end
        
        if ~created_tbl
            tbl = cell(nrOfRows, length(part_col)+1);
            tbl(1,:) = headers;
            created_tbl = true;
        end
        skipped = false;
        
        if eq(j,length(part_col))
            cell_start = part_col(j) + length(td);
            cell_end   = cell_start + strfind(part_row(cell_start:end),std);
        else
            cell_start = part_col(j) + length(td);
            cell_end   = part_col(j+1) - 2*length(std);
        end
        
        idx_start = strfind(part_row(cell_start:cell_end),right);
        idx_start = cell_start + idx_start;
        idx_end   = strfind(part_row(idx_start:cell_end),left) - 2*length(left);
        idx_end   = idx_start + idx_end(1);
        
        if or(length(idx_start)>1,length(idx_end)<1)
            if eq(j,2)
                subCell           = part_row(cell_start:cell_end);
                subCell_start_idx = strfind(subCell,a) + length(a);
                subCell_end_idx   = strfind(subCell,bsa);
                
                nrSubCells = length(subCell_start_idx);
                
                subCell_arr = cell(nrSubCells,1);
                for k = 1:nrSubCells
                    idx_start = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),right);
                    idx_start = subCell_start_idx(k) + idx_start;
                    idx_end   = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),left);
                    idx_end   = subCell_start_idx(k) + idx_end - 2*length(left);
                    subCell_arr(k) = {subCell(idx_start:idx_end)};
                    tbl(i,j)   = subCell_arr(k);
                    j = 2 + k;
                end
                j = 3;
                skipped = true;
            end

            if eq(j,5)
                if ~eq(i,1)
                    subCell           = part_row(cell_start:cell_end);
                    shoe              = strfind(subCell,sko_gif);
                    no_shoe           = strfind(subCell,ejSko_gif);
                    if isempty(no_shoe)
                        cellVal = 'Both';
                    else
                        
                        if eq(length(no_shoe),2)
                            cellVal = 'No Shoe';
                        else
                            diff_1 = shoe(1) - no_shoe;
                            diff_2 = shoe(2) - no_shoe;
                            if (abs(diff_1) < abs(diff_2))
                                cellVal = 'Back';
                            else
                                cellVal = 'Front';
                            end
                        end
                    end
                end
            end
            
            if eq(j,6)
                if eq(i,2)
                    subCell           = part_row(cell_start:cell_end);
                    subCell_start_idx = strfind(subCell,strong) + length(strong);
                    subCell_end_idx   = strfind(subCell,s_strong);
                    nrSubCells = length(subCell_start_idx);
                    subCell_arr = cell(nrSubCells,1);
                    for k = 1:nrSubCells
                        idx_start = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),right);
                        idx_start = subCell_start_idx(k) + idx_start;
                        idx_end   = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),left);
                        idx_end   = subCell_start_idx(k) + idx_end - 2*length(left);
                        subCell_arr(k) = {subCell(idx_start:idx_end)};
                    end
                    cellVal = subCell_arr{1};
                end
            end
            
            if eq(j,8)
                cellVal = part_row(idx_start(1):idx_end(1));
            end
            
        else
            cellVal = part_row(idx_start:idx_end);
        end

        if skipped
            skip_iter = skip_iter +1;
        else
            tbl(i,j+skip_iter-1) = {cellVal};
        end
        j = j + 1;
    end
    
end
tbl(:,7) = strtrim(tbl(:,7));
emptyCells = cellfun(@isempty,tbl);
tbl(emptyCells) = {','};

tbl = array2table(tbl(2:end,:),'VariableNames',headers);
struct_tbl = table2struct(tbl);
saveAsFilename = strcat(tevdagId,strcat('__',strcat(loppId,'.mat')));
save(saveAsFilename,'struct_tbl');

