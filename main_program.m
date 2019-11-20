%≤‚ ‘≥Ã–Ú
%picture 1
close all;
clear all;
clc;
bw1=binaried('rice.jpg');
[labeled_image1,~]=cca(bw1);
%picture 2
bw2=binaried('test2.png');
[labeled_image2,~]=cca(bw2);
