function [pi,mdp] = naive_imitation_learning(pi_m, mdp)
%% <======================= HEADER =======================>
% @brief : This function implements a naive imitation base learning : 
%           follows mentor action with proba p, action selection among the
%           rest with proba (1-p)
% @param : pi_m = mentor's policy 
%          mdp = Markov Decision Process to be solved. 
% @return : pi = derived optimal policy 
%  <======================================================>


n                       = size(mdp.states,2);
% hp
max_search_iter         = mdp.max_search;
max_iter                = mdp.naive_il.max_iter;
temperature             = mdp.naive_il.init_temp;
p                       = mdp.naive_il.p;
temperature_mult_factor = mdp.naive_il.temp_mult;
stop_criterion          = mdp.naive_il.stop_criterion;
default_value           = mdp.naive_il.default_value;
alpha                   = mdp.naive_il.init_lr;
% allocate
deltas                  = zeros(max_iter,1);
cum_reward_per_episode  = zeros(max_iter,1);
delta                   = 10;
counts                  = ones(n,4); % counts for each state - learning rate tuning 
mini_batch_size         = 15;


%% init 
for i=1:n
    m = size(mdp.states(i).actions,2);
    for j=1:m
       if (mdp.states(i).terminal)
        mdp.states(i).actions(j).value = 0;                 % inits Q(s,a) for terminal states
       else
           mdp.states(i).actions(j).value = default_value;  % inits Q(s,a) for non terminal states 
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
        action_index = comply_or_defy_bern(pi_m(state_index),mdp.states(state_index).actions,temperature,p);
        
        lIter = 0;
        while(~mdp.states(state_index).terminal && lIter < max_search_iter)
            [next_state_index, reward] = follow_action(mdp, state_index,action_index);
            cum_reward = cum_reward + reward;
            next_action_index = comply_or_defy_bern(pi_m(next_state_index),mdp.states(next_state_index).actions,temperature,p);
            
            % update
            if (k>1) % avoid minibatch undesired visual effects 
                qvalue = mdp.states(state_index).actions(action_index).value;
                n_qvalue = mdp.states(next_state_index).actions(next_action_index).value;
                lrate = alpha/(counts(state_index,action_index)^(0.51));
                u_qvalue = (1-lrate)*qvalue + lrate*(reward + mdp.discount*n_qvalue);
                counts(state_index,action_index) = counts(state_index,action_index)+1;
                delta = max(delta,abs(u_qvalue-qvalue));
                qvalue = u_qvalue;
                mdp.states(state_index).actions(action_index).value = qvalue;
            end
            
            % update current step and action
            action_index = next_action_index;
            state_index = next_state_index;
            lIter = lIter +1;
        end
    end
    if (p<0.5)
        temperature = temperature*temperature_mult_factor;
    end
    deltas(k) = delta;
    cum_reward_per_episode(k) = cum_reward/mini_batch_size;
    k = k+1
    p = 0.99*p;
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
title('SARSA IRL solving of the MDP - Qvalues updates');
xlabel('$\log{(number\,of\,iterations)}$','Interpreter','latex');
ylabel('$\max_{minibatch}\left[\max_s{ \vert V_{k+1}(s)-V_k(s)\vert} \right]$','Interpreter','latex');
legend('Learning curve for policy value iteration');
% plot the rewards per episode averaged per minibatch
subplot(1,2,2);
plot(cum_reward_per_episode(1:k-1),'b','LineWidth',2); hold on;
mentor_cum_reward_per_episode = compute_average_return(mdp,pi_m,k-1); plot(1:k-1,mentor_cum_reward_per_episode,'g','LineWidth',2);
xlabel('Number of iterations');
ylabel('Average reward');
legend('Average reward per episode per minibatch','Greedy mentor average reward per episode per minibatch','Location','southeast');
title('SARSA IRL solving of the MDP - Averaged rewards per minibatch');

end
