function [XKTrain, XKTest] = Kernel_mapping(XTr, XTe)

    dim = size(XTr,1);
    ntr = size(XTr,2);
    nte = size(XTe,2);
    nAnchors = 5*dim;
    if nAnchors>ntr
        nAnchors = ntr;
    end

    % rand
    anchor_idx = randsample(ntr, nAnchors);
    Anchors = XTr(:,anchor_idx);
    % kmeans select
    % [~, XAnchors] = litekmeans(XTrain, param.nXanchors, 'MaxIter', 30);
    % [~, YAnchors] = litekmeans(YTrain, param.nYanchors, 'MaxIter', 30);


    % train datea kernel
    XKTrain = sqdist(XTr,Anchors);
    Xsigma = mean(mean(XKTrain,2));
    XKTrain = exp(-XKTrain/(2*Xsigma));
    % mean
    Xmvec = mean(XKTrain);
    tmp = repmat(Xmvec,ntr,1);
    XKTrain = (XKTrain-tmp)';
    % test datea kernel
    XKTest = sqdist(XTe,Anchors);
    XKTest = exp(-XKTest/(2*Xsigma));
    XKTest = (XKTest-repmat(Xmvec,nte,1))';
    %% add bias b
    XKTrain = [XKTrain;ones(1,ntr)];
    XKTest = [XKTest;ones(1,nte)];
end
function d=sqdist(a,b)
    % SQDIST - computes squared Euclidean distance matrix
    %          computes a rectangular matrix of pairwise distances
    % between points in A (given in columns) and points in B
    
    % NB: very fast implementation taken from Roland Bunschoten
    
    aa = sum(a.^2,1); bb = sum(b.^2,1); ab = a'*b; 
    d = (repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);
end