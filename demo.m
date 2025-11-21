clear
% clc
close all
%%[result] = main_PML(dataname,avg.cls,par_num);

% see params_settings
% 1.Mirflickr(3.35)      % 2.Music_emotion(5.29)  % 3.music_style(6.04)   
% 4.YeastBP(5.93)        % 5.YeastCC(1,39)        % 6.YeastMF(1.04)
% 7.emotions(3,4,5)      % 8.birds(3,4,5)         % 9.medical(3,5,7,9)    
% 10.image(2,3,4)        % 11.scene(3,5,7)        % 12.yeast(7,9,11)       
% 13.health(5,7,9,11)    % 14.reference(7,9,11)   % 15.corel5k(7,9,11)  

% %% real-word datasets
% [~] = main_PML('Mirflickr',3.35,1);
% [~] = main_PML('Music_emotion',5.29,2);
% [~] = main_PML('Music_style',6.04,3);
% [~] = main_PML('YeastBP',5.93,4);
% [~] = main_PML('YeastBP',1.39,5);
% [~] = main_PML('YeastBP',1.04,6);
% 
% %% synthetic datasets
[~] = main_PML('emotions',3,7);
% [~] = main_PML('emotions',4,7);
% [~] = main_PML('emotions',5,7);
% % % 
% [~] = main_PML('birds',3,8);
% [~] = main_PML('birds',4,8);
% [~] = main_PML('birds',5,8);
% %
% [~] = main_PML('medical',3,9);
% [~] = main_PML('medical',5,9);
% [~] = main_PML('medical',7,9);
% %
% [~] = main_PML('image',2,10);
% [~] = main_PML('image',3,10);
% [~] = main_PML('image',4,10);
% % %
% [~] = main_PML('scene',3,11);
% [~] = main_PML('scene',5,11);
% [~] = main_PML('scene',7,11);
% % %
% [~] = main_PML('yeast',7,12);
% [~] = main_PML('yeast',9,12);
% [~] = main_PML('yeast',11,12);
% %
% [~] = main_PML('health',5,13);
% [~] = main_PML('health',7,13);
% [~] = main_PML('health',9,13);
% %
% [~] = main_PML('reference',7,14);
% [~] = main_PML('reference',9,14);
% [~] = main_PML('reference',11,14);
% %
% [~] = main_PML('corel5k',7,15);
% [~] = main_PML('corel5k',9,15);
% [~] = main_PML('corel5k',11,15);

