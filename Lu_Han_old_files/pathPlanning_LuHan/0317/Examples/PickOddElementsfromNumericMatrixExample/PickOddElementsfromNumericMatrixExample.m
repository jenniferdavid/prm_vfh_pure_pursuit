%% Pick Odd Elements from Numeric Matrix  
% Pick out the odd-numbered elements of a numeric matrix.   

%% 
% Create a numeric matrix. 
A = [1 -3 2;5 4 7;-8 1 3];  

%% 
% Find the modulus, |mod(A,2)|, and convert it to a logical array for
% indexing.
L = logical(mod(A,2)) 

%%
% The array has logical |1| (|true|) values where |A| is odd.  

%% 
% Use |L| as a logical index to pick out the odd elements of |A|. 
A(L) 

%%
% The result is a vector containing all odd elements of |A|.  

%% 
% Use the logical NOT operator, |~|, on |L| to find the even elements of
% |A|.
A(~L)   

