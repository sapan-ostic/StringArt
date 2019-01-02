%%
clear all
clc

%% Create World
inputImage_ = imread('beardo.jpg');
Npins_ = 20;
gridSize_= 200;

world = World(gridSize_,inputImage_,Npins_);

workspace = world.workspace;
img_map = world.inputImage;
pinsInd = world.pinsInd;
circleInd = world.circleInd; 

%%
iPin = 1;
startNode = world.pinsInd(iPin); % beginning with first pin 

nActions = world.Npins -1;
nStates = world.Npins;
usePrevious = 0;

if(usePrevious==1)
    load('stringArt.mat');
else
    Q = -inf*ones(Npins_,Npins_);
    
end

alpha = 0.9;
gamma = 0.95;
nEpisode = 100;  % max number of episodes

visitedStates = zeros(nStates); % Symmetric matrix with all diag elements 0
visitedStates(logical(eye(size(visitedStates)))) = inf;

endEpisode = false;
currentNode = startNode;
iter = 1;
Action_ = [];
prev_Actions = [];
convergence = 0;

while(iter <= nEpisode)
    disp('*************************');
    str = ['Episode ',num2str(iter)];
    disp(str);
    
    % finding the pins that ain't connected from current iPin 
    [freePins,~] = ind2sub([gridSize_,gridSize_],find(visitedStates(iPin,:)==0));
   
    if(isempty(freePins))
        break;
    end
    
    [nextNode,reward] = newState(currentNode,action);
    nextPin = freePins(1);
    
    
    
    
end


