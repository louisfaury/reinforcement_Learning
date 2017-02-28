function state_index = pick_random_state(mdp_states)
% @brief : pick random state in state space
% @param : mdp_state = state space of the mdp
% @return : randomly selected (non-terminal) state's index

terminal = false;
n = size(mdp_states,2);

while (~terminal)
    index = randi(n);
    state = mdp_states(index);
    terminal = state.terminal;
end
state_index = index;

end