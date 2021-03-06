function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'row';
end

[h, w] = size(p);
height_map = zeros(h, w);
height_map2 = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        for m = 2 : h
            height_map(m,1) = height_map(m-1,1) + q(m,1);
        end
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
        for m = 1 : h
            for n = 2 : w
                height_map(m,n) = height_map(m,n-1) + p(m,n);
           end
        end

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        
        for n = 2 : w
            height_map(1,n) = height_map(1,n-1) + p(1,n);
        end
                
        for m = 1 : w
            for n = 2 : h
                height_map(n,m) = height_map(n-1,m) + q(n,m);
            end
        end

        % =================================================================
          
    case 'average'
        
        % =================================================================
        for m = 2 : h
            height_map(m,1) = height_map(m-1,1) + q(m,1);
        end
                
        for m = 1 : h
            for n = 2 : w
                height_map(m,n) = height_map(m,n-1) + p(m,n);
           end
        end
        
        for n = 2 : w
            height_map2(1,n) = height_map2(1,n-1) + p(1,n);
        end
                
        for m = 1 : w
            for n = 2 : h
                height_map2(n,m) = height_map2(n-1,m) + q(n,m);
            end
        end
        
        height_map = (height_map + height_map2) / 2 ;
        

        % =================================================================
end


end

