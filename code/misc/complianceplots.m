%% complianceplots.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Ref. Plots =================== %%% 
%%% ================================================ %%%

clear all;
close all;
clc;
addpath(genpath('data/'));

%% loads data 
%load('opt_compliance');
load('subopt1_compliance');
load('subopt2_compliance');
load('subopt3_compliance');
load('optimal_ar');
optimal_ar = cum_reward_per_episode;


%% plots
n = min([size(learner_ar,1),size(optimal_ar,1),size(mentor_ar,1)])-1;
p1 = plot(lpf(learner_ar(1:n),0.1),'LineWidth',1.8,'Color',[1,0.3,0.1]); hold on;
p2 = plot(lpf(mentor_ar(1:n),0.2),'Color',[0.05,0.3,0.8],'LineWidth',1.8);
p3 = plot(mean(optimal_ar)*ones(n,1),'-.','LineWidth',3,'Color','black');
p4 = plot(lpf(mentor_learning_ar(1:n),0.3),'LineWidth',2,'Color',[0.3,0.6,1]);
h = legend([p1,p2,p3,p4],'Learner averaged reward per episode','Mentor averaged reward per episode','Optimal policy mean reward','Mentor learning curve','Location','SouthEast');
set(h,'FontSize',12);