%Author:     Folorunsho Solomon Opeyemi(1148183)
%Company:    The University Of Birmingham
%Project:
%CodeFileName:SAOCDMASNR.m    
%Description:This file contains all System parameters to the used by

function [] =  SAOCDMASNR()
%ylim([1e-10 , 1e0]);
%Global Parameters

dv = 2.5e12;

B = 80e6;


%MFH Parameters
 MFH_q = 16;
 
 
 %MQC Parameters
 MQC_P =  13;
 
 %BIBD Parameters
 BIBD_m = 3;
 BIBD_q = 16;
 
 KA = 0:50:250;
 
 BERA_MFH = 0;
 
 BERA_MQC = 0;
 
 BERA_BIBD = 0;
 BERA_HDM = 0;
 ind = 0;
 for K = KA
     ind = ind+1;
     
     %MFH
     SNR_MFH =  MFHBSNR(dv,MFH_q,B,K);
     BERA_MFH(ind) = BERSNR(SNR_MFH);
     
     %MCQ
     SNR_MQC =  MQCSNR(dv,MQC_P,B,K);
     BERA_MQC(ind) = BERSNR(SNR_MQC);
     
     %BIBD
                        %(dv,q,B, K,m)
     SNR_BIBD =  BIBDSNR(dv,BIBD_q,B,K,BIBD_m);
     BERA_BIBD(ind) = BERSNR(SNR_BIBD );
     
     
    SNR_HDM = HDMSNR(dv,B,256);
    BERA_HDM(ind) = BERSNR(SNR_HDM);
    
 end
clf;
 semilogy(KA, BERA_MFH,'r');
 hold on ;
 
 semilogy(KA,BERA_MQC,'g-.');
 hold on
 
 semilogy(KA,BERA_BIBD,'b-.');
 
 
 %semilogy(KA,BERA_HDM,'b-.');
 grid on; 

end

%function to calculate the SNR of modified frequency hopping
%dv     = 
%q      = 
%B      =
%K      =

function [SNR] =  MFHBSNR(dv,q,B, K)

%dv(q+1)
NumeratorA = dv*(q+1);


%B*K ( ( (K-1)/q ) +q + K) )
DenominatorA = B*K *( ( (K-1)/q ) +q + K ) ;



%2*q*dv
NumeratorB = 2*q*dv;


%B*K( (K/2) + q -1)
DenominatorB = B*K*( (K/2) + q -1);

SNR = NumeratorA / DenominatorA;

%SNR = NumeratorB / DenominatorB;



end

function[SNR]  =  MQCSNR(dv,P,B, K)

%dv(P+1)
Numerator = dv*(P+1);

%B*K ( ( (K-1)/q ) +q + K) )
Denominator = B*K *( ( (K-1)/P ) +P + K ) ;



NumeratorA = 2 *dv* P;


DenominatorA = B*K *( (K/2) + P - 1 );

SNR = Numerator /Denominator;

%SNR = NumeratorA/ DenominatorA;

end


function [SNR] = BIBDSNR(dv,q,B, K,m)

 Numerator = 2 * q * dv;
 
 Denominator =  B * K *( (K/2) +q-1);
 
 SNRX = Numerator/ Denominator;
 
 
 
 NumeratorA = dv;
 
 
 A = 1+ ((K-1)*(q.^(m-1) - 1));
 BC = A/(q.^(m-1) - 1);
 
 D = B*K* BC;
  
 SNRx = abs ( NumeratorA /D );
 
 
 W = (power(q, m) - 1 ) / (q-1);
 
 cc = (power(q, (m-1)) -1 ) / (q-1);
 
 NUMR = dv *(W - cc);
 
 DMR = B*K*cc*(K + ((W-2 *cc) / cc) );
 
 SNR = NUMR/ DMR;
end


function[SNR] = HDMSNR(dv,B,N)

A = 4 *dv;

BC = B* power((N-1),2 );

SNR =   A/BC;
end

function[SNR]   = MDWSNR(dv,B,K,W)

A = 12 *dv;

BC = B * ( K +W);

SNR = A/BC;

end
function [BER] = BERSNR(SNR)


BER = 0.5 * erfc( sqrt((SNR/8) ) );


end