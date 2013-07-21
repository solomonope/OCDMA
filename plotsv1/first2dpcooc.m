%This code is used to compute equation (23), (24) and (25) of my FYP report
%and as it stands, it generates Fig 13 and 14 by changing parameters on line
%14, 15 and 16 where m is wavelength, n is code length, w is code weight, M
% is number of simultaneous users, Th is decision threshold which is equal
% to code weight..q is hit probability

function first2dpcooc

clear all
clc
warning off

m=19;
n=1511;

Pb1=OOCPC_BER(m,n,5);
Pb2=OOCPC_BER(m,n,11);
Pb3=OOCPC_BER(m,n,23);


end


function [ Pb ] = OOCPC_BER( m,n,w )

Th=w;

%% Cardinality (C) of PC/OOC

C = (m*( (m * n) - 1 ) )/ (w*(w - 1));

MA=w+1:10:500;

ind = 0;

for M=MA
    sum=0;
    for i=Th:M-1
        q=w^2/(2*m*n);
        sum = sum + (0.5*(nchoosek((M-1), i) * (q^i) * ((1-q).^(M-1-i))));
    end
    ind = ind + 1;
    Pb(ind) = sum;
end

hold on;

plot (MA,log10(Pb) );

% BER Floor %

Thr = ones(1,max(MA)) .* 1E-9;
plot(log10(Thr), 'r-.');
hold on;

end
