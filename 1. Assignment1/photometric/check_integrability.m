function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros(size(normals,1), size(normals, 2));
q = zeros(size(normals,1), size(normals, 2));
% SE = zeros(size(normals,1), size(normals, 2));
[h, w, ~] = size(normals) ;
% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

for m = 1 : h
    for n = 1 : w
        p(m,n) = normals(m,n,1) / normals(m,n,3);
        q(m,n) = normals(m,n,2) / normals(m,n,3);
    end
end

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE


dp = [zeros(h,1), diff(p,1,2)];
dq = [zeros(h,1), diff(q,1,2)];

SE = (dp - dq).^2;
% ========================================================================




end

