function action_index = comply_or_defy(pi_m, action_set, temperature, p, exclude)
% @brief : pick random action in state's action set
% @param :  - pi_m : mentor action
%           - state_action = action set of the current state
%           - temperature = temperature coeff. for softmax
%           - proba. of compliance
% @return : (randomly) selected actions's index : comply vs defy 
if nargin<5
    exclude = 'false';
end

if (~ismissing(string(pi_m)))
    mentor_index_cell = strfind({action_set.name},string(pi_m));
    mentor_index = find(not(cellfun('isempty', mentor_index_cell)));
    
    if (rand<p)
        action_index = mentor_index;
    else
        if (exclude==true)
        action_set_cp = action_set;
        action_set_cp(mentor_index) = [];
        action_index_cell = strfind({action_set.name},action_set_cp(softmax_random_pick(action_set_cp, temperature)).name);
        action_index = find(not(cellfun('isempty', action_index_cell)));
        else
            action_index = softmax_random_pick(action_set, temperature);
        end
    end
else
    action_index = 1; % default
end