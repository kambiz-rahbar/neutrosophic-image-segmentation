function [TPrime, IPrime, FPrime] = calc_beta_enhancment(T, I, F, beta)
    %beta = 0.85;
    
    TPrimeBeta = 2*T.^2;
    TPrimeBeta(T>0.5) = 1-2*(1-T(T>0.5)).^2;
    TPrime = T;
    TPrime(I >= beta) = TPrimeBeta(I >= beta);
    
    FPrimeBeta = 2*F.^2;
    FPrimeBeta(F>0.5) = 1-2*(1-F(F>0.5)).^2;
    FPrime = F;
    FPrime(I >= beta) = FPrimeBeta(I >= beta);
    
    IPrime = calc_I(TPrime);
end

