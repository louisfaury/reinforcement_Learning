function [action_index,mentor_index] = comply_or_defy_sig(pi_m, action_set, temperature, learn_value, discard_value, exclude)
% @brief : pick random action in state's action set based on a Bernouilli
% of parameter computed thanks to action-value difference 
% @param :  - pi_m : mentor action
%           - state_action = action set of the current state
%           - temperature = temperature coeff. for softmax
%           - learn_value and discard_value are action_values for differences
%           - flag for replacement in the action set 
% @return : (randomly) selected actions's index : comply vs defy 


end