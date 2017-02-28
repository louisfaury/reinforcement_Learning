function draw_mdp(mdp_states)
% @brief : draws the state space of the mdp and rewards function
% @param : state space of the mdp
figure('units','normalized','outerposition',[0 0 1 1])

n = size(mdp_states,2);
hold on;

for i=1:n
    pos = mdp_states(i).coord;
    face_color = [0.95,0.95,0.95];
    fontweight = 'normal';
    if (mdp_states(i).reward > 0)
        face_color = [0.9,0.1,0.1];
        fontweight = 'bold';
    end
    if (mdp_states(i).reward <= -1)
        face_color = [0.1,0.1,0.1];
        fontweight = 'bold';
    end
    rectangle('Position',[pos(1)-0.5,pos(2)-0.5,1,1],'FaceColor',face_color);
    text(pos(1)+0.1,pos(2)+0.4,num2str(mdp_states(i).reward),'FontSize',6,'FontWeight',fontweight);
end

axis square;
axis([-6,6,-6,6]);

title('Grid world MDP');
end