
 

function syn_Vs_asyn_hard_limiting_2D_PC

clear all
clc
warning off

Pb2=TWOD_PC_BER(41,3);
Pb3=TWOD_PC_BER(41,5);

%Pb4=OOC_BER(11,181,19,1);

end

function [ Pb ] = TWOD_PC_BER(n,w )

m=5;
p=m;


%q(i,j) denotes the probability of getting j hits in a time slot out of the
%maximum cross correlation value of i
if (mod(w,2)==0)
    %Even
    
%     car = ((n-1)/(w-1));
%     
%     q01 = ((w^2 * ((car * p) - 1)) - (w * ((w-1)^2))     ) / ( 2*n * ( (car * p^2) - 1) );
%     qi1 = ((w^2 * ((car * p) - 1)) + (w * (w-1) * (2-w)) ) / ( 2*n * ( (car * p^2) - 1) );
%     q02 = (w*((w-1)^2)) / (4*n*((car * p^2) - 1));

else
    %Odd 
    
    car = ((n-1)/w);

    q01 = ((w^2 * ((car * p) - 1)) - (w * (w-1) * (w-2)) ) / ( 2*n * ( (car * p^2) - 1) );
    qi1 = ((w^2 * ((car * p) - 1)) + (w * (w-1) * (3-w)) ) / ( 2*n * ( (car * p^2) - 1) );
    q02 = ( w*(w-1)*(w-2) )                                / ( 4*n * ( (car * p^2) - 1) );
end

qi2=q02;

%overall_Car = Car * (p^2 - p); 

q1 = (( 1 / p ) * q01) + (( (p - 1) / p ) * qi1);
q2 = (( 1 / p ) * q02) + (( (p - 1) / p ) * qi2);
q0 = 1 - q1 - q2;



% -- Error Probability (BER) -- %
%-------------------------------%
     KA=w+1:1:40;
    ind = 0;
    for K=KA
        Th=w; 
        sum=0;
        for j=Th:w
            sig=0;
            for i=0:j
                sig1 = ((-1)^(j-i)) * nchoosek(j,i);
                sig2 = q0 + (q1 * (w-i) / w) + ( q2*(w-i)*(w-i-1)/(w*(w-1)) );
                sig = sig + ( sig1 * (sig2^(K-1)) );
            end
            sum = sum + ( 0.5 *  nchoosek(w,j) * sig );
        end
        ind = ind + 1;
        Pb(ind) = sum;
    end
   
    semilogy(KA, abs(Pb)); 
    hold on;
    
    % BER Floor %
    
    %Thr = ones(1,max(KA)) .* 1E-9;
    %plot(Thr, 'r-.');
    hold on;
    

% -- Asynchronous Hard Limiting Error Probability (BER) -- %
% 
% ----(31,3,1,2)

    if (n==31)
        q10 = 0.0279; 
        q01 = q10;

        q12 = 9.068e-006; 
        q21 = q12;

        q02 = 2.689e-003;
        q20 = q02;

        q00 = 0.9421;

        q11 = 0.0015;

        q22 = 2.591e-006; 
    end
    
    
% ----(41,5,1,2)    
    if (n==41)
        q10 = 0.0279; 
        q01 = q10;

        q12 = 9.068e-004; 
        q21 = q12;

        q02 = 2.689e-004;
        q20 = q02;

        q00 = 0.9421;

        q11 = 0.0015;

        q22 = 2.591e-006; 
    end  

    Th=w; 
    ind = 0;
    for K=KA
        sum3=0;
        for ks=Th:w
            sum2=0;
            for j=0:w-ks    
                sum1=0;
                for i = 0: (2*ks + j)
                    
                    sig3 = 0;
                    sig4 = 0;
                    sig5 = 0;
                    sig6 = 0;
                    
                    sig1 = ((-1)^((2*ks)+j-i)) * nchoosek(((2*ks) + j),i);
                    sig2 = q00;
                    if (i>=1)
                        sig3 = (q01 + q10) * nchoosek(i,1) / nchoosek((2*w),1);
                    end
                    if (i>=2)
                        sig4 = (q02 + q20 + q11) * nchoosek(i,2) / nchoosek((2*w),2);
                    end
                    if (i>=3)
                        sig5 = (q12 + q21) * nchoosek(i,3) / nchoosek((2*w),3);
                    end
                    if (i>=4)
                        sig6 = q22 * nchoosek(i,4) / nchoosek((2*w),4);
                    end
                    sum1 = sum1 + ( sig1 * (( sig2+sig3+sig4+sig5+sig6 ) ^ (K-1))  );
                       
                end
                
               sum2 = sum2 + ( nchoosek((w-ks),j) * (2^j) * sum1);
               
            end
            
            sum3 = sum3 + ( 0.5 *  nchoosek(w,ks) * sum2 );
            
        end
        ind = ind + 1;
        Pb(ind) = sum3;
    end

    semilogy(KA, abs(Pb),'r'); 
    hold on
    



end

