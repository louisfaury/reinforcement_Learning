function draw_mdp(mdp)
% @brief : draws the state space of the mdp and rewards function
% @param : state space of the mdp
figure('units','normalized','outerposition',[0 0 1 1])

n = size(mdp.states,2);
hold on;
max_reward = max([mdp.states.reward]);

for i=1:n
    pos = mdp.states(i).coord;
    face_color = [0.95,0.95,0.95];
    fontweight = 'normal';
    reward = mdp.states(i).reward;
    if (reward > 0)
        if (reward==max_reward)
            face_color = [0.9,0.1,0.1];
        else
            face_color = [0.9,0.6,0.2];
        end
        fontweight = 'bold';
    end
    if (reward <= -1)
        face_color = [0.1,0.1,0.1];
        fontweight = 'bold';
    end
    if (any(mdp.force_start==i))
        face_color = [0.1,0.9,0.1];
    end
    rectangle('Position',[pos(1)-0.5,pos(2)-0.5,1,1],'FaceColor',face_color);
    text(pos(1)+0.1,pos(2)+0.4,num2str(mdp.states(i).reward),'FontSize',2,'FontWeight',fontweight);
end

axis square;
axis([-16,16,-16,16]);

title('Grid world MDP');
end