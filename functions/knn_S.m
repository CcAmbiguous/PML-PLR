function [L]= knn_S(train_data, k)
% knn_S for Local similar Laplacian matrix
    [num_train, ~]=size(train_data);
    distance = pdist2(train_data, train_data, 'squaredeuclidean');
    [near_sample , ind] = sort(distance,2);
    ind = ind(:,2:k+1);
    segma = sum(near_sample(:,2))/num_train;
    P = exp(-distance/(2*segma^2));
    
    R = eye(num_train);
    for i=1:num_train
        for j = 1:k
            R(i,ind(i,j)) = P(i,ind(i,j));
        end
    end
    R = 1/2*(R'+R);
    D = diag(sum(R,2));
    L = D-R ;
end
