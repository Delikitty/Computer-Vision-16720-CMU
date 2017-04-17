function [filterBank] = createFilterBank() 
% Code to generate reasonable filter bank

    gaussianScales = [1 2 4 8 sqrt(2)*8];
    logScales      = [1 2 4 8 sqrt(2)*8];
    dxScales       = [1 2 4 8 sqrt(2)*8];
    dyScales       = [1 2 4 8 sqrt(2)*8];

    filterBank = cell(numel(gaussianScales) + numel(logScales) + numel(dxScales) + numel(dyScales),1);

    idx = 0;

    for scale = gaussianScales
        idx = idx + 1;
        filterBank{idx} = fspecial('gaussian', 2*ceil(scale*2.5)+1, scale);
    end

    for scale = logScales
        idx = idx + 1;
        filterBank{idx} = fspecial('log', 2*ceil(scale*2.5)+1, scale);
    end

    for scale = dxScales
        idx = idx + 1;
        f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
        f = imfilter(f, [-1 0 1], 'same');
        filterBank{idx} = f;
    end

    for scale = dyScales
        idx = idx + 1;
        f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
        f = imfilter(f, [-1 0 1]', 'same');
        filterBank{idx} = f;
    end

end
