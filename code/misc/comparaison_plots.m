%% %% comparaison_plots.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Compliance Plots =================== %%% 
%%% ================================================ %%%

clear all;
close all;
clc;
addpath(genpath('data/'));

%% loads data 
load('subopt2_compliance');
naive_compliance_ar = lpf(learner_ar(1:size(learner_ar)-1),0.2);
load('subopt2_learnt_compliance');
ac_il_ar = lpf(learner_ar(1:size(learner_ar)-1),0.2);
load('optimal_ar');
optimal_ar = cum_reward_per_episode;
load('sarsa_mentor_ar.mat');
mentor_learning_ar = lpf(mentor_learning_ar,0.3);
n = size(mentor_learning_ar,1)-1;

%% plots
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
p1 = plot(naive_compliance_ar,'LineWidth',2,'Color',[1,0.3,0.1]);
p2 = plot(ac_il_ar,'LineWidth',2.2,'Color',[0.2,0.6,0.4]);
p3 = plot(mean(optimal_ar)*ones(n,1),'-.','LineWidth',3,'Color','black');
p4 = plot(mentor_learning_ar(1:n),'LineWidth',2,'Color',[0.4,0.8,1]);
p5 = plot(120, mentor_learning_ar(120), 'sr','MarkerFaceColor','red','MarkerSize',12);
h = legend([p1,p2,p3,p4,p5],'Learner averaged reward per episode','Mentor averaged reward per episode','Optimal policy mean reward','Initial learning curve','Mentor policy before greedization','Location','SouthEast');
set(h,'FontSize',13);