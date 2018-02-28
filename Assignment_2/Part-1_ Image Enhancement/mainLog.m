I    = imread('image2.jpg');

imshow(compute_LoG(I, 1))
title('Laplacian')
saveas(gcf,'lap.png')

imshow(compute_LoG(I, 2))
title('LoG')
saveas(gcf,'log.png')

imshow(compute_LoG(I, 3))
title('DoG')
saveas(gcf,'dog.png')