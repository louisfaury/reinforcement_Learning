%% main.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Main Script ================== %%% 
%%% ================================================ %%%
close all;
clear all;
clc; 
addpath(genpath('./stored_mdps'));
addpath(genpath('./draw'));
addpath(genpath('./utils'));
addpath(genpath('./methods'));

%% init
%model_name = 'free_grid_2d'; % defines model's name 
%model_name = 'obstacle_grid_2d';
model_name = 'maze_2d'; % defines model's name 
stochasticy = true; 
discount = 1;

%% configure mdp and draw state and action space
mdp = configure_mdp(model_name,stochasticy,discount);
draw_mdp(mdp);
tic

%% policy iteration and other mdp solving algos
% with bellman
%[pi_star,mdp] = bellman_solve_mdp(mdp);
% with Q-learning
%[pi_star,mdp] = qlearning_solve_mdp(mdp);
% with SARSA
%[pi_star,mdp] = sarsa_solve_mdp(mdp);
% with SARSA(lambda) 
%[pi_star,mdp] = sarsa_lambda_solve_mdp(mdp);
% with Watkins Q(lambda) 
[pi_star,mdp] = qlearning_lambda_solve_mdp(mdp);

%% plots the optimal policy 
toc
draw_policy(pi_star,mdp.states);

%% learning from a mentor's policy 
%pi_m = pi_star;
%ac_imitation_learning(pi_star, mdp) %% TODO finish 
