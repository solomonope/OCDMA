%Author:     Folorunsho Solomon Opeyemi(1148183)
%Company:    The University Of Birmingham
%Project
%CodeFileName:OocBer.m    
%Description:This file contains all System parameters to the used by


%K = Code Weight
%L = Code Length
%M = Number of Interfering users
function [BER] = OocBer(K,L)

%not sure about this variable yet
PEL = 1;

% q = K^2/2*L
q = power(K,2) / (2 * L);

%initialise BER
BER = 0;
ind = 0;
MA = 1:5:25;
for M = MA
    temp2=0;
    temp1 = 0;
for i = 0:1:M
  Temp  =   nchoosek(M,i) *power(q,i)* power((1-q),(M-i));
   temp1 = temp1 + Temp;
end
 temp2 = temp2 + temp1; 
 ind = ind+1;
 BER(ind) = temp2;
end
semilogy(MA, BER)
end