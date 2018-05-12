function blobs = detectBlobsScaleFilter(im)
% DETECTBLOBS detects blobs in an image
%   BLOBS = DETECTBLOBSSCALEFILTER(IM, PARAM) detects multi-scale blobs in IM.
%   The method uses the Laplacian of Gaussian filter to find blobs across
%   scale space. This version of the code scales the filter and keeps the
%   image same which is slow for big filters.
% 
% Input:
%   IM - input image
%
% Ouput:
%   BLOBS - n x 4 array with blob in each row in (x, y, radius, score)
%
% This code is part of:
%
%   CMPSCI 670: Computer Vision, Fall 2014
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3: Blob detector

% 2018-02-15 EECS442 HW 3

% Convert the image to gray scale for better visibility
if size(im,3) > 1
    im = rgb2gray(im);
    im = im2double(im);
end
sigma1 = 2; % smallest sigma (lowest level)
k = 1.2; % geometric constant
n = 15; % number of levels
threshold = 0.005;
sigma = sigma1 * k.^(0:n-1);
[h,w] = size(im);

% initialize Scale Space
scaleSpace = zeros(h,w,n);
for i = 1:n
    hsize = 2*ceil(3*sigma(i)) + 1; % odd, be symmetric at current pixel
    L = sigma(i)^2*fspecial('log',hsize,sigma(i)); % normalized Laplacian
    % figure; % check window size
    % surf(L,'EdgeColor','none');
    % set(gcf,'units','points','position',[200,200,200,200])
    
    % squared Laplacian response
    scaleSpace(:,:,i) = imfilter(im,L,'same','replicate').^2;
end
blobs = nonmaximumSuppression(scaleSpace,sigma,threshold);
end
