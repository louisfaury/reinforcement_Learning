%% refplots.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Ref. Plots =================== %%% 
%%% ================================================ %%%

%clear all;
close all;
clc;
addpath(genpath('data/'));

%% Average reward per episode for recorded learning processes
sarsa_lambda_08_ar = load('sarsa_lambda_08_ar.mat');
sarsa_lambda_08_ar = sarsa_lambda_08_ar.cum_reward_per_episode;
ql_ar = load('ql_ar.mat');
ql_ar = ql_ar.cum_reward_per_episode;
sarsa_ar = load('sarsa_ar.mat');
sarsa_ar = sarsa_ar.cum_reward_per_episode;
ql_lambda_ar = load('ql_lambda_ar');
ql_lambda_ar = ql_lambda_ar.cum_reward_per_episode;
optimal_ar = load('optimal_ar');
optimal_ar = optimal_ar.cum_reward_per_episode;
random_ar = load('random_ar');
random_ar = random_ar.cum_reward_per_episode;
%subopt_1_ar = load('subopt_2_ar');
%subopt_1_ar = subopt_1_ar.cum_reward_per_episode;
size = min([size(optimal_ar,1),size(random_ar,1),size(sarsa_lambda_08_ar,1), size(ql_ar,1), size(ql_lambda_ar,1), size(sarsa_ar,1)]);

figure('units','normalized','outerposition',[0 0 1 1]) 
hold on;
% Sarsa 
smooth_sarsa = lpf(sarsa_ar(1:size-1),0.3);
p1 = plot(sarsa_ar(1:size-1),'LineWidth',1,'Color',[0.95, 0.1, 0.1]);
p1.Color(4) = 0.1;
p1p = plot(smooth_sarsa,'LineWidth',2,'Color',[0.95, 0.1, 0.1]);
text(200,smooth_sarsa(200)+6,'Sarsa','Color',[0.95, 0.1, 0.1],'FontWeight','bold','FontSize',14);
% Q-learning
smooth_ql = lpf(ql_ar(1:size-1),0.3);
p2 = plot(ql_ar(1:size-1),'LineWidth',1.2,'Color',[0.2, 0.2, 0.6]);
p2.Color(4) = 0.1;
p2p = plot(smooth_ql,'LineWidth',2,'Color',[0.2, 0.2, 0.6]);
text(160,smooth_ql(150)+5,'QL','Color',[0.2, 0.2, 0.6],'FontWeight','bold','FontSize',14);
% Sarsa lambda
smooth_sarsa_lambda = lpf(sarsa_lambda_08_ar(1:size-1),0.3);
p3 = plot(sarsa_lambda_08_ar(1:size-1),'LineWidth',1.2,'Color',[0.2, 0.7, 0.2]);
p3.Color(4) = 0.1;
p3p = plot(smooth_sarsa_lambda,'LineWidth',2,'Color',[0.2, 0.7, 0.2]);
text(90,smooth_sarsa_lambda(80)+5,'Sarsa(\lambda)','Color',[0.2, 0.7, 0.2],'FontWeight','bold','HorizontalAlignment','left','FontSize',14);
% Watkins Q lambda
smooth_ql_lambda_ar = lpf(ql_lambda_ar(1:size-1),0.3);
p4 = plot(ql_lambda_ar(1:size-1),'LineWidth',1.2,'Color',[0.3, 0.6, 1]);
p4.Color(4) = 0.1;
p4p = plot(smooth_ql_lambda_ar,'LineWidth',2,'Color',[0.3, 0.6, 1]);
text(40,smooth_ql_lambda_ar(40)+5,'QL(\lambda)','Color',[0.3, 0.6, 1],'FontWeight','bold','HorizontalAlignment','right','FontSize',14);
% Optimal policy
p5 = plot(optimal_ar(1:size-1),'LineWidth',1.2,'Color',[0.3, 0.6, 1]);
p5.Color(4) = 0.1;
p5p = plot(lpf(optimal_ar(1:size-1),0.1),'--','LineWidth',2,'Color',[0.1, 0.1, 0.1]);
text(20,optimal_ar(20)+5,'Optimal policy','Color',[0.1, 0.1, 0.1],'FontWeight','bold','FontSize',14);
% Random policy
smooth_random_ar = lpf(random_ar(1:size-1),0.05);
p6 = plot(random_ar(1:size-1),'LineWidth',1.2,'Color',[0.5, 0.5, 0.5]);
p6.Color(4) = 0.1;
p6p = plot(smooth_random_ar,'LineWidth',2,'Color',[0.5, 0.5, 0.5]);
text(350,smooth_random_ar(350)+5,'Random policy','Color',[0.5, 0.5, 0.5],'FontWeight','bold','FontSize',14);

%load('subopt2_ac_compliance.mat');
%plot(lpf(learner_ar,0.1),'LineWidth',2);
%load('subopt3_ac_compliance.mat');
%plot(lpf(learner_ar,0.1),'LineWidth',2);

%% Plots
xlabel('Number of iterations');
ylabel('Average reward');
h = legend([p1p,p2p,p3p,p4p,p5p,p6p],'Sarsa(0)','Q-learning','Sarsa(0.8)','Watkins Q(0.8)','Bellman optimal policy','Random policy','Location','southeast');
set(h,'FontSize',14);
title('Averaged rewards per minibatch for different methods','Interpreter','latex');