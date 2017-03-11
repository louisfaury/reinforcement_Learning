function draw_policy(pi, mdp_states)
% @brief : Plots a policy (deterministic) on the state space 
% @param : - pi = considered policy
%          - mdp_states = the mdp's state space
figure(1);

n = size(mdp_states,2);
X = zeros(n,2);
arrows = X;
arrow_length = 0.8;

for i=1:n
    X(i,:) = [mdp_states(i).coord];
end

for i=1:n
    if (~mdp_states(i).terminal)
        switch (string(pi(i)))
            case 'up'
                arrows(i,:) = [0 arrow_length];
            case 'down'
                arrows(i,:) = [0 -arrow_length];
            case 'left'
                arrows(i,:) = [-arrow_length 0];
            case 'right'
                arrows(i,:) = [arrow_length 0];
        end
    end
end

quiver(X(:,1),X(:,2),arrows(:,1),arrows(:,2),0,'LineWidth',1.5,'Color',[0,0,0.5])
legend('Optimal policy','Location','north')

end