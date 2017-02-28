function mdp = configure_mdp(model_name,environment_stochasticty, discount_factor)
% @brief : loads a Markov Decision Process given a model's name, and possibly add stochasticity in transitions. Also sets the MDP's discount factor.
% @param : - model_name = name of the model to be used as file name
%          - environment_stochasticity = true or false flag to determine wether transitions are stochastic or deterministic
%        : - discount_factor : discount factor for the expected return formula
switch model_name
    case 'free_grid_2d'
        mdp = load(strcat(model_name,'.mat'));
    case 'obstacle_grid_2d'
        mdp = load(strcat(model_name,'.mat'));
    case 'maze_2d'
        mdp = load(strcat(model_name,'.mat'));
    otherwise
        error('File name is not known (thrown in configure_model(.))');
end

if (environment_stochasticty)
    mdp.transition_success_proba = 0.9;
else
    mdp.transition_success_proba = 1;
end
mdp.discount = discount_factor;
end