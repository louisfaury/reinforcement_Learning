function opt_ar = compute_average_return(mdp,greedy_pi,iter)
%% <======================= HEADER =======================>
% @brief : This function generates average returns over minibatches for a greedy policy passed by user. If not, computes for random policy 
% @param : mdp = Markov Decision Process to be solved. 
% @return : pi = optimal policy 
%  <======================================================>

opt_ar = zeros(iter,1);
mini_batch_size = 10;
max_search_iter = mdp.max_search;

for k=1:iter
    ar = 0;
    for l=1:mini_batch_size
        state_index = pick_random_state(mdp);
        lIter = 0;
        while(~mdp.states(state_index).terminal && lIter < max_search_iter)
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
            [state_index, reward] = follow_action(mdp, state_index,j);
            ar = ar + reward;
            lIter = lIter +1;
        end
    end
    ar = ar / mini_batch_size;
    opt_ar(k) = ar;
end

end