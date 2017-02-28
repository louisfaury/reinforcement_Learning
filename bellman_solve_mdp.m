function [pi,mdp] = bellman_solve_mdp(mdp)
% @brief : This function solves the given MDP using the value iteration algorithm 
% @param : mdp = Markov Decision Process to be solved using dynamic prog. 
% @return : pi = optimal policy 

%% params
n = size(mdp.states,2);
max_iter = 50;
figure;
deltas = zeros(max_iter);
stop_criterion = 0.001;
delta = 10;
k=1;
default_value = 2;

%% init
for i=1:n
    if (mdp.states(i).terminal)
        mdp.states(i).value = 0;
    else
        mdp.states(i).value = default_value;
    end
end

%% run
while (k<max_iter && delta>stop_criterion)
    delta = 0;
    for i=1:n
        if (~mdp.states(i).terminal)
            m = size(mdp.states(i).actions,2);
            value = -100;
            for j=1:m
                action_value = compute_action_value(mdp.states,i,j,mdp.transition_success_proba,mdp.discount);
                if (action_value > value)
                    value = action_value;
                    pi(i) = string(mdp.states(i).actions(j).name);
                end
            end
            delta = max(delta,abs(value - mdp.states(i).value));
            mdp.states(i).value = value;
        end
    end
    deltas(k) = delta;
    k = k+1;
end

%% plots
plot(deltas(1:k),'r-.');
title('Dynamic Programing Solving of the MDP');
xlabel('Number of iterations');
ylabel('$\max_s{ \vert V_{k+1}(s)-V_k(s)\vert }$','Interpreter','latex');
legend('Learning curve for policy value iteration');
%text(20,0.6,strcat('\gamma =',num2str(mdp.discount)),'FontSize',12);
%text(20,0.57,strcat('$\mathcal{P}_{s,\pi(s)} =$ ',num2str(mdp.transition_success_proba)),'FontSize',12,'Interpreter','latex');

end