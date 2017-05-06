clc;  
clear all;  
close all;  
  
%distance matrix for: London, Cardiff, Birmingham, Manchester, York, and  
%Glasgow.  
d=[0,411,213,219,296,397;...  
    411,0,204,203,120,152;...  
    213,204,0,73,136,245;...  
    219,203,73,0,90,191;...  
    296,120,136,90,0,109;...  
    397,152,245,191,109,0];  
  
n=size(d,1);  
t=zeros(n,n);  
for i=1:n  
    for j=1:n  
        t(i,j)=-0.5*(d(i,j)^2 -1/n*d(i,:)*d(i,:)' -1/n*d(:,j)'*d(:,j) +1/n^2*sum(sum(d.^2)));  
    end  
end  
[V,D] = eig(t)  
X=V(:,1:2)*D(1:2,1:2).^(1/2);  
scatter(-X(:,2),X(:,1));  
axis([-300,300,-300,300]); 
