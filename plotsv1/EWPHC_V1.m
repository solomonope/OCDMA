%This code is used to compute equation (27), (28), (29), (30), (31) and (32) of my FYP report
%and as it stands, it generates Fig 16 and 17 by changing parameters on line
%11,12 and 13

%where w is code weight, p is prime number which is equal to wavelength,
%and n is code length. 

function EWPHC_V1

clear all
clc
warning off

Pb1=EWHPC_BER(5,19,1511);
Pb2=EWHPC_BER(11,19,1511);
Pb3=EWHPC_BER(23,19,1511);


end


function [ Pb ] = EWHPC_BER(w,p,n)


L = w*p;
F = 1-((w-1)/((w^2)+w));
q = 0.5 * (w/n) * (w/L) * F; 

sigma_syn = (1 - q) * q; 
sigma_asyn = ((2*q)/3) - q^2;


% -- Bit Error Probability (BER) -- %
%-----------------------------------%


    KA=1:10:500;
    ind = 0;
    for K=KA
                
            BER = normcdf ( (-w) / ( sqrt( 4 * ( K - 1) * (sigma_syn)) ),0,1);
       
        ind = ind + 1;
        Pb(ind) = BER;
    end

    semilogy(KA,(Pb)); 
    hold on;
    
    
    
    ind = 0;
    for K=KA
                
            BER = normcdf ( (-w) / ( sqrt( 4 * ( K - 1) * (sigma_asyn)) ),0,1);
       
        ind = ind + 1;
        Pb(ind) = BER;
    end

    semilogy(KA,(Pb),'r'); 
    hold on;
    
     % BER Floor %
    
    Thr = ones(1,max(KA)) .* 1E-9;
    plot(Thr, 'r-.');
    hold on;

    
end


