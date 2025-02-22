function [pi,mdp] = qlearning_solve_mdp(mdp)
% @brief Solves the concerned MDP using the Q-learning algorithm 
% @param mdp = Markov Decision Process to be solved 
% @returns : - mdp = updated mdp
%            - pi : optimal greedy policy w.r.t learned Q-values. 

%% hyper parameters
n = size(mdp.states,2);
% mdp fixed by user
max_search_iter         = mdp.max_search;
max_iter                = mdp.ql.max_iter;
temperature             = mdp.ql.init_temp;
stop_criterion          = mdp.ql.stop_criterion;
default_value_bound     = mdp.ql.default_value;
alpha                   = mdp.ql.init_lr;
% allocate
deltas                  = zeros(max_iter,1);
cum_reward_per_episode  = zeros(max_iter,1);
delta                   = 10;
counts                  = ones(n,4); % counts for each state - learning rate adaptation 
mini_batch_size         = 10;

%%  init qvalues
for i=1:n
    m = size(mdp.states(i).actions,2);
    for j=1:m
       if (mdp.states(i).terminal)
        mdp.states(i).actions(j).value = 0; 
       else
           if (mdp.ql.optimistic_init)
               mdp.states(i).actions(j).value = default_value_bound;
           else
               mdp.states(i).actions(j).value = 2*default_value_bound*(rand-0.5);
           end
       end
    end
end

%% run
k=1;
while (k<max_iter && delta>stop_criterion)
    delta = 0;
    cum_reward = 0;
    for j=1:mini_batch_size
        state_index = pick_random_state(mdp);
        lIter = 0;
        while(~mdp.states(state_index).terminal && lIter < max_search_iter)
            % choosing next action, observing new state and reward 
            action_index = softmax_random_pick(mdp.states(state_index).actions,temperature);
            [next_state_index, reward] = follow_action(mdp, state_index, action_index); 
            cum_reward = cum_reward + reward;
            
            % update
            qvalue = mdp.states(state_index).actions(action_index).value;
            n_max_qvalue = max([mdp.states(next_state_index).actions.value]);
            lrate = alpha/(counts(state_index,action_index)^(0.505));
            u_qvalue = (1-lrate)*qvalue + lrate*(reward + mdp.discount*n_max_qvalue);
            counts(state_index,action_index) = counts(state_index,action_index)+1;
            delta = max(delta,abs(u_qvalue-qvalue));
            qvalue = u_qvalue;
            mdp.states(state_index).actions(action_index).value = qvalue;
            
            % update current step and action
            state_index = next_state_index;
            lIter = lIter +1;
        end
    end
    deltas(k) = delta;
    cum_reward_per_episode(k) = cum_reward/mini_batch_size;
    temperature = 0.98*temperature;
    k = k+1;
end

pi = generate_greedy_policy(mdp.states);

%% plots
figure('units','normalized','outerposition',[0 0 1 1]) 
% plot the changes in qvalues per minibatch
subplot(1,2,1);
plot(log(1:k-1),deltas(1:k-1),'r-.','LineWidth',1.5);
title('Q-Learning Solving of the MDP - Qvalues updates');
xlabel('$\log{(number\,of\,iterations)}$','Interpreter','latex');
ylabel('$\max_{minibatch}\left[\max_s{ \vert V_{k+1}(s)-V_k(s)\vert} \right]$','Interpreter','latex');
legend('Learning curve for policy value iteration');
% plot the rewards per episode averaged per minibatch
subplot(1,2,2);
plot(cum_reward_per_episode(1:k-1),'b','LineWidth',2);
xlabel('Number of iterations');
ylabel('Average reward');
legend('Average reward per episode per minibatch','Location','southeast');
title('Q-Learning Solving of the MDP - Averaged rewards per minibatch');

end