function model = PML_PLR(phi_X,X,Y,opt)
warning('off');
rng('default')

alpha = opt.alpha;
beta = opt.beta;
lambda = opt.lambda;
ratio = opt.ratio;
max_iter = opt.max_iter;

model = [];

[h,n]=size(phi_X);
[d,~]=size(X);
[l,~]=size(Y);
m = ceil(l*ratio);
%% Training
Wm = randn(h,l);
P = rand(m,l);                Q = randn(n);                 
[U1,~,V1] = svd(P,'econ');    [U2,~,V2] = svd(Q);
P = U1*(V1');                 Q = U2*(V2');
C = eye(n);
H = randn(m,n);
F = Y;
E = zeros(l,n);
mu = 1e3;
Lip = 1;
G = pdist2(X', X', 'squaredeuclidean');
[Lk]= knn_S(X', 5);% Laplacian matrix of K, 5 represents the number of nearest neighbors of the sample
miniLossMargin = 1e-4;
loss(1) = norm(Wm'*phi_X-F,'fro')^2+norm(Y*Q-F,'fro')^2+norm(Y-P'*H*C,'fro')^2+trace(G*C')+alpha*sum(sum(abs(Y-P'*H)))+2*beta*trace(F*Lk*C*F')+lambda*norm(Wm,'fro')^2;
for ii = 1:max_iter
 
    %% update W
    Wm = pinv(phi_X*phi_X' + lambda*eye(h))*(phi_X*F');

    %% update Q
    [M,~,N] = svd(Y'*F,"econ");
    Q = M*(N');
    clear M N

    %% update P
    R = 2*Y*(C')*(H') + mu*(Y-E)*(H');
    [U,~,V] = svd(R,"econ");
    P = V*(U');
    clear U V   
    
    %% update H
    H = (2*P*Y*C'-mu*P*(Y-E))*pinv(2*C*(C')-mu*eye(n));


    %% update C
    O = pinv(2*H'*P*P'*H)*(2*H'*P*Y+2*beta*F'*F*Lk-G);
    for j=1:1:n
        C(:,j)=EProjSimplex_new(O(:,j));
    end

 
    %% update E
    Ge = P'*H + E -Y;
    temp_E = E - 1/Lip.*Ge;
    E= softthres(temp_E,alpha/(mu*Lip));

   
    %% update F
    seita = max(F-Y,0);
    FA = 2*F + beta*F*C'*Lk + beta*F*Lk'*C+eps;
    FB = Wm'*phi_X + Y*Q;
    FC = seita.*Y;
    F = F.*(FB)./(FA)-FC./FA;

    loss(ii+1) = norm(Wm'*phi_X-F,'fro')^2+norm(Y*Q-F,'fro')^2+norm(Y-P'*H*C,'fro')^2+trace(G*C')+alpha*sum(sum(abs(Y-P'*H)))+beta*trace(F*Lk*C*F')+lambda*trace(Wm'*Wm);;
    if ii>5
        temp_loss = (loss(ii) - loss(ii+1))/loss(ii); 
        if temp_loss<miniLossMargin
            ccc = 1;
            break;%
        end
    end
    

end
model.Wm = Wm;
model.F = F;
model.C = C;
model.loss = loss;
end



function W = softthres(W_t,lambda)
    W = sign(W_t).*max(W_t-lambda, 0);  
end