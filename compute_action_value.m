function action_value = compute_action_value(mdp_states,state_index,action_index,transition_prob,discount)
% @brief computes action value for a given action
% @param : - mdp_states : state space for the mdp
%          - state_index : index of current state
%          - action_index : index of action considered
%          - transition_prob : prob. of transitioning in the right state
%          - discount : discount factor
% @returns : - action_value = value of the considered action 

value = 0;
m = size(mdp_states(state_index).actions,2);

for j=1:m
    switch (string(mdp_states(state_index).actions(j).name))
        case 'up'
            n_state = mdp_states(state_index+1);
        case 'down'
            n_state = mdp_states(state_index-1);
        case 'left'
            n_state = mdp_states(state_index-11);
        case 'right'
            n_state = mdp_states(state_index+11);
        otherwise
            error('Action not known');
    end
    if (j==action_index)
        value = value + transition_prob*(n_state.reward + discount*n_state.value);
    else
        value = value + (1-transition_prob)/(m-1)*(n_state.reward + discount*n_state.value);
    end
end
action_value = value;

    
end