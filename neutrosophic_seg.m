function [segT, T, I, F] = neutrosophic_seg(Img, dispRes, m, alpha, beta, gamma, maxItr)
    
    %% check function parameters
    if ~exist('dispRes','var')
        dispRes = 0;
    end
    if ~exist('m','var')
        m = 10;
    end
    if ~exist('alpha','var')
        alpha = 0.85;
    end
    if ~exist('beta','var')
        beta = 0.85;
    end
    if ~exist('gamma','var')
        gamma = 1e-5;
    end
    if ~exist('maxItr','var')
        maxItr = 500;
    end
    
    %% convert the image's color palette to gray level if necessary and add image margin
    if size(Img, 3)>1
        Img = rgb2gray(Img);
    end
    
    % add a margin to image for filter side effects. At the end it will removed from results.
    g = ones(size(Img)+2*m);
    g(1+m:end-m,1+m:end-m) = double(Img)/255;
    
    %% transform into NS domain, calc T, I, F
    gMean = imfilter(g,ones(3)/9);
    gMin = min(gMean(:));
    gMax = max(gMean(:));
    T = (gMean - gMin) / (gMax - gMin);
    
    I = calc_I(g);
    
    F = 1 - T;
    
    %% enrich T
    NS_Ent = entropy(T) + entropy(I) + entropy(F);
    % gamma = 1e-5;
    % maxItr = 500;
    EntTrack = zeros(1,maxItr);
    for k = 1:maxItr
        [T, I, F] = calc_alpha_mean(T, I, F, alpha);
        [T, I, F] = calc_beta_enhancment(T, I, F, beta);
    
        NS_Ent_new = entropy(T) + entropy(I) + entropy(F);
        EntTrack(k) = NS_Ent_new;
    
        c = abs(NS_Ent_new - NS_Ent) / NS_Ent;
        if  c < gamma
            EntTrack(k:end) = [];
            break;
        end
    end
    
    %% segment and compare
    
    % remove margins
    g = g(1+m:end-m, 1+m:end-m);
    T = T(1+m:end-m, 1+m:end-m);
    I = I(1+m:end-m, 1+m:end-m);
    F = F(1+m:end-m, 1+m:end-m);
    
    segT = segment_Img(T);
    
    if dispRes
        segg = segment_Img(g);

        figure(dispRes)
        subplot(2,3,1); imshow(g); title('g');
        subplot(2,3,2); imshow(segg); title('seg_g');
        subplot(2,3,3); imshow(T); title('T');
        subplot(2,3,4); imshow(I); title('I');
        subplot(2,3,5); imshow(segT); title('seg_T');
        subplot(2,3,6); plot(EntTrack); xlabel('itr'); ylabel('Ent'); title('Ent Track');
    end
end
