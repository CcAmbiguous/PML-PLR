function par = params_settings(par_num)

params = [1e-1, 1e-1, 1e0 , 0.8;    %% 1.Mirflickr;
          1e-1, 1e-1, 1e-2, 0.8;    %% 2.Music_emotion;
          1e-1, 1e-1, 1e-1, 0.8;    %% 3.Music_style;
          1e-1, 1e-1, 1e-2, 0.8;    %% 4.YeastBP;
          1e-1, 1e-1, 1e-2, 0.8;    %% 5.YeastCC;
          1e-1, 1e-1, 1e-2, 0.8;    %% 6.YeastMF;
          1e-1, 1e-2, 1e0 , 0.8;    %% 7.emotions;
          1e-1, 1e-1, 1e-1, 0.9;    %% 8.birds;
          1e-1, 1e-2, 1e-1, 0.8;    %% 9.medical;
          1e-1, 1e-1, 1e-1, 0.8;    %% 10.image;
          1e-1, 1e-1, 1e0 , 0.8;    %% 11.scene;
          1e-1, 1e-2, 1e1 , 0.8;    %% 12.yeast;
          1e-1, 1e-2, 1e0 , 0.8;    %% 13.health; 
          1e-1, 1e-2, 1e0 , 0.8;    %% 14.reference; 
          1e-1, 1e-2, 1e0 , 0.8;    %% 15.corel5k; 
          ];
par = params(par_num,:);
end

