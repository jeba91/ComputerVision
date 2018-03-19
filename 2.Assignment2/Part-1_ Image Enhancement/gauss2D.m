function G = gauss2D( sigma , kernel_size )
    %% solution
    x = gauss1D(sigma, kernel_size);
    G = conv2(x, x');
end