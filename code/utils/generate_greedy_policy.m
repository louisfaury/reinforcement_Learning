function pi = generate_greedy_policy(mdp_states, counts)
% @brief : generates a greedy policy from the qvalues of a Markov Decision Process
% @param :  the mdp to be adressed, as well as counts to see if action was
%           once visited
% @returns : greedy policy pi w.r.t the qvalues

n = size(mdp_states,2);

for i=1:n
    m = size(mdp_states(i).actions,2);
    value = -100;
    for j=1:m
        action_value = mdp_states(i).actions(j).value;
        if (action_value > value && counts(i,j)>2)
            res = string(mdp_states(i).actions(j).name);
            value = action_value;
        end
    end
    pi(i) = res;
end

end