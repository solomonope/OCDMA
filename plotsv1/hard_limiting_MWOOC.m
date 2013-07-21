%This code is used to compute equation (20), (21) and (22) of my FYP report
%and as it stands, it generates Fig 10 and 11 by changing parameters on line
%19 and 20


function hard_limiting_MWOOC
%N_OOC is length of OOC which is equal to code length N, K is number of
%simultaneous users, q represent hit probabilities, p is prime number same
%as wavelength. 
 
%phi_OOC is cardinality 



clear all
clc
warning off

Pb1=MWOOC_HARD_LIMITING_BER(41,7,6);
Pb2=MWOOC_HARD_LIMITING_BER(41,9,6);



end

function [ Pb ] = MWOOC_HARD_LIMITING_BER( N,w, phi_OOC)


N_OOC = N;
Th    = w;
p     = 13;

% -- Bit Error Probability (BER) -- %
%-----------------------------------%
    
    qi = ( (w * (( phi_OOC*p) - 1)) + (w-1)^2 ) / ( 2*N_OOC * ( (phi_OOC * p^2) -1));
    q0 =  (  w^2 * ( (phi_OOC *p) - 1 )) / ( 2*N_OOC * ( (phi_OOC * p^2) -1));
    q = (( 1 / p) * q0) + ((p-1/p)*qi); 

    KA=w+1:1:40;
    ind = 0;
    for K=KA
        
        BER=0;
        for i = 0 : Th          
            BER1 = (-1)^i  *  nchoosek(w,i); 
            BER2 = (1 - (q*i/w))^(K-1);
            BER = BER + 0.5 * BER1 * BER2; 
        end
        ind = ind + 1;
        Pb(ind) = BER;
    end

    semilogy(KA, Pb); 
    hold on;
    
    
    
    

 %without - hard limiting

%-- Bit Error Probability (BER) -- %
%-----------------------------------%
    
 
    ind = 0;
    for K=KA
        
        BER=0;
        for i = Th : (K - 1)          
            BER1 = nchoosek(K-1,i); 
            BER2 = (q^i)*((1 - q)^(K-1-i));
            BER = BER + (0.5 * BER1 * BER2); 
        end
        ind = ind + 1;
        Pb(ind) = BER;
    end

    semilogy(KA, Pb, 'r'); 
    hold on;
    
    
    % BER Floor %
    
    Thr = ones(1,max(KA)) .* 1E-9;
    plot(Thr, 'r-.');
    hold on;

    
end


    
