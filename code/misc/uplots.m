%% useful_plots.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Main Script ================== %%% 
%%% ================================================ %%%

clear all;
close all;
clc;

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

figure('units','normalized','outerposition',[0 0 1 1]) 
hold on;
% Sarsa 
p1 = plot(sarsa_ar(1:size(sarsa_ar,1)-1),'LineWidth',1,'Color',[0.95, 0.1, 0.1]);
p1.Color(4) = 0.1;
p1p = plot(lpf(sarsa_ar(1:size(sarsa_ar,1)-1),0.3),'LineWidth',2,'Color',[0.95, 0.1, 0.1]);
% Q-learning
p2 = plot(ql_ar(1:size(ql_ar,1)-1),'LineWidth',1.2,'Color',[0.2, 0.2, 0.6]);
p2.Color(4) = 0.1;
p2p = plot(lpf(ql_ar(1:size(ql_ar,1)-1),0.3),'LineWidth',2,'Color',[0.2, 0.2, 0.6]);
% Sarsa lambda
p3 = plot(sarsa_lambda_08_ar(1:size(sarsa_lambda_08_ar,1)-1),'LineWidth',1.2,'Color',[0.2, 0.7, 0.2]);
p3.Color(4) = 0.1;
p3p = plot(lpf(sarsa_lambda_08_ar(1:size(sarsa_lambda_08_ar,1)-1),0.3),'LineWidth',2,'Color',[0.2, 0.7, 0.2]);
% Watkins Q lambda
p4 = plot(ql_lambda_ar(1:size(ql_lambda_ar,1)-1),'LineWidth',1.2,'Color',[0.3, 0.6, 1]);
p4.Color(4) = 0.1;
p4p = plot(lpf(ql_lambda_ar(1:size(ql_lambda_ar,1)-1),0.3),'LineWidth',2,'Color',[0.3, 0.6, 1]);
% Optimal policy
p5 = plot(optimal_ar(1:size(optimal_ar,1)-1),'LineWidth',1.2,'Color',[0.3, 0.6, 1]);
p5.Color(4) = 0.1;
p5p = plot(lpf(optimal_ar(1:size(optimal_ar,1)-1),0.1),'--','LineWidth',2,'Color',[0.1, 0.1, 0.1]);
% Random policy
p6 = plot(random_ar(1:size(random_ar,1)-1),'LineWidth',1.2,'Color',[0.5, 0.5, 0.5]);
p6.Color(4) = 0.1;
p6p = plot(lpf(random_ar(1:size(random_ar,1)-1),0.05),'LineWidth',2,'Color',[0.5, 0.5, 0.5]);

%% Plots
xlabel('Number of iterations');
ylabel('Average reward');
legend([p1p,p2p,p3p,p4p,p5p,p6p],'Sarsa(0)','Q-learning','Sarsa(0.8)','Watkins Q(0.8)','Bellman optimal policy','Random policy','Location','southeast');
title('Averaged rewards per minibatch for different methods','Interpreter','latex');