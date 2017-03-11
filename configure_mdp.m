function mdp = configure_mdp(model_name,environment_stochasticty, discount_factor)
% @brief : loads a Markov Decision Process given a model's name, and possibly add stochasticity in transitions. Also sets the MDP's discount factor.
% @param : - model_name = name of the model to be used as file name
%          - environment_stochasticity = true or false flag to determine wether transitions are stochastic or deterministic
%        : - discount_factor : discount factor for the expected return formula
switch model_name
    case 'free_grid_2d'
        mdp = load(strcat(model_name,'.mat'));
        mdp.force_start = 0;
        % sarsa
        mdp.sarsa.max_iter = 500;
        mdp.sarsa.init_temp = 2;
        mdp.sarsa.temp_mult = 0.99;
        mdp.sarsa.stop_criterion = 0.001;
        mdp.sarsa.default_value = 5;
        mdp.sarsa.init_lr = 0.7;
        % q-learning
        mdp.ql.max_iter = 300;
        mdp.ql.init_temp = 0.5;
        mdp.ql.stop_criterion = 0.001;
        mdp.ql.optimistic_init = true;
        mdp.ql.default_value = 2;
        mdp.ql.init_lr = 0.7;
    case 'obstacle_grid_2d'
        mdp = load(strcat(model_name,'.mat'));
        mdp.force_start = 0;
        % sarsa
        mdp.sarsa.max_iter = 700;
        mdp.sarsa.init_temp = 2;
        mdp.sarsa.temp_mult = 0.99;
        mdp.sarsa.stop_criterion = 0.001;
        mdp.sarsa.default_value = 5;
        mdp.sarsa.init_lr = 0.7;
        % q-learning
        mdp.ql.max_iter = 300;
        mdp.ql.init_temp = 0.5;
        mdp.ql.stop_criterion = 0.001;
        mdp.ql.optimistic_init = true;
        mdp.ql.default_value = 2;
        mdp.ql.init_lr = 0.7;
    case 'maze_2d'
        mdp = load(strcat(model_name,'.mat'));
        mdp.force_start = 1;
        % sarsa
        mdp.sarsa.max_iter = 100;
        mdp.sarsa.init_temp = 6;
        mdp.sarsa.temp_mult = 0.9995;
        mdp.sarsa.stop_criterion = 0.00001;
        mdp.sarsa.default_value = 4;
        mdp.sarsa.init_lr = 1;
        mdp.ql.max_iter = 1000;
        mdp.ql.init_temp = 0.4;
        mdp.ql.stop_criterion = 0.000;
        mdp.ql.optimistic_init = false;
        mdp.ql.default_value = 2;
        mdp.ql.init_lr = 1.2;
    otherwise
        error('File name is not known (thrown in configure_model(.))');
end

if (environment_stochasticty)
    mdp.transition_success_proba = 0.95;
else
    mdp.transition_success_proba = 1;
end
mdp.discount = discount_factor;

end