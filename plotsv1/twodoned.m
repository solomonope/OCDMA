%This code is used to compute equation (9) and (10) of my FYP report
%and as it stands, it generates Fig 5 and 6 by changing parameters on line
%21,22, and 23 ..  
 
clear all
clc
warning off

A = [1e-7,1e-4,1e-3,1e-2,1e-1];
B = [1e-5,1e-3,1e-2,1e-1,1e-1];
C = [1e-7,1e-4,1e-3,1e-2,1e-1];
D= [1e-7,1e-4,1e-3,1e-2,1e-1];
X = [5,10,15,20,25];
%2-D WHTS Parameters (M xN, w, ?a, ?c)  (where M is the number of available
%wavelengths, N is the code length, w is the code weight, and  ?a & ?c
%represent both auto and cross correlation

%&

%1-D WDM codes (L, W,?a, ?c) where L is code length, W is weight and ?a & ?c
%represent both auto and cross correlation

%2-D Parameters
M=16;
N=676;
w=7;

%OOC/WHTS
phi = ((M*(M*N)-1)/(w*(w-1)));

%1-D Parameters
L=N; 
W=w;
mu=w;




%Code Cardinality 
C1=(M*(N-1))/(w*(w-1));
C2=(M*(M-1))/(w*(w-1));
 

 
%Defining "q" (Average number of interference between C1 and C2)
T1=(N-1)/(w*(w-1));
T2=((M)-1)/(w*(w-1));

q1=((((w^2)/(2*N))*((M*T1)+T2))-(w/(2*N)))/(phi-1);
q2=(((w^2)/(2*N))*((M*T1)-1))/(phi-1);

q=((C1/phi)*q1)+((C2/phi*q2));



%BER Calculation for 2-D WHTS OCDMA (mu is decision threshold, F is number of users)

ind=0;
FArray=1:10:400;
for F=FArray
    BER=0; 
    for i=mu : F-1
       BER = BER+0.5*(nchoosek((F-1), i) * (q^i) * ((1-q)^(F-1-i)));  
    end
    ind=ind+1; 
    BER2DArray(ind)=BER;
end


%1-D WDM OCDMA



%BER Calculation for 1-D WDM OCDMA (K is total number of users, K/M is
%number of optical codes in each wavelength, mu is decision threshold, and p is
%total probaility of interference

ind_1=0;
phi_1D = round(M*((L-1)/(W*(W-1))))

% Total probability of interference
p = ((W^2)/(2*L)); 

for K = 1:1:phi_1D;
    BER_1=0;
    U= K/M;
    if (mod(U,1)==0)
        for i=mu : U - 1
        BER_1=BER_1+0.5* ( nchoosek(U - 1,i) * (p^i) * ((1-p)^(U - 1 -i)) );
        end
    ind_1=ind_1+1;  
    KArray(ind_1) = K; 
    BER1DArray(ind_1)=BER_1;
    end
end


%Graph

semilogy(KArray,BER1DArray,'-s green');

%semilogy(X,A,'-s green');
xlabel('Number of Simultaneous Users');
ylabel('Bit ErrorRate(BER)');



