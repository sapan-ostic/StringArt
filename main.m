%%
clear all
clc

%% Create World
inputImage_ = imread('beardo.jpg');
Npins_ = 20;
gridSize_= 100;

world = World(gridSize_,inputImage_,Npins_);

%%

