classdef World
    % Creates plot worlds for the string problem
    properties
        gridsize
        inputImage;
        workspace;
        Npins; 
        radius;
        pinsInd;
        circleInd;
        centre;
        cmap;
    end
    
    methods
        %% Contructor
        function obj = World(gridsize_,inputImage_,Npins_)
            if(nargin<4)
                inputImage_ = imread('beardo.jpg');
                Npins_ = 20;
                gridsize_ = 200;
            end                  
            
            % Setting properties
            obj.gridsize = gridsize_;
            obj.inputImage = inputImage_;
            obj.Npins = Npins_;
            obj.centre = round(obj.gridsize/2);
            obj.radius = ceil(obj.gridsize*0.45);
            
            % Calling methods
            obj = get_ws(obj);
            obj = get_pins(obj); 
            
            figure(3);
            subplot(1,2,1);
            image(obj.inputImage);
            title('Original Image');
            truesize([400 400]);
            axis equal
                        
            subplot(1,2,2);
            image(obj.workspace);
            title('Formed Image');
%             grid on;
            axis equal
        end
        
        %% Get Workspace
        function obj = get_ws(obj)
            % Processing Input Image
            img = obj.inputImage;
            img = imresize(img,[obj.gridsize NaN]); % resizing to gridsize
            img = im2bw(img,0.5);
            img = imcomplement(img);
            obj.inputImage = img;
            
            % set up color map for display
            % 1 - white - clear cell
            % 2 - black - obstacle
            % 3 - red = visited
            
            obj.cmap = [1.0000 1.0000 1.0000;...
                        0.0000 0.0000 0.0000;...    
                        0.8500 0.3250 0.0980];
            
            colormap(obj.cmap);
                       
            obj.workspace = ones(obj.gridsize,obj.gridsize);
            plot_obj = Plotter;
            plot_obj = plot_obj.circle(obj.centre,obj.centre,obj.radius);
            circleXY = plot_obj.circleXY; % XY coordinates of circle
            obj.circleInd = sub2ind(size(obj.workspace),circleXY(:,1),circleXY(:,2));
            obj.workspace(obj.circleInd) = 2;
        end
        
        %% Get Pins
        function obj = get_pins(obj)
            [N,~] = size(obj.circleInd);
            Pins_index = ceil(1:N/obj.Npins:N);  
            obj.pinsInd = obj.circleInd(Pins_index);         
            [PinsX,PinsY] = ind2sub(size(obj.workspace),obj.pinsInd);
            for i = 1:obj.Npins
                plot_obj = Plotter;
                plot_obj = plot_obj.circle(PinsX(i,1),PinsY(i,1),2);
                circleXY = plot_obj.circleXY; % XY coordinates of circle
                obj.circleInd = sub2ind(size(obj.workspace),circleXY(:,1),circleXY(:,2));
                obj.workspace(obj.circleInd) = 3;
          
            end
             
       end
        
    end
end

