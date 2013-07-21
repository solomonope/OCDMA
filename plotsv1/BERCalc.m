%Author:     Folorunsho Solomon Opeyemi(1148183)
%Company:    The University Of Birmingham
%Project:
%CodeFileName:BerCalc.m    
%Description:This file contains all System parameters to the used by


function  BERCalc()
clf;
%array index counter


ind = 0;
P = 7;
%
KA = 5 :5: 25;
BERA = 0;
for K = KA
    ind = ind+1;

    x = -P / sqrt(K-1);
    BERA(ind) =   normcdf(x,0,1)   ;

end

semilogy(KA, BERA,'r')

hold on;


ind = 0;

P = 13;
%
KA = 5 :5: 25;
BERA = 0;
for K = KA
    ind = ind+1;

    x = -P / sqrt(K-1);
    BERA(ind) =   normcdf(x,0,1)   ;

end
ylim([10^-7,10^0]);
semilogy(KA, BERA,'b')

hold on;

CA =   5:5:25;  %cardinality
N = 41 ;   % code length
W = 3 ; %code weight
 %q = W^2/2*N
q = power(W,2) / (2 * N);

 ind = 0;
 BERA = 0;
    for K=CA
        
        BER=0;
        for i = W :1: (K - 1)          
            BER1 = nchoosek(K-1,i); 
            BER2 = (q^i)*((1 - q)^(K-1-i));
            BER = BER + (0.5 * BER1 * BER2); 
        end
        ind = ind + 1;
        BERA(ind) = BER;
    end

    semilogy(CA, BERA, 'g'); 
    hold on;



CA =   5:5:25;  %cardinality
N = 151 ;   % code length
W = 4 ; %code weight
 %q = W^2/2*N
q = power(W,2) / (2 * N);

 ind = 0;
 BERA = 0;
    for K=CA
        
        BER=0;
        for i = W :1: (K - 1)          
            BER1 = nchoosek(K-1,i); 
            BER2 = (q^i)*((1 - q)^(K-1-i));
            BER = BER + (0.5 * BER1 * BER2); 
        end
        ind = ind + 1;
        BERA(ind) = BER;
    end

    semilogy(CA, BERA, 'y'); 
    
    
 xlabel('Number of Simultaneous Users');
 ylabel('Bit ErrorRate(BER)');
 legend('r Prime for P = 7','g OOC for N = 41','b Prime for P = 13','y OOC for N = 151');
 hold on ;
 grid on;
    hold on;



end