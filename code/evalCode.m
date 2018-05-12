% Evaluation code for blob detector
%
% Your goal is to implement the laplacian of the gaussian blob detector 
%
%
% This code is part of:
%
%   CMPSCI 670: Computer Vision, Fall 2014
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3: Blob detector

imageName = 'butterfly.jpg'; %butterfly.jpg, einstein.jpg, fishes.jpg, sunflowers.jpg
%imageName = 'einstein.jpg';
%imageName = 'fishes.jpg';
%imageName = 'sunflowers.jpg';

dataDir = fullfile('..','data');
im = imread(fullfile(dataDir, imageName));

%% Implement the code to detect blobs here
% First implement a version that scales the filter and applies on the
% image
tic;
blobs1 = detectBlobsScaleFilter(im);
toc;

size(blobs1)

% Now implement a version that scales the image
tic;
blobs2 = detectBlobsScaleImage(im);
toc;

size(blobs2)

%% Draw blobs on the image
numBlobsToDraw = 1000;
drawBlobs(im, blobs1, numBlobsToDraw);
title('Blob detection: scale filter');

drawBlobs(im, blobs2, numBlobsToDraw);
title('Blob detection: scale image');