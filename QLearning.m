classdef QLearning
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        states;
        action;
        startNode;
        goalNode;  % Null here
    end
    
    methods
        function obj = QLearning()
            startNode = 1;
            iter = 1;
            nEpisode = 100;

            while(iter <= nEpisode)
                disp('*************************');
                str = ['Episode ',num2str(iter)];
                disp(str);
                
                
                
            
            
            
            
        end
        
        
    end
end

