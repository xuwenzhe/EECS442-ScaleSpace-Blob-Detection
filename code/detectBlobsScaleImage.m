function blobs = detectBlobsScaleImage(im)
% DETECTBLOBS detects blobs in an image
%   BLOBS = DETECTBLOBSCALEIMAGE(IM, PARAM) detects multi-scale blobs in IM.
%   The method uses the Laplacian of Gaussian filter to find blobs across
%   scale space. This version of the code scales the image and keeps the
%   filter same for speed. 
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

% keep the filter same
hsize = 2*ceil(3*sigma1) + 1; % odd, be symmetric at current pixel
L = sigma1^2*fspecial('log',hsize,sigma1); % normalized Laplacian
% figure;surf(L); % check window size
imcopy = im;
for i = 1:n
    itpl_method = 'lanczos3';
    % squared Laplacian response, upsample
    scaleSpace(:,:,i) = imresize(imfilter(imcopy,L,'same','replicate').^2,...
        size(im),itpl_method);
    % downsample
    imcopy = imresize(im,1/(k^i),itpl_method);
end
blobs = nonmaximumSuppression(scaleSpace,sigma,threshold);
end