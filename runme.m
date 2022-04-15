% New neutrosophic approach to image segmentation, Pattern Recognition, 42 (2009) 587-595
% Implemented by kambiz rahbar, 2022.

clc;
clear;
close all;

sample_Imgs = {'cameraman.tif','PeppersSectionExample.png','peppers.png'};

for k = 1:length(sample_Imgs)
    Img = imread(sample_Imgs{k});
    Seg_Img = neutrosophic_seg(Img, k);
end

