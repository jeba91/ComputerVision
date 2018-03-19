function [V] = LK(im1, im2, regionsize, list1, list2)
    %With 3 parameter input a matrix V is returned with the section values
    %With 5 parameter input a list V is returned with values per
    %coordinate, also this list is plotted on the current figure

    %Only even region size for LK algorithms (So there is a middle)
    if mod(regionsize,2) == 0
        "no even numbers for regionsize"
        return
    end
    
    %Convert images to doubles
    im1 = (im2double(im1));
    im2 = (im2double(im2));
    
    %If there are 2 lists given, plot these on the image
    if exist('list1') == 1 && exist('list2') == 1
        V = zeros(2, length(list1));
        for m = 1:length(list1)
            %Get Vy and Vx for every given coordinate
            V(:,m) = LucasKanade(im1,im2,regionsize,[list1(m),list2(m)]);
        end
        %Plot Vy and Vx
        quiver(list2,list1,V(1,:),V(2,:));
    %Else create V matrix with every value for every non overlapping region
    else
        if mod(size(im1,1),regionsize) ~= 0
            end_m = (size(im1,1) - mod(size(im1,1),regionsize)) - regionsize+1;
            end_n = (size(im1,2) - mod(size(im1,2),regionsize)) - regionsize+1;
        else
            end_m = size(im1,1)-(regionsize+2)
            end_n = size(im1,2)-(regionsize+2)
        end

        gridsize = (size(im1,1) - mod(size(im1,1),regionsize)) / regionsize;
        V=zeros(gridsize,gridsize,2);
           
        %Get every Vx Vy for the V matrix
        for m = 1:regionsize:end_m
            for n = 1:regionsize:end_n

                half = ((regionsize - mod(regionsize,2)) / 2);

                v = LucasKanade(im1,im2,regionsize,[m+half,n+half]);

                x = uint8((m-1)/regionsize)+1;            
                y = uint8((n-1)/regionsize)+1;

                V(x,y,1) = v(1);
                V(x,y,2) = v(2);           
            end
        end
    end
end

function [v] = LucasKanade(image1, image2, regionsize, centerpoint)
    %Calculate the LK value for a specific centerpoint
    [Gx, Gy] = gradient(fspecial('gaussian', 15, 1.5));
    Ix = conv2(image1, Gx, 'same');
    Iy = conv2(image2, Gy, 'same');
    It = image2 - image1;
    
    start_i = centerpoint(1) - ((regionsize - mod(regionsize,2)) / 2);
    start_j = centerpoint(2) - ((regionsize - mod(regionsize,2)) / 2);
    
    A=zeros((regionsize^2),2);
    b=zeros((regionsize^2),1);
    
    counter = 1;
    
    %Loop through all the pixels of the region and fill the A and b
    for i = start_i:start_i+regionsize
        for j = start_j:start_j+regionsize
            A(counter,1) = Ix(i,j);
            A(counter,2) = Iy(i,j); 
            b(counter,1) = -It(i,j);
            counter = counter + 1;
        end
    end
    
    %Calculate the v value from the A and b
    v = (inv(transpose(A)*A))*(transpose(A)*b);   
end