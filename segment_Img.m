% New neutrosophic approach to image segmentation, Pattern Recognition, 42 (2009) 587-595
% Implemented by kambiz rahbar, 2022.

function [Img] = segment_Img(Img)
    idx = kmeans(Img(:),2);
    idx = reshape(idx, size(Img));
    
    [r,c] = size(Img);
    subImg = Img(floor(r/4:3*r/4),floor(c/4:3*c/4));
    subIdx = idx(floor(r/4:3*r/4),floor(c/4:3*c/4));
    if sum(subImg(subIdx==1)) >= sum(subImg(subIdx==2))
        Img(idx==1) = false;
        Img(idx==2) = true;
    else
        Img(idx==2) = false;
        Img(idx==1) = true;
    end
end
