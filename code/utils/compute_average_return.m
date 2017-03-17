function opt_ar = compute_average_return(mdp,greedy_pi)
%% <======================= HEADER =======================>
% @brief : This function generates average returns over minibatches for a greedy policy passed by user. If not, computes for random policy 
% @param : mdp = Markov Decision Process to be solved. 
% @return : pi = optimal policy 
%  <======================================================>

iter = 1000;
opt_ar = zeros(iter,1);
mini_batch_size = 5;

for k=1:iter
    ar = 0;
    for l=1:mini_batch_size
        state_index = pick_random_state(mdp);
        while(~mdp.states(state_index).terminal)
            if (nargin>1)
                % finds  greedy policy action index
                for j=1:size(mdp.states(state_index).actions,2)
                    if strcmp(mdp.states(state_index).actions(j).name,greedy_pi(state_index))
                        break;
                    end
                end
            else
               % computes a random action's index
               j = randi(size(mdp.states(state_index).actions,2));
            end
            state_index = follow_action(state_index,mdp.states(state_index).actions,j,mdp.transition_success_proba);
            reward = mdp.states(state_index).reward;
            ar = ar + reward;
        end
    end
    ar = ar / mini_batch_size;
    opt_ar(k) = ar;
end

end