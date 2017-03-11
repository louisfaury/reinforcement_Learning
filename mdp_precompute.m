%% Precompute the given MDPs needed for the project 
%  This script computes the following mdps needed for the project
%  (discount and transition probabilities are supposed to be user specified)
%  The computed mdp's are 
clear all;
close all; 
clc; 

%% Basic 2d-grid
horizontal_span = -15:15;
vertical_span = -15:15; 
[Y,X] = meshgrid(horizontal_span, vertical_span);
[n,m] = size(X);

for i=1:n
    for j=1:m
        action_no = 0;
        states(m*(i-1)+j).coord = [X(i,j),Y(i,j)];
        states(m*(i-1)+j).actions = {};
        states(m*(i-1)+j).reward = -0.1;
        states(m*(i-1)+j).terminal = false;
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
for i=58:64
    states(i).reward = -5;
    states(i).terminal = true;
end
save('./stored_mdps/obstacle_grid_2d.mat','states');


%% Maze for several rewards 
for i=58:64
    states(i).reward = -0.1;
    states(i).terminal = false;
end
for i=34:42
    states(i).reward = -5;
    states(i).terminal = true;
end
for i=58:62
    states(i).reward = -5;
    states(i).terminal = true;
end

states(45).reward = 10; states(45).terminal = true;
states(46).reward = -5; states(46).terminal = true;
states(47).reward = -5; states(47).terminal = true;
states(48).reward = -5; states(48).terminal = true;
states(49).reward = -5; states(49).terminal = true;
states(73).reward = -5; states(73).terminal = true;
states(84).reward = -5; states(84).terminal = true;
states(95).reward = -5; states(95).terminal = true;
states(50).reward = 2; states(50).terminal = true;
states(m*n).reward = -0.1; states(m*n).terminal = false;

save('./stored_mdps/maze_2d.mat','states');