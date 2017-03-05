function [ headers ] = getHeaders_placTabell_lap( pPlaceringsTabell )

placeringsTabell = pPlaceringsTabell;

tr_long   = '<tr class="header">';
s_tr      = '</tr>';

header_start = strfind(placeringsTabell,tr_long);
header_end   = strfind(placeringsTabell(header_start:end),s_tr);
header_end   = header_start + header_end(1) + 3;

% testHeader_start = placeringsTabell(header_start);
% testHeader_end   = placeringsTabell(header_end);

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

end

