function [result] = main_PML(dataname,avg_cls,ttt)
% Initialization
% Fixed seed
rng('default')
addpath(genpath('datasets')); % Add path
addpath(genpath('functions'));
addpath(genpath('metrics'));

% Import data set
[pLabels,data,target] = addnoise(dataname,avg_cls);
par = params_settings(ttt);
%%
opt.alpha = par(1);
opt.beta = par(2);
opt.lambda = par(3);
opt.ratio = par(4);
opt.max_iter = 40;
%%
[N,~] = size(data);
indices = crossvalind('Kfold', 1:N ,10);  % Dividing the data set
result = {};
%% Ten fold cross verification
disp(dataname);
for round = 1:10
    ht = round*10;
    fprintf('%.1f%%\n',ht)
    test_idxs = (indices == round);                       
    train_idxs = ~test_idxs;                       
    train_data = data(train_idxs,:);                                           
    train_target = pLabels(train_idxs,:);                                                                                    
    test_data = data(test_idxs,:);                                          
    test_target = target(test_idxs,:);
                    
                      
    % pre-processing                                      
    [train_data, settings]=mapminmax(train_data');                                        
    test_data=mapminmax('apply',test_data',settings);                                          
    train_data(isnan(train_data))=0;                                           
    test_data(isnan(test_data))=0;                                                                                       
    X = train_data;
    Xt = test_data;
    Y = train_target';
    Yt = test_target';
    [phi_X,phi_Xt] = Kernel_mapping(X,Xt);    
    %% training
    model = PML_PLR(phi_X,X,Y,opt);
    %% testing  
    Wm = model.Wm;
    Y_pred = Wm'*phi_Xt;
    threshold = 0.5;%%
    Binary_labels = zeros(size(Yt,1),size(Yt,2));
    Binary_labels(Y_pred>=threshold)=1;
    Binary_labels(Y_pred<threshold)=0;

    HammingLoss(round) = Hamming_loss(Binary_labels,Yt);
    RankingLoss(round) = Ranking_loss(Y_pred,Yt);
    OneError(round) = One_error(Binary_labels,Yt);
    Coverage(round) = coverage(Y_pred,Yt);
    AveragePrecision(round) = Average_precision(Y_pred,Yt);
end
result = {HammingLoss,RankingLoss,OneError,Coverage,AveragePrecision};
fprintf('%s,avg_cls=%.1f,alpha=%.5f,beta=%.5f,lambda=%.5f\n HammingLoss=%.3f±%.3f\n RankingLoss=%.3f±%.3f\n OneError=%.3f±%.3f\n Coverage=%.3f±%.3f\n AveragePrecision=%.3f±%.3f\n', ...
    dataname,avg_cls,opt.alpha,opt.beta,opt.lambda,mean(HammingLoss),std(HammingLoss),mean(RankingLoss),std(RankingLoss),mean(OneError),std(OneError),mean(Coverage),std(Coverage),mean(AveragePrecision),std(AveragePrecision));
clear X Y Xt Yt phi_X phi_Xt ht W data target train_data test_data train_target test_target indices N settings test_idxs Binary_labels pLabels round Y_pred train_idxs
filename = strcat('results/',dataname,'_avg_',num2str(avg_cls),'_predict.mat');
save(filename);
result = {HammingLoss,RankingLoss,OneError,Coverage,AveragePrecision};
end