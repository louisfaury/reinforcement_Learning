function state_index = pick_random_state(mdp)
% @brief : pick random state in state space
% @param : mdp  = considered Markov Decision Process
% @return : randomly selected (non-terminal) state's index

terminal = true;
n = size(mdp.states,2);

if (any(0==mdp.force_start))
    while (terminal)
        index = randi(n);
        state = mdp.states(index);
        terminal = state.terminal;
    end
else
    index = mdp.force_start(randi(size(mdp.force_start,2)));
end

state_index = index;

end