function draw_decision_map(pi,mdp_states)
% @brief : Plots a policy labeled with confidence action ('listen') or 'discard'  
% @param : - pi = considered policy
%          - mdp_states = the mdp's state space
figure(1);

n = size(mdp_states,2);
X = zeros(n,2);
index = zeros(n,1);
arrows = X;
arrow_length = 0.8;

for i=1:n
    X(i,:) = [mdp_states(i).coord];
end

for i=1:n
    if (~mdp_states(i).terminal && ~mdp_states(i).obstacle)
        lv = mdp_states(i).ql_value; dv = mdp_states(i).qd_value; % listening value versus discarding value 
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
    index(i,:) = double(lv >= (dv-0.001));
end

hold on;
ix = find(index);
quiver(X(ix,1),X(ix,2),arrows(ix,1),arrows(ix,2),0,'LineWidth',1.5,'Color',[0 1 0]);
iy = find(~index);
quiver(X(iy,1),X(iy,2),arrows(iy,1),arrows(iy,2),0,'LineWidth',1.5,'Color',[1 0 0]);




end