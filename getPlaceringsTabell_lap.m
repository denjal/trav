function [ placeringsTabell ] = getPlaceringsTabell_lap( pSource )

source = pSource;

placeringTabell_start = strfind(source,'<table cellspacing="0" cellpadding="0" class="green">');
placeringTabell_end   = strfind(source(placeringTabell_start:end),'</table>');
placeringTabell_end   = placeringTabell_start + placeringTabell_end(1) + 6;

% testFirst_plac_start = source(placeringTabell_start);
% testFirst_plac_end   = source(placeringTabell_end);

placeringsTabell = source(placeringTabell_start:placeringTabell_end);

end

