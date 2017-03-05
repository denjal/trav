function [ tbl, headers ] = sortPlaceringsTabell_lap( pPlaceringsTabell )

placeringsTabell = pPlaceringsTabell;


headers = getHeaders_placTabell_lap( placeringsTabell );


find_row = '<tr class=';
s_tr      = '</tr>';

s_th    = '</th>';

part_row_idx       = strfind(placeringsTabell,find_row);
part_row_clean_idx = strfind(placeringsTabell,strcat(find_row,'"clean"'));
rm_row_idx         = find(eq(part_row_idx,part_row_clean_idx));
part_row_idx(rm_row_idx) = [];

nrOfRows =  length(part_row_idx);

td = '<td';             std = '/td>';
a = '<a';               bsa = '/a>';
strong = '<strong';     s_strong = '/strong>';
sko_gif = 'Sko.gif';    ejSko_gif = 'EjSko.gif';

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
    
%     row = cell(1,length(part_col)+1);
    
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
        
        [ idx_start, idx_end ] = getCol_start_end_idx( cell_start, cell_end, part_row );
        
  
        
        if or(length(idx_start)>1,length(idx_end)<1)
            if eq(j,2)
                subCell           = part_row(cell_start:cell_end);
                subCell_start_idx = strfind(subCell,a) + length(a);
                subCell_end_idx   = strfind(subCell,bsa);
                
                nrSubCells = length(subCell_start_idx);
                
                subCell_arr = cell(nrSubCells,1);
                for k = 1:nrSubCells
                    [ idx_start, idx_end ] = getCol_start_end_idx( subCell_start_idx(k), subCell_end_idx(k), subCell);
                    
%                     idx_start = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),right);
%                     idx_start = subCell_start_idx(k) + idx_start;
%                     idx_end   = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),left);
%                     idx_end   = subCell_start_idx(k) + idx_end - 2*length(left);

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
                        [ idx_start, idx_end ] = getCol_start_end_idx( subCell_start_idx(k), subCell_end_idx(k), subCell);
%                         idx_start = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),right);
%                         idx_start = subCell_start_idx(k) + idx_start;
%                         idx_end   = strfind(subCell(subCell_start_idx(k):subCell_end_idx(k)),left);
%                         idx_end   = subCell_start_idx(k) + idx_end - 2*length(left);
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

end

