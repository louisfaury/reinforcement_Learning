function [pi,mdp] = av_imitation_learning_off(pi_m, mdp)
%% <======================= HEADER =======================>
% @brief : This function implements the imitation based policy learning,
%          with action value approach
% @param : pi_star = mentor's policy
%          mdp = Markov Decision Process to be solved.
% @return : pi = derived optimal policy
%  <======================================================>


n                       = size(mdp.states,2);
% hp
max_search_iter         = mdp.max_search;
max_iter                = mdp.av_il.max_iter;
temperature             = mdp.av_il.init_temp;
temperature_mult_factor = mdp.av_il.temp_mult;
stop_criterion          = mdp.av_il.stop_criterion;
default_value           = mdp.av_il.default_value;
init_lr                 = mdp.av_il.init_lr;
ld_lr                   = mdp.av_il.ld_lr; 
t0                      = mdp.av_il.t0;
% allocate
deltas                  = zeros(max_iter,1);
cum_reward_per_episode  = zeros(max_iter,1);
delta                   = 10;
counts                  = ones(n,4);    % counts for each state - learning rate tuning 
mini_batch_size         = 15;

%% init
for i=1:n
    mdp.states(i).qd_value = mdp.av_il.qd_init_value;   % inits value of discarding
    mdp.states(i).ql_value = mdp.av_il.ql_init_value;   % inits value of listening
    
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
k = 1;
while (k<max_iter && delta>stop_criterion)
    delta = 0;
    cum_reward = 0;
    for j=1:mini_batch_size
        state_index = pick_random_state(mdp);
        count = sum(counts(state_index,:))-3;
       
        lIter = 0;
        while(~mdp.states(state_index).terminal && lIter < max_search_iter)
            ql = mdp.states(state_index).ql_value; qd= mdp.states(state_index).qd_value;
            [action_index,mentor_action_index] = comply_or_defy_sig(pi_m(state_index),mdp.states(state_index).actions,temperature,ql,qd,t0/(count^(0.55)),true);
            [next_state_index, reward] = follow_action(mdp, state_index,action_index);
            cum_reward = cum_reward + reward;
            count = sum(counts(next_state_index,:))-3;
            
            if (k>1) % avoiding minibatch weird effects for init                
                % mdp update
                n_qvalue = max([mdp.states(next_state_index).actions.value]);
                qvalue = mdp.states(state_index).actions(action_index).value;
                lrate = init_lr/(counts(state_index,action_index)^(0.51));
                u_qvalue = (1-lrate)*qvalue + lrate*(reward + mdp.discount*n_qvalue);
                counts(state_index,action_index) = counts(state_index,action_index)+1;
                delta = max(delta,abs(u_qvalue-qvalue));
                qvalue = u_qvalue;
                mdp.states(state_index).actions(action_index).value = qvalue;
                
                % A('l','d') update 
                if (action_index == mentor_action_index)
                   mdp.states(state_index).ql_value =  (1-ld_lr)*ql + ld_lr*qvalue;
                else
                    action_set_size = size(mdp.states(state_index).actions,2);
                    mdp.states(state_index).qd_value = (1-ld_lr)*qd + ld_lr*max([mdp.states(state_index).actions(1:action_set_size~=mentor_action_index).value]);
                end
            end
            % update current step and action
            state_index  = next_state_index;
            lIter = lIter +1;
        end
    end
    deltas(k) = delta;
    temperature = temperature*temperature_mult_factor;
    cum_reward_per_episode(k) = cum_reward/mini_batch_size;
    k = k+1
end

pi = generate_greedy_policy(mdp.states,counts);

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
