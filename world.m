classdef world
    % Creates plot worlds for the string problem
    properties
        gridsize = 100;
        inputImage = imread('beardo.jpg');
        workspace;
        Npins = 20;       
    end
    
    methods
        function obj = world()
            obj = getImage(obj);
        end
        
        % Thresholding image
        function obj = getImage(obj)
            img = obj.inputImage();
%             figure(1);
%             imshow(img);
            
            img = imresize(img,[obj.gridsize NaN]); % resizing to gridsize
%             figure(2);
%             imshow(img);
            
            img = im2bw(img,0.5);
            figure(3);
            subplot(1,2,1);
            image(img);
            truesize([400 400]); %changing display size 

            obj.workspace = ones(obj.gridsize,obj.gridsize,3);
            figure(3);
            subplot(1,2,2);
            axis equal
            obj.workspace(10,10,1:3) = 0;
            % set up color map for display
            % 1 - white - clear cell
            % 2 - black - obstacle
            % 3 - red = visited
            % 4 - blue  - on list
            % 5 - green - start
            % 6 - yellow - destination
            % 7 - Traced Path
            % 8 - Pit
            
            cmap = [0,0,0;...
                1.0000,1.0000,1.0000; ...  
                0.8500,0.3250,0.0980; ...
                0.0000,0.4470,0.7410; ...
                0.4660,0.6740,0.1880; ...
                0.9290,0.6940,0.1250; ...
                0.6350,0.0780,0.1840;...
                0.4940,0.1840,0.5560];

            colormap(cmap);
            image(obj.workspace);
            grid on;
            axis equal
        end
    end
end

