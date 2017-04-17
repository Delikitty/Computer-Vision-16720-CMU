function im3 = generatePanorama(im1, im2)


[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

[matches] = briefMatch(desc1, desc2);

nIter=2000;
tol=3;
[bestH] = ransacH(matches, locs1, locs2, nIter, tol);

[im3]=imageStitching_noClip(im1,im2,bestH);

imwrite(im3,'../results/q6_3.jpg');
end