
function [Hn, A ] = my_homography( X1, X2, flag )

if nargin == 2
    flag = false;
end

if flag == true 
    [X1, T1] = normalise2dpts(X1);
    [X2, T2] = normalise2dpts(X2);
else
    T1 = eye(3);
    T2 = eye(3);
end

A = zeros(size(X1,2)*2, 9);

j = 1;
for ii=1:size(X1,2)

    tmp1 = -X2(3,ii).*X1(:,ii); %wi*x
    tmp2 = X2(2,ii).*X1(:,ii);  %yi*x
    tmp3 = -tmp1;
    tmp4 = -X2(1,ii).*X1(:,ii); %xi*x
    
    
    A(j,4:6) = tmp1';
    A(j,7:9)= tmp2';
    j = j+1;
    A(j,1:3) = tmp3'; 
    A(j,7:9) = tmp4';
    j = j+1;
    
end

    [~,~,V] = svd(A,0);
    H = reshape(V(:,9),3,3);
    H = H';
    Hn =  inv(T2)* (H) * T1;
   
end



