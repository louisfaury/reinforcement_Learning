function next_state_index = follow_action(current_state_index, actions, action_index, success_proba)

hdim = 40; % TODO : fix this, not pretty 

if (rand<=success_proba)
    action_name = string(actions(action_index).name);
    switch (action_name)
        case 'up'
            next_state_index = current_state_index+1;
        case 'down'
            next_state_index = current_state_index-1;
        case 'left'
            next_state_index = current_state_index-(hdim+1);
        case 'right'
            next_state_index = current_state_index+(hdim+1);
        otherwise
            error('Action not known');
    end
else
    random_index = randi(size(actions,2));
    while (random_index==action_index)
        random_index = randi(size(actions,2));
    end
    next_state_index = follow_action(current_state_index, actions, random_index, 1);
end
end