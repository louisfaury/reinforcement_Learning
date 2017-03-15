function [pi,mdp] = sarsa_lambda_solve_mdp(mdp)
%% <======================= HEADER =======================>
% @brief : This function solves the given MDP using the TD(lambda) algorithm applied to SARSA 
% @param : mdp = Markov Decision Process to be solved. 
% @return : pi = optimal policy given learned Q-values
%  <======================================================>

%% <======================= hyper-parameters =======================>
n = size(mdp.states,2);
% mdp fixed by user
max_iter                = mdp.sarsa_lambda.max_iter;
temperature             = mdp.sarsa_lambda.init_temp;
temperature_mult_factor = mdp.sarsa_lambda.temp_mult;
stop_criterion          = mdp.sarsa_lambda.stop_criterion;
default_value           = mdp.sarsa_lambda.default_value;
alpha                   = mdp.sarsa_lambda.init_lr;
lambda                  = mdp.sarsa_lambda.lambda;
eps                     = 5*1e-3;
% allocate
deltas = zeros(max_iter,1);
cum_reward_per_episode = zeros(max_iter,1);
delta = 10;
counts = ones(n,4); % counts for each state - learning rate tuning 
mini_batch_size = 15;
eligibility_traces = zeros(n,4);
% <======================================================>
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
        eligibility_traces = eligibility_traces*0;
        while(~mdp.states(state_index).terminal)
            next_state_index = follow_action(state_index,mdp.states(state_index).actions,action_index, mdp.transition_success_proba); 
            reward = mdp.states(next_state_index).reward;
            cum_reward = cum_reward + reward;
            next_action_index = softmax_random_pick(mdp.states(next_state_index).actions,temperature);
            eligibility_traces(state_index,action_index) = eligibility_traces(state_index,action_index)+1;
            
            % update
            qvalue = mdp.states(state_index).actions(action_index).value;
            n_qvalue = mdp.states(next_state_index).actions(next_action_index).value;
            delta = reward + mdp.discount*n_qvalue - qvalue;
            
            [ix,iy] = find(eligibility_traces>eps);
            for l=1:size(ix,1)
                lrate = alpha/(counts(ix(l),iy(l))^(0.51));
                mdp.states(ix(l)).actions(iy(l)).value =  mdp.states(ix(l)).actions(iy(l)).value + lrate*delta*eligibility_traces(ix(l),iy(l));
            end            
            eligibility_traces = eligibility_traces * lambda * mdp.discount;
            
            counts(state_index,action_index) = counts(state_index,action_index)+1;
            u_qvalue =  mdp.states(state_index).actions(action_index).value;
            delta = max(delta,abs(u_qvalue-qvalue));
            qvalue = u_qvalue;
            
            % update current step and action
            action_index = next_action_index;
            state_index = next_state_index;
        end
    end
    temperature = temperature*temperature_mult_factor;
    deltas(k) = delta;
    cum_reward_per_episode(k) = cum_reward/mini_batch_size;
    k = k+1
end

pi = generate_greedy_policy(mdp.states);  

% <==============================================================>
%
%
%% plots
figure('units','normalized','outerposition',[0 0 1 1]) 
% plot the changes in qvalues per minibatch
subplot(1,2,1);
plot(log(1:k-1),deltas(1:k-1),'r-.','LineWidth',1.5);
title('SARSA($\lambda$) Solving of the MDP - Qvalues updates','Interpreter','latex');
xlabel('$\log{(number\,of\,iterations)}$','Interpreter','latex');
ylabel('$\max_{minibatch}\left[\max_s{ \vert V_{k+1}(s)-V_k(s)\vert} \right]$','Interpreter','latex');
legend('Learning curve for policy value iteration');
% plot the rewards per episode averaged per minibatch
subplot(1,2,2);
plot(cum_reward_per_episode(1:k-1),'b','LineWidth',2);
xlabel('Number of iterations');
ylabel('Average reward');
legend('Average reward per episode per minibatch','Location','southeast');
title('SARSA($\lambda$) Solving of the MDP - Averaged rewards per minibatch','Interpreter','latex');

end