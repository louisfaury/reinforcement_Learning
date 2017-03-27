function action_index = comply_or_defy(pi_m, action_set, temperature, p)
% @brief : pick random action in state's action set
% @param :  - pi_m : mentor action
%           - state_action = action set of the current state
%           - temperature = temperature coeff. for softmax
%           - proba. of compliance
% @return : (randomly) selected actions's index : comply vs defy 

m = size(action_set,2);
eps = 0.03;

if (rand<p)
    action_index_cell = strfind(action_set,pi_m);
    action_index = find(not(cellfun('isempty', action_index_cell)));
else
    softmax_random_pick(action_set, temperature);
end

end