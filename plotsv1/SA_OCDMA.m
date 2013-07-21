%Author:     Folorunsho Solomon Opeyemi(1148183)
%Company:    The University Of Birmingham
%Project:
%CodeFileName:SA_OCDMA.m    
%Description:This file contains all System parameters to the used by
function [] = SA_OCDMA()

dv = 2.5e12;

B = 80e6;


%MFH Parameters
 MFH_q = 16;
 
 %MQC Parameters
 MQC_P =  13;
 
 
 %BIBD Parameters
 BIBD_m = 3;
 BIBD_q = 16;
 
 
 
 BERA_MFH = 0;
 BERA_MQC = 0;
 BERA_BIBD = 0;
 BERA_HDM = 0;
 BERA_MDW = 0;
 
 
 
 SNRA_MFH = 0;
 SNRA_MQC = 0;
 SNRA_BIBD = 0;
 SNRA_HDM = 0;
 SNRA_MDW = 0;
 ind = 0;
 KA = 55:1:250;
 for K = KA
     ind = ind+1;
     
     %MFH
                %MFHBSNR(dv,q,B, K)
     SNR_MFH =  MFHBSNR(dv,MFH_q,B,K);
     BERA_MFH(ind) = Compute_BER(SNR_MFH);
     %SNRA_MFH(ind) = SNR_MFH;
     
     %MCQ
                %MQCSNR(dv,q,B, K)
     SNR_MQC =  MQCSNR(dv,MQC_P,B,K);
     BERA_MQC(ind) = Compute_BER(SNR_MQC);
     %SNRA_MQC(ind) =  SNR_MQC;
     
     %BIBD
                        %(dv,q,B, K,m)
     SNR_BIBD =  BIBDSNR(dv,BIBD_q,B,K,BIBD_m);
     BERA_BIBD(ind) = Compute_BER(SNR_BIBD );
     %SNRA_BIBD(ind) = SNR_BIBD;
     %HDM
     SNR_HDM = HDMSNR(dv,B,256,K);
     BERA_HDM(ind) = Compute_BER(SNR_HDM);
     %SNRA_HDM(ind) = SNR_HDM;
    
    %WDM
     SNR_MDW = MDWSNR(dv,B,K);
     BERA_MDW(ind) = Compute_BER(SNR_MDW);
     %SNRA_MDW(ind) = SNR_MDW;
 end
 
 clf;
 semilogy(KA, BERA_MFH,'r');
 
 hold on ;
 
semilogy(KA, BERA_MQC,'g.');
hold on ;
 
 
 semilogy(KA, BERA_BIBD,'b.');
 hold on ;
 
 semilogy(KA, BERA_HDM,'y.');
 hold on ;
 
 semilogy(KA, BERA_MDW,'c.');
 
 xlabel('Number of Simultaneous Users');
 ylabel('Bit ErrorRate(BER)');
 legend('r MFH','g MQC','b BIBD','y HDM','c MDW');
 hold on ;
 grid on;
end


function[SNR] = Compute_SNR(DV,B,K,W,CC)

  NUMR = DV *(W - CC);
 
 DMR = B*K*CC*(K + ((W-2 *CC) / CC) );
 
 SNR = NUMR/ DMR;
end


function [BER] = Compute_BER(SNR)


BER = 0.5 * erfc( sqrt((SNR/8) ) );


end

function [SNR] =  MFHBSNR(dv,q,B, K)

W = q+1;

CC = 1;

SNR = Compute_SNR(dv,B,K,W,CC);

end

function[SNR]  =  MQCSNR(dv,P,B, K)

W = P+ 1;

CC = 1;


SNR = Compute_SNR(dv,B,K,W,CC);
end

function [SNR] = BIBDSNR(dv,q,B, K,m)

W = (power(q, m) - 1 ) / (q-1);
CC= (power(q, (m-1)) -1 ) / (q-1);

SNR = Compute_SNR(dv,B,K,W,CC);
end

function[SNR] = HDMSNR(dv,B,N,K)

W = N/2;%power(2,N-1);
CC= N/4;%power(2,N-1);

SNR = Compute_SNR(dv,B,K,W,CC);

end


function[SNR] =  MDWSNR(dv,B,K)
W = 4;
CC= 1;

SNR = Compute_SNR(dv,B,K,W,CC);
end