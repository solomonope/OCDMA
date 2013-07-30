function [] = Code_Convolution()
 A =[1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0];
 B =[0,0,1, 0,0,1, 0,0,1, 0,0,1, 0,0,1];
 
 %A = [1,0,0,0,0 ,1,0,0,0,0  ,1,0,0,0,0  ,1,0,0,0,0  ,1,0,0,0,0];
 %B = [1,0,0,0,0 ,0,1,0,0,0  ,0,0,1,0,0  ,0,0,0,1,0  ,0,0,0,0,1];
 CC = [];
 
 SCC = 0;
ind = 0;
temp = 0;

y=xcorr(A,B);
plot(y)
xlabel('Period T[n]');
ylabel('CC');

for K =1:1:15
    
    temp =  A(K) * B(K);
    SCC =  SCC +temp;
    
end

end
