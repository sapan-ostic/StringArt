classdef world
    % Creates plot worlds for the string problem
    properties
        gridsize = 50;
        inputImage = imread('beardo.jpg');
        workspace;
        Npins = 20; 
        radius;
        PinsXY;
        centre;
    end
    
    methods
        function obj = world()
            obj.centre = obj.gridsize/2;
            obj.radius = obj.gridsize*0.45;
            obj = get_ws(obj);
            obj = get_pins(obj);
            
        end
        
        % Thresholding image
        function obj = get_ws(obj)
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
            
            img = obj.inputImage();
            img = imresize(img,[obj.gridsize NaN]); % resizing to gridsize
            img = im2bw(img,0.5);
            
            figure(3);
            subplot(1,2,1);
            image(img);
            truesize([400 400]); 
            
            obj.workspace = ones(obj.gridsize,obj.gridsize,3);
            plot_obj = plotter;
            plot_obj = plot_obj.circle(obj.centre,obj.centre,obj.radius);
            circleXY = plot_obj.circleXY; 
            [N,~] = size(circleXY);
            
            for i =1:N
                obj.workspace(circleXY(i,1),circleXY(i,2),1:3) = [0,0,0];
            end
            %     image(img);
            % % plot(circleXY(:,1),circleXY(:,2));
            
%             obj.workspace = insertShape(obj.workspace,'circle',[obj.centre obj.centre obj.radius],...
%                 'Color',[0.0000,0.0000,0.0000],'SmoothEdges',false);
            subplot(1,2,2);
            colormap(cmap);
            image(obj.workspace);
            grid on;
            axis equal
        end
        
        function obj = get_pins(obj)
           for i = 1:obj.Npins
               x(i) = obj.centre + round(obj.radius*cos(2*pi*i/obj.Npins));
               y(i) = obj.centre + round(obj.radius*sin(2*pi*i/obj.Npins));
               obj.workspace = insertShape(obj.workspace,'FilledCircle',[x(i) y(i) 2],...
                'Color',[0.8500,0.3250,0.0980],'SmoothEdges',false);
           end 
           
           plot_obj = plotter;
           plotXY = plot_obj.line([x(1),y(1)],[x(5),y(5)]);
           lineXY = plotXY.lineXY;
           [N,~] = size(lineXY);
           for i = 1:N
               obj.workspace(lineXY(i,1),lineXY(i,2),1:3) = zeros(1,3);
           end
           image(obj.workspace);
           obj.PinsXY = [x',y'];
        end
    end
end

