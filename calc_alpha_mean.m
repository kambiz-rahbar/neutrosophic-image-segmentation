function [TMean, IMean, FMean] = calc_alpha_mean(T, I, F, alpha)
    %alpha = 0.85;
    
    TMean = imfilter(T,ones(3)/9);
    TMean(I < alpha) = T(I < alpha);
    
    FMean = imfilter(F,ones(3)/9);
    FMean(I < alpha) = F(I < alpha);
    
    IMean = calc_I(TMean);
end
