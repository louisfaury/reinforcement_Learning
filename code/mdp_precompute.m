%% Precompute the given MDPs needed for the project 
%  This script computes the following mdps needed for the project
%  (discount and transition probabilities are supposed to be user specified)
%  The computed mdp's are 
clear all;
close all; 
clc; 

%% Basic 2d-grid
horizontal_span = -20:20;
vertical_span = -20:20; 
[Y,X] = meshgrid(horizontal_span, vertical_span);
[n,m] = size(X);

for i=1:n
    for j=1:m
        action_no = 0;
        states(m*(i-1)+j).coord = [X(i,j),Y(i,j)];
        states(m*(i-1)+j).actions = {};
        states(m*(i-1)+j).reward = -0.1;
        states(m*(i-1)+j).terminal = false;
        states(m*(i-1)+j).obstacle = false;
        if (i~=1)
            action_no = action_no+1;
            states(m*(i-1)+j).actions(action_no).name = 'left';
        end
        if (i~=n)
            action_no = action_no+1;
            states(m*(i-1)+j).actions(action_no).name ='right';
        end
        if (j~=1)
            action_no = action_no+1;
            states(m*(i-1)+j).actions(action_no).name ='down';
        end
        if (j~=m)
            action_no = action_no+1;
            states(m*(i-1)+j).actions(action_no).name ='up';
        end
        if (m*(i-1)+j == m*n)
            states(m*(i-1)+j).reward = 1;
            states(m*(i-1)+j).terminal = true;
        end
    end
end
save('./stored_mdps/free_grid_2d.mat','states');

%% 2d- grid with obstacles
for i=440:455
    states(i).reward = -5;
    states(i).obstacle = true;
end
save('./stored_mdps/obstacle_grid_2d.mat','states');


%% Several obstacle grid 
for i=440:455
    states(i).reward = -0.1; states(i).obstacle = false;
end
states(m*n).reward = -0.1; states(m*n).terminal = false;
states((m*n-1)/2+1).reward = 10; states((m*n-1)/2+1).terminal = true; 

obs_start_points = [127,149,1029,1051];
for k = obs_start_points
    for i=1:13
        for j=1:13
            states(k + (j-1)+(i-1)*41).reward = -5; states(k + (j-1)+(i-1)*41).obstacle = true;
        end
    end
end

save('./stored_mdps/maze_2d.mat','states');