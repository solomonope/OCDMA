%Author:     Folorunsho Solomon Opeyemi(1148183)
%Company:    The University Of Birmingham
%Project:
%CodeFileName:UsersAndPrimeNumbers.m    
%Description:This file contains all System parameters to the used by
function UsersAndPrimeNumbers()

PrimeNumbers = 0:5:35;

ArrayLength = length(PrimeNumbers);
NumberOfUsersArray = zeros(1,ArrayLength);
for i = 1:1:ArrayLength
  NumberOfUsersArray(i) = GetNumberOfUsers( PrimeNumbers(i) );
end;

%Plot

plot(PrimeNumbers,NumberOfUsersArray );
xlabel('Prime Number');
ylabel('Number of Users');
title('PrimeNumber vs NumberofUsers');
end


function [NumberOfUsers] =  GetNumberOfUsers(PrimeNumber)

if(length(PrimeNumber) > 1)
    NumberOfUsers = 0;
else
    NumberOfUsers = PrimeNumber;
end
 

end