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
load('subopt_compliance');
naive_compliance_ar = lfp(learner_ar,0.2);
load('subopt2_learnt_compliance');
ac_il_ar = lpf(learner_ar,0.2);
load('optimal_ar');
optimal_ar = cum_reward_per_episode;
load('sarsa_mentor_ar.mat');
mentor_learning_ar = lpf(mentor_learning_ar,0.3);
