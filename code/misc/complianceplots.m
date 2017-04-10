%% complianceplots.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Compliance Plots =================== %%% 
%%% ================================================ %%%

clear all;
close all;
clc;
addpath(genpath('data/'));

%% ========================== 
%%     Optimal policy 
%% ========================== 
%load
load('optimal_ar');
optimal_ar = cum_reward_per_episode;
load('opt_naive_compliance');
opt_naive_ar = lpf(learner_ar,0.3);
opt_mentor_ar = lpf(mentor_ar,0.1);
n = min([size(opt_naive_ar,1),size(optimal_ar,1),size(opt_mentor_ar,1)])-1;
%plot
p1 = plot(opt_naive_ar(1:n),'LineWidth',1.8,'Color',[1,0.3,0.1]); hold on;
p2 = plot(opt_mentor_ar(1:n),'Color',[0.05,0.3,0.8],'LineWidth',2);
p3 = plot(mean(optimal_ar)*ones(n,1),'-.','LineWidth',3,'Color','black');
h = legend([p1,p2,p3],'Learner averaged reward per episode','Mentor averaged reward per episode','Optimal policy mean reward','Location','SouthEast');
set(h,'FontSize',12);
xlabel('Number of iterations');
ylabel('Average reward');


%% ========================== 
%%  Suboptimal policy (120)
%% ========================== 
figure;
%load
load('optimal_ar');
optimal_ar = cum_reward_per_episode;
load('subopt2_naive_compliance');
learner_naive_ar = lpf(learner_ar,0.3);
load('subopt2_ac_compliance');
learner_ac_ar = lpf(learner_ar,0.3);
load('sarsa_mentor_ar.mat');
mentor_learning_ar = lpf(mentor_learning_ar,0.3);
% plot
n = min([size(learner_ar,1),size(optimal_ar,1),size(mentor_ar,1)])-1;
p1 = plot(learner_naive_ar,'LineWidth',1.8,'Color',[1,0.3,0.1]); hold on;
p2 = plot(learner_ac_ar,'LineWidth',2.2,'Color',[0.2,0.4,1]); hold on;
p3 = plot(lpf(mentor_ar(1:n),0.1),'Color',[0.05,0.3,0.8],'LineWidth',2);
p4 = plot(mean(optimal_ar)*ones(n,1),'-.','LineWidth',3,'Color','black');
p5 = plot(mentor_learning_ar(1:n),'LineWidth',2,'Color',[0.4,0.8,1]);
p6 = plot(120, mentor_learning_ar(120), 'sr','MarkerFaceColor','red','MarkerSize',10);
h = legend([p1,p2,p3,p4,p5,p6],'Naive learner','AC learner','Mentor','Optimal policy mean reward','Initial learning curve','Mentor policy before greedization','Location','SouthEast');
set(h,'FontSize',12);
xlabel('Number of iterations');
ylabel('Average reward');

%% ========================== 
%%  Suboptimal policy (120)
%% ========================== 
figure;
%load
load('optimal_ar');
optimal_ar = cum_reward_per_episode;
load('subopt3_naive_compliance');
learner_naive_ar = lpf(learner_ar,0.1);
load('subopt3_ac_compliance');
learner_ac_ar = lpf(learner_ar,0.1);
load('sarsa_mentor_ar.mat');
mentor_learning_ar = lpf(mentor_learning_ar,0.3);
% plot
n = min([size(learner_ar,1),size(optimal_ar,1),size(mentor_ar,1)])-1;
p1 = plot(learner_naive_ar,'LineWidth',1.8,'Color',[1,0.3,0.1]); hold on;
p2 = plot(learner_ac_ar,'LineWidth',2.2,'Color',[0.2,0.4,1]); hold on;
p3 = plot(lpf(mentor_ar(1:n),0.1),'Color',[0.05,0.3,0.8],'LineWidth',2);
p4 = plot(mean(optimal_ar)*ones(n,1),'-.','LineWidth',3,'Color','black');
p5 = plot(mentor_learning_ar(1:n),'LineWidth',2,'Color',[0.4,0.8,1]);
p6 = plot(50, mentor_learning_ar(50), 'sr','MarkerFaceColor','red','MarkerSize',10);
h = legend([p1,p2,p3,p4,p5,p6],'Naive learner','AC learner','Mentor','Optimal policy mean reward','Initial learning curve','Mentor policy before greedization','Location','SouthEast');
set(h,'FontSize',12);
xlabel('Number of iterations');
ylabel('Average reward');