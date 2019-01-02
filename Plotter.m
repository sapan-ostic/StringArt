classdef Plotter
    
    properties
        lineXY;
        circleXY
    end
    
    methods
        %%
        function obj = line(obj,p1,p2)
            x1 = round(p1(1)); x2=round(p2(1));
            y1 = round(p1(2)); y2=round(p2(2));
            dx = abs(x2-x1);
            dy = abs(y2-y1);
            steep = abs(dy)>abs(dx);
            
            if steep t = dx;dx=dy;dy=t; end
            if dy == 0
                q = zeros(dx+1,1);
            else
                q = [0;diff(mod((floor(dx/2):-dy:-dy*dx+floor(dx/2))',dx))>=0];
            end
            
            if steep
                if y1<=y2 y=[y1:y2]'; else y=[y1:-1:y2]'; end
                if x1<=x2 x=x1+cumsum(q);else x=x1-cumsum(q); end
            else
                if x1<=x2 x=[x1:x2]'; else x=[x1:-1:x2]'; end
                if y1<=y2 y=y1+cumsum(q);else y=y1-cumsum(q); end
            end
            obj.lineXY = [x,y];
            
        end
        
        %%
        function obj = circle(obj,xc,yc,r)
            pk= 5/4-r;
            obj.circleXY = [0,r];
            x = 0;
            y = r;
            
            while(x < y)
                if pk>0
                    x = x+1;
                    y = y-1;
                    pk = pk+2*x+1-2*y;
                else
                    pk = pk + 2*x +1;
                    x = x+1;
                end
                obj.circleXY = [obj.circleXY;[x,y]];
            end
            
            oct = obj.circleXY;
            [N,~] = size(obj.circleXY);
            
            for i = N-1:-1:1
                obj.circleXY = [obj.circleXY;[oct(i,2),oct(i,1)]];
            end
            
            quat = obj.circleXY;
            [N,~] = size(obj.circleXY);
            
            for i = N-1:-1:1
                obj.circleXY = [obj.circleXY;[quat(i,1),-quat(i,2)]];
            end
            
            half = obj.circleXY;
            [N,~] = size(obj.circleXY);
            
            for i = N-1:-1:1
                obj.circleXY = [obj.circleXY;[-half(i,1),half(i,2)]];
            end
            
            [N,~] = size(obj.circleXY);
            
            obj.circleXY = obj.circleXY+[xc*ones(N,1),yc*ones(N,1)];
            obj.circleXY = obj.circleXY(1:end-1,:);
        end
    end
end

