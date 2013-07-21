function [] =  BERSNR()

ind = 0;
P = 7;
%
KA = 10 :5: 60;
BERA = 0;
EN = 0;
for K = KA
    ind = ind+1;

    x = -P / sqrt(K-1);
    %Eb/No(dB) = SNR(dB) – 10*LOG10(BitRate/BW)
    %EN(ind) =   pow2db(abs (x)) - pow2db((2000000/(299792458/880e-12)))  ;
    
    EN(ind) =   pow2db(abs (x)) - pow2db((2000000/(299792458/880e-12)))  ;
    
    BERA(ind) =   normcdf(x,0,1)   ;
    
    
    
    
    
end
%semilogy(SNR(end:-1:1),BERA(end:-1:1));
semilogy(EN,BERA);
end