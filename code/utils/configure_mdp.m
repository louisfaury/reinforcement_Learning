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
        % Actor critic imitation learning
        mdp.init_alpha = 0.5;
        mdp.init_beta = 0.05555;
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
        mdp.ql.max_iter = 400;
        mdp.ql.init_temp = 0.5;
        mdp.ql.stop_criterion = 0.001;
        mdp.ql.optimistic_init = true;
        mdp.ql.default_value = 2;
        mdp.ql.init_lr = 0.7;
    case 'maze_2d'
        mdp = load(strcat(model_name,'.mat'));
        mdp.force_start = [1,41,1681,1641];
        mdp.max_search = 320;
        % sarsa
        mdp.sarsa.max_iter = 600;
        mdp.sarsa.init_temp = 4;
        mdp.sarsa.temp_mult = 0.99;
        mdp.sarsa.stop_criterion = 0.0001;
        mdp.sarsa.default_value = 3;
        mdp.sarsa.init_lr = 1;
        % q-learning
        mdp.ql.max_iter = 600;
        mdp.ql.init_temp = 1;
        mdp.ql.stop_criterion = 0.001;
        mdp.ql.optimistic_init = true;
        mdp.ql.default_value = 1;
        mdp.ql.init_lr = 0.8;
        % sarsa lambda
        mdp.sarsa_lambda.max_iter = 200;
        mdp.sarsa_lambda.init_temp = 5;
        mdp.sarsa_lambda.temp_mult = 0.97;
        mdp.sarsa_lambda.stop_criterion = -0.1; % TODO : solve this issue
        mdp.sarsa_lambda.default_value = 2;
        mdp.sarsa_lambda.init_lr = 0.5;
        mdp.sarsa_lambda.lambda = 0.8;
        % Watkins Q(lambda)
        mdp.ql_lambda.max_iter = 150;
        mdp.ql_lambda.init_temp = 2;
        mdp.ql_lambda.temp_mult = 0.95;
        mdp.ql_lambda.stop_criterion = -0.1; % TODO : solve this issue
        mdp.ql_lambda.default_value = 2;
        mdp.ql_lambda.init_lr = 0.8;
        mdp.ql_lambda.lambda = 0.8;
        % Naive imitation learning 
        mdp.naive_il.max_iter = 400;
        mdp.naive_il.init_temp = 0.5;
        mdp.naive_il.p = 0.9;
        mdp.naive_il.temp_mult = 0.98;
        mdp.naive_il.stop_criterion = -0.1;
        mdp.naive_il.default_value = 0;
        mdp.naive_il.init_lr = 1;
        % Actor critic imitation learning 
        mdp.ac_il.init_alpha = 0.9;
        mdp.ac_il.init_beta = 0.1;
        mdp.ac_il.default_value = 0;
        mdp.ac_il.init_temp = 1;
        mdp.ac_il.stop_criterion = -0.1;
        mdp.ac_il.temp_mult = 0.99;
        mdp.ac_il.max_iter = 400;
        mdp.ac_il.init_lr = 1;
        mdp.ac_il.eps = 1;
        % Action value imitation learning 
        mdp.av_il.t0 = 0.5;
        mdp.av_il.qd_init_value = 0;
        mdp.av_il.ql_init_value = mdp.av_il.t0*2.19;
        mdp.av_il.default_value = 0;
        mdp.av_il.init_temp = 2;
        mdp.av_il.stop_criterion = -0.1;
        mdp.av_il.temp_mult = 0.95;
        mdp.av_il.max_iter = 400;
        mdp.av_il.init_lr = 1.1;
        mdp.av_il.ld_lr = 0.02; % listening/discard learning rate
    otherwise
        error('File name is not known (thrown in configure_model(.))');
end

if (environment_stochasticty)
    mdp.transition_success_proba = 0.95;
else
    mdp.transition_success_proba = 1;
end
mdp.discount = discount_factor;
mdp.dim = 41;

end