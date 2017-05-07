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

%% some important csts
rand_ar = -69.1052;
opt_ar = 5.8386;
load('subopt1_av_compliance'); mentor_1_per = (mean(mentor_ar)-7 - rand_ar)/(opt_ar-rand_ar);
load('subopt2_ac_compliance'); mentor_2_per = (mean(mentor_ar) - rand_ar)/(opt_ar-rand_ar);
load('subopt3_av_compliance'); mentor_3_per = (mean(mentor_ar) - rand_ar)/(opt_ar-rand_ar);

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
load('sarsa_lambda_ar'); sarsa_lambda_ar = cum_reward_per_episode;
load('ql_lambda_ar'); ql_lambda_ar = cum_reward_per_episode;
load('sarsa_ar'); sarsa_ar = cum_reward_per_episode;
load('ql_ar'); ql_ar = cum_reward_per_episode;

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
sarsa_lambda_index_1  = size(find(sarsa_lambda_ar(1:400)<=opt_threshold),1);
ql_lambda_index_1     = size(find(ql_lambda_ar(1:400)<=opt_threshold),1);
sarsa_lambda_index_2  = size(find(sarsa_lambda_ar(1:400)<=threshold_2),1);
ql_lambda_index_2     = size(find(ql_lambda_ar(1:400)<=threshold_2),1);
sarsa_index_1         = size(find(sarsa_ar(:)<=opt_threshold),1);
ql_index_1            = size(find(ql_ar(:)<=opt_threshold),1);
sarsa_index_2         = size(find(sarsa_ar(:)<=threshold_2),1);
ql_index_2            = size(find(ql_ar(:)<=threshold_2),1);

naive_opt_index     = mean(naive_opt_index_arr); naive_1_index       = mean(naive_1_index_arr); naive_2_index    = mean(naive_2_index_arr); naive_3_index    = mean(naive_3_index_arr);
naive_opt_index_var = std(naive_opt_index_arr);  naive_1_index_var   = std(naive_1_index_arr); naive_2_index_var = std(naive_2_index_arr);  naive_3_index_var = std(naive_3_index_arr);
ac_opt_index        = mean(ac_opt_index_arr);    ac_1_index          = mean(ac_1_index_arr); ac_2_index = mean(ac_2_index_arr); ac_3_index = mean(ac_3_index_arr);
ac_opt_index_var    = std(ac_opt_index_arr);     ac_1_index_var      = std(ac_1_index_arr);  ac_2_index_var = std(ac_2_index_arr); ac_3_index_var = std(ac_3_index_arr);
av_opt_index        = mean(av_opt_index_arr);    av_1_index          = mean(av_1_index_arr); av_2_index = mean(av_2_index_arr); av_3_index = mean(av_3_index_arr);
av_opt_index_var    = std(av_opt_index_arr);     av_1_index_var      = std(av_1_index_arr);  av_2_index_var = std(av_2_index_arr); av_3_index_var = std(av_3_index_arr);

hold on;
% opt
plot(0,naive_opt_index,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(0,naive_opt_index,naive_opt_index_var,'LineWidth',2,'Color',[1,0.3,0.1]);
plot(0,ac_opt_index,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(0,ac_opt_index,ac_opt_index_var,'LineWidth',2,'Color',[0.2,0.4,1]);
plot(0,av_opt_index,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(0,av_opt_index,av_opt_index_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
%  subopt 1
plot(1,naive_1_index,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(1,naive_1_index,naive_1_index_var,'LineWidth',2,'Color',[1,0.3,0.1]);
plot(1,ac_1_index,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(1,ac_1_index,ac_1_index_var,'LineWidth',2,'Color',[0.2,0.4,1]);
plot(1,av_1_index,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(1,av_1_index,av_1_index_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
%  subopt 2
plot(2,naive_2_index,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(2,naive_2_index,naive_2_index_var,'LineWidth',2,'Color',[1,0.3,0.1]);
plot(2,ac_2_index,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(2,ac_2_index,av_2_index_var,'LineWidth',2,'Color',[0.2,0.4,1]);
plot(2,av_2_index,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(2,av_2_index,av_2_index_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
%  subopt 3
a = plot(3,naive_3_index,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(3,naive_3_index,naive_3_index_var,'LineWidth',2,'Color',[1,0.3,0.1]);
b= plot(3,ac_3_index,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(3,ac_3_index,ac_3_index_var,'LineWidth',2,'Color',[0.2,0.4,1]);
c = plot(3,av_3_index,'s','MarkerFaceColor','g','MarkerSize',10);
errorbar(3,av_3_index,av_3_index_var,'LineWidth',2,'Color','g');
% evolution plot
plot([0 1 2 3],[naive_opt_index, naive_1_index, naive_2_index, naive_3_index],'Color',[1,0.3,0.1]);
plot([0 1 2 3],[ac_opt_index, ac_1_index, ac_2_index, ac_3_index],'Color',[0.2,0.4,1]);
plot([0 1 2 3],[av_opt_index, av_1_index, av_2_index, av_3_index],'Color',[0.2,0.8,0.4]);

h = legend([a,b,c],'Vanishing','Implicit $\beta$','Explicit');
set(h,'interpreter','latex')
axis([-0.5 3.5 10 240]);
xticks([0 1 2 3])
xticklabels({'100%',strcat(num2str(round(100*mentor_1_per)),'%'),strcat(num2str(round(100*mentor_2_per)),'%'),strcat(num2str(round(100*mentor_3_per)),'%')})
xlabel('Mentor optimality','FontSize',14)
grid minor;
ylabel('Iterations to threshold','FontSize',14)
title('Time to threshold 10-fold statistics');


%% Second metric : Total reward (averaged cumulative reward)
naive_opt_cr_arr = sum(arr_naive_opt(1:naive_opt_index,:))/(opt_ar*naive_opt_index);
ac_opt_cr_arr    = sum(arr_ac_opt(1:ac_opt_index,:))/(opt_ar*ac_opt_index);
av_opt_cr_arr    = sum(arr_av_opt(1:av_opt_index,:))/(opt_ar*av_opt_index);
naive_1_cr_arr   = sum(arr_naive_1(1:naive_1_index,:))/(opt_ar*naive_1_index);
ac_1_cr_arr      = sum(arr_ac_1(1:ac_1_index,:))/(opt_ar*ac_1_index);
av_1_cr_arr      = sum(arr_av_1(1:av_1_index,:))/(opt_ar*av_1_index);
naive_2_cr_arr   = sum(arr_naive_2(1:naive_2_index,:))/(opt_ar*naive_2_index);
ac_2_cr_arr      = sum(arr_ac_2(1:ac_2_index,:))/(opt_ar*ac_2_index);
av_2_cr_arr      = sum(arr_av_2(1:av_2_index,:))/(opt_ar*av_2_index);
naive_3_cr_arr   = sum(arr_naive_3(1:naive_3_index,:))/(opt_ar*naive_3_index);
ac_3_cr_arr      = sum(arr_ac_3(1:ac_3_index,:))/(opt_ar*ac_3_index);
av_3_cr_arr      = sum(arr_av_3(1:av_3_index,:))/(opt_ar*av_3_index);

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
plot(0,naive_opt_cr_mean,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(0,naive_opt_cr_mean,naive_opt_cr_var,'LineWidth',2,'Color',[1,0.3,0.1]);
plot(0,ac_opt_cr_mean,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(0,ac_opt_cr_mean,ac_opt_cr_var,'LineWidth',2,'Color',[0.2,0.4,1]);
plot(0,av_opt_cr_mean,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(0,av_opt_cr_mean,av_opt_cr_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
% subopt 1
plot(1,naive_1_cr_mean,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(1,naive_1_cr_mean,naive_1_cr_var,'LineWidth',2,'Color',[1,0.3,0.1]);
plot(1,ac_1_cr_mean,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(1,ac_1_cr_mean,ac_1_cr_var,'LineWidth',2,'Color',[0.2,0.4,1]);
plot(1,av_1_cr_mean,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(1,av_1_cr_mean,av_1_cr_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
% subopt 2
plot(2,naive_2_cr_mean,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(2,naive_2_cr_mean,naive_2_cr_var,'LineWidth',2,'Color',[1,0.3,0.1]);
plot(2,ac_2_cr_mean,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(2,ac_2_cr_mean,ac_2_cr_var,'LineWidth',2,'Color',[0.2,0.4,1]);
plot(2,av_2_cr_mean,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(2,av_2_cr_mean,av_2_cr_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
% subopt 3
a = plot(3,naive_3_cr_mean,'s','MarkerFaceColor',[1,0.3,0.1],'MarkerSize',10);
errorbar(3,naive_3_cr_mean,naive_3_cr_var,'LineWidth',2,'Color',[1,0.3,0.1]);
b = plot(3,ac_3_cr_mean,'s','MarkerFaceColor',[0.2,0.4,1],'MarkerSize',10);
errorbar(3,ac_3_cr_mean,ac_3_cr_var,'LineWidth',2,'Color',[0.2,0.4,1]);
c= plot(3,av_3_cr_mean,'s','MarkerFaceColor',[0.2,0.8,0.4],'MarkerSize',10);
errorbar(3,av_3_cr_mean,av_3_cr_var,'LineWidth',2,'Color',[0.2,0.8,0.4]);
% evolution 
plot([0 1 2 3],[naive_opt_cr_mean, naive_1_cr_mean, naive_2_cr_mean, naive_3_cr_mean],'Color',[1,0.3,0.1]);
plot([0 1 2 3],[ac_opt_cr_mean, ac_1_cr_mean, ac_2_cr_mean, ac_3_cr_mean],'Color',[0.2,0.4,1]);
plot([0 1 2 3],[av_opt_cr_mean, av_1_cr_mean, av_2_cr_mean, av_3_cr_mean],'Color',[0.2,0.8,0.4]);

h = legend([a,b,c],'Vanishing','Implicit $\beta$','Explicit');
set(h,'interpreter','latex')
axis([-0.5 3.5 -1 1]);
xticks([0 1 2 3]);
grid minor;
xticklabels({'100%',strcat(num2str(round(100*mentor_1_per)),'%'),strcat(num2str(round(100*mentor_2_per)),'%'),strcat(num2str(round(100*mentor_3_per)),'%')})
xlabel('Mentor optimality','FontSize',14)
ylabel('Total Reward to Convergence Ratio','FontSize',14)
title('Total Reward to Convergence Ratio 10-fold statistics');


%% With common methods
figure; hold on ;
%d = bar([naive_opt_index,ac_opt_index,av_opt_index,sarsa_index_1,sarsa_lambda_index_1,ql_index_1,ql_lambda_index_1; 
%     naive_1_index,ac_1_index,av_1_index,sarsa_index_1,sarsa_lambda_index_1,ql_index_1,ql_lambda_index_1;
%     naive_2_index,ac_2_index,av_2_index,sarsa_index_2,sarsa_lambda_index_2,ql_index_2,ql_lambda_index_2;
%     naive_3_index,ac_3_index,av_3_index,sarsa_index_2,sarsa_lambda_index_2,ql_index_2,ql_lambda_index_2]);
a = plot([1 2 3 4],[naive_opt_index,naive_1_index,naive_2_index,naive_3_index],'-.s','LineWidth',1);
b = plot([1 2 3 4],[ac_opt_index,ac_1_index,ac_2_index,ac_3_index],'-.s','LineWidth',1);
c = plot([1 2 3 4],[av_opt_index,av_1_index,av_2_index,av_3_index],'-.s','LineWidth',1);
d = plot([1 2 3 4],[sarsa_index_1,sarsa_index_1,sarsa_index_2,sarsa_index_2],'-.s','LineWidth',1);
e = plot([1 2 3 4],[sarsa_lambda_index_1,sarsa_lambda_index_1,sarsa_lambda_index_2,sarsa_lambda_index_2],'-.s','LineWidth',1);
f = plot([1 2 3 4],[ql_index_1,ql_index_1,ql_index_2,ql_index_2],'-.s','LineWidth',1);
g = plot([1 2 3 4],[ql_lambda_index_1,ql_lambda_index_1,ql_lambda_index_2,ql_lambda_index_2],'-.s','LineWidth',1);

h = legend([a b c d e f g],{'Naive','Actor-Critic','Action-value','Sarsa','Sarsa $\lambda$','QL','QL $\lambda$'});
set(h,'interpreter','latex','FontSize',14);
xticks([1 2 3 4])
xticklabels({'Optimal (T=5.5)','Suboptimal 1 (T=5.5)','Suboptimal 2 (T=4.5)','Suboptimal 3 (T=4.5)'})
grid minor;
ylabel('Iterations to threshold')
title('Time to threshold 10-fold means');
figure; hold on ;
%d = bar([naive_opt_index,ac_opt_index,av_opt_index,sarsa_index_1,sarsa_lambda_index_1,ql_index_1,ql_lambda_index_1; 
%     naive_1_index,ac_1_index,av_1_index,sarsa_index_1,sarsa_lambda_index_1,ql_index_1,ql_lambda_index_1;
%     naive_2_index,ac_2_index,av_2_index,sarsa_index_2,sarsa_lambda_index_2,ql_index_2,ql_lambda_index_2;
%     naive_3_index,ac_3_index,av_3_index,sarsa_index_2,sarsa_lambda_index_2,ql_index_2,ql_lambda_index_2]);
a = plot([1 2 3 4],[naive_opt_index,naive_1_index,naive_2_index,naive_3_index],'-.s','LineWidth',1);
b = plot([1 2 3 4],[ac_opt_index,ac_1_index,ac_2_index,ac_3_index],'-.s','LineWidth',1);
c = plot([1 2 3 4],[av_opt_index,av_1_index,av_2_index,av_3_index],'-.s','LineWidth',1);
d = plot([1 2 3 4],[sarsa_index_1,sarsa_index_1,sarsa_index_2,sarsa_index_2],'-.s','LineWidth',1);
e = plot([1 2 3 4],[sarsa_lambda_index_1,sarsa_lambda_index_1,sarsa_lambda_index_2,sarsa_lambda_index_2],'-.s','LineWidth',1);
f = plot([1 2 3 4],[ql_index_1,ql_index_1,ql_index_2,ql_index_2],'-.s','LineWidth',1);
g = plot([1 2 3 4],[ql_lambda_index_1,ql_lambda_index_1,ql_lambda_index_2,ql_lambda_index_2],'-.s','LineWidth',1);

h = legend([a b c d e f g],{'Naive','Actor-Critic','Action-value','Sarsa','Sarsa $\lambda$','QL','QL $\lambda$'});
set(h,'interpreter','latex','FontSize',14);
xticks([1 2 3 4])
xticklabels({'Optimal (T=5.5)','Suboptimal 1 (T=5.5)','Suboptimal 2 (T=4.5)','Suboptimal 3 (T=4.5)'})
grid minor;
ylabel('Iterations to threshold')
title('Time to threshold 10-fold means');
