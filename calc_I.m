function [I] = calc_I(data)
    dataMean = imfilter(data, ones(3)/9);
    deltaMean = abs(data - dataMean);
    deltaMin = min(deltaMean(:));
    deltaMax = max(deltaMean(:));
    I = (deltaMean-deltaMin) / (deltaMax-deltaMin);
end