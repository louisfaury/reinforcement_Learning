function [action_index,mentor_index] = comply_or_defy_sig(pi_m, action_set, temperature, listen_value, discard_value, temp, exclude)
% @brief : pick random action in state's action set based on a Bernouilli
% of parameter computed thanks to action-value difference 
% @param :  - pi_m : mentor action
%           - state_action = action set of the current state
%           - temperature = temperature coeff. for softmax
%           - listen_value and discard_value are action_values for differences
%           - flag for replacement in the action set 
% @return : (randomly) selected actions's index : comply vs defy 

if nargin<7
    exclude = 'false';
end

sig = @(x) 1/(1+exp(-x));

if (~ismissing(string(pi_m)))
    mentor_index_cell = strfind({action_set.name},string(pi_m));
    mentor_index = find(not(cellfun('isempty', mentor_index_cell)));
    
    p = sig((listen_value - discard_value)/temp); %% taken in mean, maybe sample ? 
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
    mentor_index = 1;
    action_index = 1; % default
    
end