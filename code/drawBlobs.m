function drawBlobs(im, blobs, nmax)
% DRAWBLOBS overlays the image with blobs as circles
%   DRAWBLOBS(IM, BLOBS, THRESHOLD) overalys IM converted to a grayscale
%   image with BLOBS that are above a THRESHOLD. If THRESHOLD is not
%   specified it is set to 0. 
%
% Input:
%   IM - the image (if rgb image is provided it is converted to grayscale)
%   BLOBS - n x 4 matrix with each row is a blob (x, y, radius, score) 
%   THRESHOLD - only blobs above this are shown (default = 0)
%
% This code is part of:
%
%   CMPSCI 670: Computer Vision, Fall 2014
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3: Blob detector

% If threshold is not specified, set it to 0
if nargin < 3
    nmax = size(blobs,1);
end
nmax = min(nmax, size(blobs,1));

% Convert the image to gray scale for better visibility
if size(im, 3) > 1
    im = rgb2gray(im);
end

figure;
imshow(im); hold on;

% Loop over points and draw circles
if nmax < 1, 
    return; % no blobs
end

[~,ord] = sort(-blobs(:,4));
theta = linspace(0, 2*pi, 24);
for i = 1:nmax, 
    r = blobs(ord(i),3);
    plot(blobs(ord(i),1) + r*cos(theta), blobs(ord(i),2) + r*sin(theta), 'r-', 'linewidth',2);
end