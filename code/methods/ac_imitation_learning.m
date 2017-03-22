function [pi,mdp] = ac_imitation_learning(pi_star, mdp)
%% <======================= HEADER =======================>
% @brief : This function implements the imitation based policy learning,
%          with actor critic approach
% @param : pi_star = mentor's policy 
%          mdp = Markov Decision Process to be solved. 
% @return : pi = derived optimal policy 
%  <======================================================>


n = size(mdp.states,2);
stop_criterion = mdp.ac_il.stop_criterion;
max_iter = mdp.ac_il.max_iter;
temperature = mdp.ac_il.temperature;

%% init 
for i=1:n
    mdp.states(i).alpha = mdp.ac_il.init_alpha;                   % inits alpha(s)
    mdp.states(i).beta = mdp.ac_il.init_beta;                     % inits beta(s) 
    
    m = size(mdp.states(i).actions,2);
    for j=1:m
       if (mdp.states(i).terminal)
        mdp.states(i).actions(j).value = 0;                 % inits Q(s,a) for terminal states
       else
           mdp.states(i).actions(j).value = mdp.ac_il.default_value;  % inits Q(s,a) for non terminal states 
       end
    end
end


%% run 
while (k<max_iter && delta>stop_criterion)
    delta = 0;
    cum_reward = 0;
    for j=1:mini_batch_size
        state_index = pick_random_state(mdp);
        action_index = comply_or_defy(mdp.states(state_index).alpha,mdp.states(state_index).beta,pi_star(state_index),mdp.states(state_index).actions,temperature);
        % TODO 

end
