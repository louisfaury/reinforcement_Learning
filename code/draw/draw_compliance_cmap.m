function draw_compliance_cmap(pi,mdp_states)
% @brief : Plots a policy labeled with confidence in a learner or not  
% @param : - pi = considered policy
%          - mdp_states = the mdp's state space
figure(1);

n = size(mdp_states,2);
X = zeros(n,2);
index = zeros(n,10);
arrows = X;
arrow_length = 0.8;
cmap = @(x) [1 0 0] + x*[-1 1 0] ;

for i=1:n
    X(i,:) = [mdp_states(i).coord];
end

for i=1:n
    if (~mdp_states(i).terminal && ~mdp_states(i).obstacle)
        alpha = mdp_states(i).alpha; beta = mdp_states(i).beta;
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
    score = max(1,round(10*alpha/(alpha+beta)));
    index(i,score) = 1;
end

hold on;
for j=1:10
    ix = find(index(:,j));
    quiver(X(ix,1),X(ix,2),arrows(ix,1),arrows(ix,2),0,'LineWidth',1.5,'Color',cmap(0.1*j));
end

%quiver(X(:,1),X(:,2),arrows(:,1),arrows(:,2),0,'LineWidth',1.5,'Color',[0,0,0.5])
%legend('Optimal policy','Location','north')
end