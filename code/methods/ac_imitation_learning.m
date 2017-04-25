function [pi,mdp] = ac_imitation_learning(pi_m, mdp)
%% <======================= HEADER =======================>
% @brief : This function implements the imitation based policy learning,
%          with actor critic approach
% @param : pi_star = mentor's policy
%          mdp = Markov Decision Process to be solved.
% @return : pi = derived optimal policy
%  <======================================================>


n                       = size(mdp.states,2);
% hp
max_search_iter         = mdp.max_search;
max_iter                = mdp.ac_il.max_iter;
temperature             = mdp.ac_il.init_temp;
temperature_mult_factor = mdp.ac_il.temp_mult;
stop_criterion          = mdp.ac_il.stop_criterion;
default_value           = mdp.ac_il.default_value;
init_lr                 = mdp.ac_il.init_lr;
eps_t                   = mdp.ac_il.eps;

% allocate
deltas                  = zeros(max_iter,1);
cum_reward_per_episode  = zeros(max_iter,1);
delta                   = 10;
counts                  = ones(n,4);    % counts for each state - learning rate tuning 
mini_batch_size         = 15;

%% init
for i=1:n
    mdp.states(i).alpha = mdp.ac_il.init_alpha;                   % inits alpha(s)
    mdp.states(i).beta = mdp.ac_il.init_beta;                     % inits beta(s)
    
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
        alpha = mdp.states(state_index).alpha; beta  = mdp.states(state_index).beta;
        [action_index,mentor_action_index] = comply_or_defy_beta(pi_m(state_index),mdp.states(state_index).actions,temperature,alpha,beta,true);
       
        lIter = 0;
        while(~mdp.states(state_index).terminal && lIter < max_search_iter)
            [next_state_index, reward] = follow_action(mdp, state_index,action_index);
            cum_reward = cum_reward + reward;
            next_alpha = mdp.states(next_state_index).alpha; next_beta = mdp.states(next_state_index).beta;
            [next_action_index,next_mentor_action_index] = comply_or_defy_beta(pi_m(next_state_index),mdp.states(next_state_index).actions,temperature,next_alpha,next_beta,true);
            
            if (k>1) % avoiding minibatch weird effects for init
                % compliance update
                n_qvalue = mdp.states(next_state_index).actions(next_action_index).value;
                ddm = reward + mdp.discount*n_qvalue- mdp.states(state_index).actions(mentor_action_index).value;
                %ddm = reward + mdp.discount*n_qvalue - max([mdp.states(state_index).actions.value]);
                if (action_index==mentor_action_index)
                    mdp.states(state_index).alpha = max(0, alpha + eps_t*(beta/(alpha+beta))*sign(ddm));
                else
                    mdp.states(state_index).beta = max(0, beta + eps_t*(alpha/(alpha+beta))*sign(ddm));
                end
                
                % mdp update
                qvalue = mdp.states(state_index).actions(action_index).value;
                lrate = init_lr/(counts(state_index,action_index)^(0.505));
                u_qvalue = (1-lrate)*qvalue + lrate*(reward + mdp.discount*n_qvalue);
                counts(state_index,action_index) = counts(state_index,action_index)+1;
                delta = max(delta,abs(u_qvalue-qvalue));
                qvalue = u_qvalue;
                mdp.states(state_index).actions(action_index).value = qvalue;
            end
            % update current step and action
            action_index = next_action_index;
            state_index  = next_state_index;
            mentor_action_index = next_mentor_action_index;
            alpha = next_alpha; beta = next_beta;
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
