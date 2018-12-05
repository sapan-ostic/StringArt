classdef World
    % Creates plot worlds for the string problem
    properties
        gridsize
        inputImage;
        workspace;
        Npins; 
        radius;
        PinsXY;
        circleXY;
        centre;
        cmap;
    end
    
    methods
        %% Contructor
        function obj = World(gridsize_,inputImage_,Npins_)
            if(nargin<4)
                inputImage_ = imread('beardo.jpg');
                Npins_ = 20;
                gridsize_ = 100;
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
        end
        
        %% Get Workspace
        function obj = get_ws(obj)
            % Processing Input Image
            img = obj.inputImage;
            img = imresize(img,[obj.gridsize NaN]); % resizing to gridsize
            img = im2bw(img,0.5);
            obj.inputImage = img;
            
            % set up color map for display
            % 0 - white - clear cell
            % 1 - black - obstacle
            % 2 - red = visited
            
            obj.cmap = [0.0000 0.0000 0.0000;...
                    1.0000 1.0000 1.0000; ...
                    0.8500 0.3250 0.0980];
                
            colormap(obj.cmap);
            figure(3);
            subplot(1,2,1);
            image(img);
            truesize([400 400]); 
            
            
            obj.workspace = ones(obj.gridsize,obj.gridsize);
            plot_obj = Plotter;
            plot_obj = plot_obj.circle(obj.centre,obj.centre,obj.radius);
            obj.circleXY = plot_obj.circleXY; 
            [N,~] = size(obj.circleXY);
            
            for i =1:N
                obj.workspace(obj.circleXY(i,1),obj.circleXY(i,2)) = 0;
            end

            subplot(1,2,2);
            image(obj.workspace);
            grid on;
            axis equal
        end
        
        %% Get Pins
        function obj = get_pins(obj)
            [N,~] = size(obj.circleXY);
            Pins = ceil(1:N/obj.Npins:N);  
            obj.PinsXY = [obj.circleXY(Pins,1),obj.circleXY(Pins,2)];
            
            
            for i = 1:obj.Npins
%                obj.PinsXY(i,1) = obj.centre + round(obj.radius*cos(2*pi*i/obj.Npins));
%                obj.PinsXY(i,2) = obj.centre + round(obj.radius*sin(2*pi*i/obj.Npins));
               obj.workspace = insertShape(obj.workspace,'FilledCircle',[obj.PinsXY(i,1) obj.PinsXY(i,2) 2],...
                'Color',obj.cmap(3,:),'SmoothEdges',false);
            
           end 
           
%            plot_obj = plotter;
%            plotXY = plot_obj.line([obj.PinsXY(1,1:2)],[obj.PinsXY(5,1:2)]);
%            lineXY = plotXY.lineXY;
%            [N,~] = size(lineXY);
%            for i = 1:N
%                obj.workspace(lineXY(i,1),lineXY(i,2),1:3) = zeros(1,3);
%            end
           image(obj.workspace);
        end
        
    end
end

