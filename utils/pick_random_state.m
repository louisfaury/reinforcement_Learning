function state_index = pick_random_state(mdp)
% @brief : pick random state in state space
% @param : mdp  = considered Markov Decision Process
% @return : randomly selected (non-terminal) state's index

terminal = true;
n = size(mdp.states,2);

if (mdp.force_start == 0)
    while (terminal)
        index = randi(n);
        state = mdp.states(index);
        terminal = state.terminal;
    end
else
    index = mdp.force_start;
end

state_index = index;

end