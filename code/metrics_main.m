%% metrics_main.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% =============== Metrics Script ================= %%% 
%%% ================================================ %%%

clc;
close all;
clear all;
addpath(genpath('misc/mc_data'));
addpath(genpath('misc'));

%% load  
fold = 5;
str_naive_opt   = 'naive_comp_opt_';
str_ac_opt      = 'ac_comp_opt_';
str_av_opt      = 'av_comp_opt_';
str_naive_1     = 'naive_comp_1_';
str_ac_1        = 'ac_comp_1_';
str_av_1        = 'av_comp_1_';
str_naive_2     = 'naive_comp_2_';
str_ac_2        = 'ac_comp_2_';
str_av_2       = 'av_comp_2_';
str_naive_3     = 'naive_comp_3_';
str_ac_3    = 'ac_comp_3_';
str_av_3    = 'av_comp_3_';

for i =1:fold
    load(strcat(str_naive_opt,num2str(i))); arr_naive_opt(:,i)  = learner_ar;
    load(strcat(str_ac_opt,num2str(i)));    arr_ac_opt(:,i)     = learner_ar;
    load(strcat(str_av_opt,num2str(i)));    arr_av_opt(:,i)     = learner_ar;
    load(strcat(str_naive_1,num2str(i)));   arr_naive_1(:,i)    = learner_ar;
    load(strcat(str_ac_1,num2str(i)));      arr_ac_1(:,i)       = learner_ar;
    load(strcat(str_av_1,num2str(i)));      arr_av_1(:,i)       = learner_ar;
    load(strcat(str_naive_2,num2str(i)));   arr_naive_2(:,i)    = learner_ar;
    load(strcat(str_ac_2,num2str(i)));      arr_ac_2(:,i)       = learner_ar;
    load(strcat(str_av_2,num2str(i)));      arr_av_2(:,i)       = learner_ar;
    load(strcat(str_naive_3,num2str(i)));   arr_naive_3(:,i)    = learner_ar;
    load(strcat(str_ac_3,num2str(i)));      arr_ac_3(:,i)       = learner_ar;
    load(strcat(str_av_3,num2str(i)));      arr_av_3(:,i)       = learner_ar;
end

%% First metric : iter to threshold (averaged cumulative reward)
opt_threshold = 5.3;
threshold_2 = 4.5;
naive_sup_threshold = (arr_naive_opt<=opt_threshold);
for i=1:fold
   naive_opt_index_arr(i,1) = size(find(arr_naive_opt(:,i)<=opt_threshold),1);
   ac_opt_index_arr(i,1)    = size(find(arr_ac_opt(:,i)<=opt_threshold),1);
   av_opt_index_arr(i,1)    = size(find(arr_av_opt(:,i)<=opt_threshold),1);
   naive_1_index_arr(i,1)   = size(find(arr_naive_1(:,i)<=opt_threshold),1);
   ac_1_index_arr(i,1)      = size(find(arr_ac_1(:,i)<=opt_threshold),1);
   av_1_index_arr(i,1)      = size(find(arr_av_1(:,i)<=opt_threshold),1);
   naive_2_index_arr(i,1)   = size(find(arr_naive_2(:,i)<=threshold_2),1);
   ac_2_index_arr(i,1)      = size(find(arr_ac_2(:,i)<=threshold_2),1);
   av_2_index_arr(i,1)      = size(find(arr_av_2(:,i)<=threshold_2),1);
   naive_3_index_arr(i,1)   = size(find(arr_naive_3(:,i)<=threshold_2),1);
   ac_3_index_arr(i,1)      = size(find(arr_ac_3(:,i)<=threshold_2),1);
   av_3_index_arr(i,1)      = size(find(arr_av_3(:,i)<=threshold_2),1);
end
naive_opt_index     = mean(naive_opt_index_arr); naive_1_index       = mean(naive_1_index_arr); naive_2_index    = mean(naive_2_index_arr); naive_3_index    = mean(naive_3_index_arr);
naive_opt_index_var = std(naive_opt_index_arr);  naive_1_index_var   = std(naive_1_index_arr); naive_2_index_var = std(naive_2_index_arr);  naive_3_index_var = std(naive_3_index_arr);
ac_opt_index        = mean(ac_opt_index_arr);    ac_1_index          = mean(ac_1_index_arr); ac_2_index = mean(ac_2_index_arr); ac_3_index = mean(ac_3_index_arr);
ac_opt_index_var    = std(ac_opt_index_arr);     ac_1_index_var      = std(ac_1_index_arr);  ac_2_index_var = std(ac_2_index_arr); ac_3_index_var = std(ac_3_index_arr);
av_opt_index        = mean(av_opt_index_arr);    av_1_index          = mean(av_1_index_arr); av_2_index = mean(av_2_index_arr); av_3_index = mean(av_3_index_arr);
av_opt_index_var    = std(av_opt_index_arr);     av_1_index_var      = std(av_1_index_arr);  av_2_index_var = std(av_2_index_arr); av_3_index_var = std(av_3_index_arr);

hold on;
% opt
plot(0,naive_opt_index,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(0,naive_opt_index,naive_opt_index_var,'LineWidth',2,'Color','b');
plot(0.1,ac_opt_index,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(0.1,ac_opt_index,ac_opt_index_var,'LineWidth',2,'Color','r');
plot(-0.1,av_opt_index,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(-0.1,av_opt_index,av_opt_index_var,'LineWidth',2,'Color','g');
%  subopt 1
plot(1,naive_1_index,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(1,naive_1_index,naive_1_index_var,'LineWidth',2,'Color','b');
plot(1.1,ac_1_index,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(1.1,ac_1_index,ac_1_index_var,'LineWidth',2,'Color','r');
plot(0.9,av_1_index,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(0.9,av_1_index,av_1_index_var,'LineWidth',2,'Color','g');
%  subopt 2
plot(2,naive_2_index,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(2,naive_2_index,naive_2_index_var,'LineWidth',2,'Color','b');
plot(2.1,ac_2_index,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(2.1,ac_2_index,av_2_index_var,'LineWidth',2,'Color','r');
plot(1.9,av_2_index,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(1.9,av_2_index,av_2_index_var,'LineWidth',2,'Color','g');
%  subopt 3
a = plot(3,naive_3_index,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(3,naive_3_index,naive_3_index_var,'LineWidth',2,'Color','b');
b= plot(3.1,ac_3_index,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(3.1,ac_3_index,ac_3_index_var,'LineWidth',2,'Color','r');
c = plot(2.9,av_3_index,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(2.9,av_3_index,av_3_index_var,'LineWidth',2,'Color','g');
% evolution plot
plot([0 1 2 3],[naive_opt_index, naive_1_index, naive_2_index, naive_3_index],'b-');
plot([0.1 1.1 2.1 3.1],[ac_opt_index, ac_1_index, ac_2_index, ac_3_index],'r-');
plot([-0.1 0.9 1.9 2.9],[av_opt_index, av_1_index, av_2_index, av_3_index],'g-');

h = legend([a,b,c],'Naive','Actor-Critic','Action-Value');
grid minor;
axis([-0.5 3.5 10 240]);
xticks([0 1 2 3])
xticklabels({'Optimal (T=5.5)','Suboptimal 1 (T=5.5)','Suboptimal 2 (T=4.5)','Suboptimal 3 (T=4.5)'})
ylabel('Iterations to threshold')
title('Time to threshold 10-fold statistics');


%% Second metric : Total reward (averaged cumulative reward)
naive_opt_cr_arr = sum(arr_naive_opt);
ac_opt_cr_arr    = sum(arr_ac_opt);
av_opt_cr_arr    = sum(arr_av_opt);
naive_1_cr_arr   = sum(arr_naive_1);
ac_1_cr_arr      = sum(arr_ac_1);
av_1_cr_arr      = sum(arr_av_1);
naive_2_cr_arr   = sum(arr_naive_2);
ac_2_cr_arr      = sum(arr_ac_2);
av_2_cr_arr      = sum(arr_av_2);
naive_3_cr_arr   = sum(arr_naive_3);
ac_3_cr_arr      = sum(arr_ac_3);
av_3_cr_arr      = sum(arr_av_3);

% statistics
naive_opt_cr_mean = mean(naive_opt_cr_arr); naive_opt_cr_var = std(naive_opt_cr_arr);
ac_opt_cr_mean = mean(ac_opt_cr_arr); ac_opt_cr_var = std(ac_opt_cr_arr);
av_opt_cr_mean = mean(av_opt_cr_arr); av_opt_cr_var = std(av_opt_cr_arr);
naive_1_cr_mean = mean(naive_1_cr_arr); naive_1_cr_var = std(naive_1_cr_arr);
ac_1_cr_mean = mean(ac_1_cr_arr); ac_1_cr_var = std(ac_1_cr_arr);
av_1_cr_mean = mean(av_1_cr_arr); av_1_cr_var = std(av_1_cr_arr);
naive_2_cr_mean = mean(naive_2_cr_arr); naive_2_cr_var = std(naive_2_cr_arr);
ac_2_cr_mean = mean(ac_2_cr_arr); ac_2_cr_var = std(ac_2_cr_arr);
av_2_cr_mean = mean(av_2_cr_arr); av_2_cr_var = std(av_2_cr_arr);
naive_3_cr_mean = mean(naive_3_cr_arr); naive_3_cr_var = std(naive_3_cr_arr);
ac_3_cr_mean = mean(ac_3_cr_arr); ac_3_cr_var = std(ac_3_cr_arr);
av_3_cr_mean = mean(av_3_cr_arr); av_3_cr_var = std(av_3_cr_arr);


figure; hold on;
% opt
plot(0,naive_opt_cr_mean,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(0,naive_opt_cr_mean,naive_opt_cr_var,'LineWidth',2,'Color','b');
plot(0.1,ac_opt_cr_mean,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(0.1,ac_opt_cr_mean,ac_opt_cr_var,'LineWidth',2,'Color','r');
plot(-0.1,av_opt_cr_mean,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(-0.1,av_opt_cr_mean,av_opt_cr_var,'LineWidth',2,'Color','g');
% subopt 1
plot(1,naive_1_cr_mean,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(1,naive_1_cr_mean,naive_1_cr_var,'LineWidth',2,'Color','b');
plot(1.1,ac_1_cr_mean,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(1.1,ac_1_cr_mean,ac_1_cr_var,'LineWidth',2,'Color','r');
plot(0.9,av_1_cr_mean,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(0.9,av_1_cr_mean,av_1_cr_var,'LineWidth',2,'Color','g');
% subopt 2
plot(2,naive_2_cr_mean,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(2,naive_2_cr_mean,naive_2_cr_var,'LineWidth',2,'Color','b');
plot(2.1,ac_2_cr_mean,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(2.1,ac_2_cr_mean,ac_2_cr_var,'LineWidth',2,'Color','r');
plot(1.9,av_2_cr_mean,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(1.9,av_2_cr_mean,av_2_cr_var,'LineWidth',2,'Color','g');
% subopt 3
a = plot(3,naive_3_cr_mean,'s','MarkerFaceColor','b','MarkerSize',10);
errorbar(3,naive_3_cr_mean,naive_3_cr_var,'LineWidth',2,'Color','b');
b = plot(3.1,ac_3_cr_mean,'s','MarkerFaceColor','r','MarkerSize',10);
errorbar(3.1,ac_3_cr_mean,ac_3_cr_var,'LineWidth',2,'Color','r');
c= plot(2.9,av_3_cr_mean,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(2.9,av_3_cr_mean,av_3_cr_var,'LineWidth',2,'Color','g');
% evolution 
plot([0 1 2 3],[naive_opt_cr_mean, naive_1_cr_mean, naive_2_cr_mean, naive_3_cr_mean],'b-');
plot([0.1 1.1 2.1 3.1],[ac_opt_cr_mean, ac_1_cr_mean, ac_2_cr_mean, ac_3_cr_mean],'r-');
plot([-0.1 0.9 1.9 2.9],[av_opt_cr_mean, av_1_cr_mean, av_2_cr_mean, av_3_cr_mean],'g-');

h = legend([a,b,c],'Naive','Actor-Critic','Action-Value');
axis([-0.5 3.5 200 2400]);
xticks([0 1 2 3]);
grid minor;
xticklabels({'Optimal','Suboptimal 1','Suboptimal 2','Suboptimal 3'})
ylabel('Total reward')
title('Total reward 10-fold statistics');
