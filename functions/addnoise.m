function [pLabels,data,target] = addnoise(dataname,avg_cls)
%用于加噪声和调用数据集
    load(dataname);
    tf1 = strcmp(dataname,'Music_emotion');
    tf2 = strcmp(dataname,'Music_style');
    tf3 = strcmp(dataname,'Mirflickr');
    tf4 = strcmp(dataname,'YeastBP');
    tf5 = strcmp(dataname,'YeastCC');
    tf6 = strcmp(dataname,'YeastMF');
    tf = tf1+tf2+tf3+tf4+tf5+tf6;
        if tf == 1
            target = target';
            pLabels = candidate_labels'; 
        else
            [pLabels, noisy_nums] = rand_avg_noisy(target,avg_cls);
        end

end