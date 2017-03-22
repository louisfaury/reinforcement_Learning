function [next_state_index, reward] = follow_action(mdp, current_state_index, action_index, f_transition_proba)
% TODO add header
actions = mdp.states(current_state_index).actions;

% checks if the user force a transition proba
if (nargin>3)
    transition_proba = f_transition_proba;
else
    transition_proba = mdp.transition_success_proba;
end

if (rand<=transition_proba)
    action_name = string(actions(action_index).name);
    switch (action_name)
        case 'up'
            next_state_index = current_state_index+1;
        case 'down'
            next_state_index = current_state_index-1;
        case 'left'
            next_state_index = current_state_index-mdp.dim;
        case 'right'
            next_state_index = current_state_index+mdp.dim;
        otherwise
            error('Action not known');
    end
else
    random_index = randi(size(actions,2));
    while (random_index==action_index)
        random_index = randi(size(actions,2));
    end
    next_state_index = follow_action(mdp, current_state_index, random_index, 1);
end

% computes next state reward 
reward = mdp.states(next_state_index).reward;

% Checks if the next state is an obstacle : if yes, don't move and perceive
% the obstacle reward
if mdp.states(next_state_index).obstacle
    next_state_index = current_state_index;
end

end