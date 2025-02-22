function [pi,mdp] = sarsa_solve_mdp(mdp)
%% <======================= HEADER =======================>
% @brief : This function solves the given MDP using SARSA algorithm
% @param : mdp = Markov Decision Process to be solved. 
% @return : pi = optimal policy 
%  <======================================================>


%% <======================= hyper-parameters =======================>
n = size(mdp.states,2);
% mdp fixed by user
max_search_iter         = mdp.max_search;
max_iter                = mdp.sarsa.max_iter;
temperature             = mdp.sarsa.init_temp;
temperature_mult_factor = mdp.sarsa.temp_mult;
stop_criterion          = mdp.sarsa.stop_criterion;
default_value           = mdp.sarsa.default_value;
alpha                   = mdp.sarsa.init_lr;
% allocate
deltas                  = zeros(max_iter,1);
cum_reward_per_episode  = zeros(max_iter,1);
delta                   = 10;
counts                  = ones(n,4); % counts for each state - learning rate tuning 
mini_batch_size         = 15;
% <==============================================================>
%
%
%
%% <======================= initialization =======================>

for i=1:n
    m = size(mdp.states(i).actions,2);
    for j=1:m
       if (mdp.states(i).terminal)
        mdp.states(i).actions(j).value = 0; 
       else
           mdp.states(i).actions(j).value = default_value;
       end
    end
end
% <==============================================================>
%
%
%
%% <======================= run =======================>
k=1;
while (k<max_iter && delta>stop_criterion)
    delta = 0;
    cum_reward = 0;
    for j=1:mini_batch_size
        state_index = pick_random_state(mdp);
        action_index = softmax_random_pick(mdp.states(state_index).actions,temperature);
        lIter = 0;
        while(~mdp.states(state_index).terminal && lIter < max_search_iter)
            [next_state_index, reward] = follow_action(mdp, state_index,action_index); 
            cum_reward = cum_reward + reward;
            next_action_index = softmax_random_pick(mdp.states(next_state_index).actions,temperature);
            
            % update
            qvalue = mdp.states(state_index).actions(action_index).value;
            n_qvalue = mdp.states(next_state_index).actions(next_action_index).value;
            lrate = alpha/(counts(state_index,action_index)^(1));
            u_qvalue = (1-lrate)*qvalue + lrate*(reward + mdp.discount*n_qvalue);
            counts(state_index,action_index) = counts(state_index,action_index)+1/mini_batch_size;
            delta = max(delta,abs(u_qvalue-qvalue));
            qvalue = u_qvalue;
            mdp.states(state_index).actions(action_index).value = qvalue;
            
            % update current step and action
            action_index = next_action_index;
            state_index = next_state_index;
            lIter = lIter +1;
        end
    end
    temperature = temperature*temperature_mult_factor;
    deltas(k) = delta;
    cum_reward_per_episode(k) = cum_reward/mini_batch_size;
    k = k+1
end

pi = generate_greedy_policy(mdp.states,counts);  

%  <==============================================================>
%
%
%% plots
figure('units','normalized','outerposition',[0 0 1 1]) 
% plot the changes in qvalues per minibatch
subplot(1,2,1);
plot(log(1:k-1),deltas(1:k-1),'r-.','LineWidth',1.5);
title('SARSA Solving of the MDP - Qvalues updates');
xlabel('$\log{(number\,of\,iterations)}$','Interpreter','latex');
ylabel('$\max_{minibatch}\left[\max_s{ \vert V_{k+1}(s)-V_k(s)\vert} \right]$','Interpreter','latex');
legend('Learning curve for policy value iteration');
%text(20,0.6,strcat('\gamma =',num2str(mdp.discount)),'FontSize',12);
%text(20,0.57,strcat('$\mathcal{P}_{s,\pi(s)} =$ ',num2str(mdp.transition_success_proba)),'FontSize',12,'Interpreter','latex');
% plot the rewards per episode averaged per minibatch
subplot(1,2,2);
plot(cum_reward_per_episode(1:k-1),'b','LineWidth',2);
xlabel('Number of iterations');
ylabel('Average reward');
legend('Average reward per episode per minibatch','Location','southeast');
title('SARSA Solving of the MDP - Averaged rewards per minibatch');

end