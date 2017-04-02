function [action_index,mentor_index] = comply_or_defy_beta(pi_m, action_set, temperature, alpha, beta, exclude)
% @brief : pick random action in state's action set based on a Bernouilli
% random variable with Beta prior
% @param :  - pi_m : mentor action
%           - state_action = action set of the current state
%           - temperature = temperature coeff. for softmax
%           - alpha and beta coeffs of the Beta distribution 
%           - flag for replacement in the action set 
% @return : (randomly) selected actions's index : comply vs defy 
if nargin<6
    exclude = 'false';
end


if (~ismissing(string(pi_m)))
    mentor_index_cell = strfind({action_set.name},string(pi_m));
    mentor_index = find(not(cellfun('isempty', mentor_index_cell)));
    
    p = alpha / ( alpha + beta ); %% taken in mean, maybe sample ? 
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