function action_index = softmax_random_pick(state_actions,temperature)
% @brief : pick random action in state's action set
% @param : - state_action = action set of the current state
%          - temperature = temperature coeff. for softmax
% @return : randomly selected actions's index

m = size(state_actions,2);
eps = 0.03;

exp_qvalues = zeros(m,1);
for i=1:m
    exp_qvalues(i) = exp(state_actions(i).value/(max(temperature,eps)));
end

normalized_cumsum_qvalues = cumsum(exp_qvalues)/sum(exp_qvalues);
action_index = find(rand<normalized_cumsum_qvalues,1,'first');

end