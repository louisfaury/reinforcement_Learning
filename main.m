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

%% init
model_name = 'free_grid_2d'; % defines model's name 
%model_name = 'obstacle_grid_2d';
%model_name = 'maze_2d'; % defines model's name 
stochasticy = true; 
discount = 1;
force_start = 1;

%% configure mdp and draw state and action space
mdp = configure_mdp(model_name,stochasticy,discount);
draw_mdp(mdp);

%% policy iteration 
% with bellman
%[pi_star,mdp] = bellman_solve_mdp(mdp);
% with Q-learning
%[pi_star,mdp] = qlearning_solve_mdp(mdp);
% with SARSA
[pi_star,mdp] = sarsa_solve_mdp(mdp);

%% plots the optimal policy 
draw_policy(pi_star,mdp.states);
