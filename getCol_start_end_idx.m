function [ idx_start, idx_end ] = getCol_start_end_idx(pCell_start, pCell_end ,pPart )

cell_start = pCell_start;
cell_end   = pCell_end;
part       = pPart; 

right = '>';            left = '<';

idx_start = strfind(part(cell_start:cell_end),right);
idx_start = cell_start + idx_start;
idx_end   = strfind(part(idx_start:cell_end),left) - 2*length(left);
idx_end   = idx_start + idx_end(1);

end

