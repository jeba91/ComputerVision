function  [f1, f2, matches] = keypoint_matching(im1, im2)

[f1, d1] = vl_sift(im1) ;
[f2, d2] = vl_sift(im2) ;

[matches, ~] = vl_ubcmatch(d1, d2) ;
end