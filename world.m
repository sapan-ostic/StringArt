classdef world
    % Creates plot worlds for the string problem
    properties
        gridsize = 100;
        inputImage = imread('beardo.jpg');
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
            
            img = imresize(img,[obj.gridsize NaN]);
%             figure(2);
%             imshow(img);
            
            img = im2bw(img,0.5);
            figure(3);
            imshow(img);
            truesize([500 500]);
            
            obj.inputImage = img;
        end
    end
end

