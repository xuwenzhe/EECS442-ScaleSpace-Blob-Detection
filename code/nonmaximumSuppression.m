function blobs = nonmaximumSuppression(scaleSpace,sigma,threshold)
% 2018-02-15 EECS 442 HW 3
% two callers: detectBlobsScaleFilter, detectBlobsScaleImage

[h,w,n] = size(scaleSpace);
% Nonmaximal suppression across PIXELS
nmaxsup = zeros(h,w,n);
for i = 1:n
    % take the max value in the 3x3 filter window as current pixel value
    nmaxsup(:,:,i) = ordfilt2(scaleSpace(:,:,i),9,ones(3)); % fastest
    % nmaxsup(:,:,i) = colfilt(scaleSpace(:,:,i),[3 3], 'sliding', @max);
    % fun = @(x) max(max(x));
    % nmaxsup(:,:,i) = nlfilter(scaleSpace(:,:,i),[3 3],fun);
end

% Nonmaximal suppression across SCALES (neighbour level, scanning max)
for i = 1:n
    nmaxsup(:,:,i) = max(nmaxsup(:,:,max(1,i-1):min(n,i+1)),[],3);
end
nmaxsup = nmaxsup .* (nmaxsup == scaleSpace);
% tmp = zeros(h,w,n);
% for i = 1:n
%     tmp(:,:,i) = max(nmaxsup(:,:,max(1,i-1):min(n,i+1)),[],3);
% end
% nmaxsup = tmp .* (tmp == scaleSpace);
% check threshold
blobs = [];
for i=1:n
    current_level = nmaxsup(:,:,i);
    [r,c] = find(current_level >= threshold);
    idx = sub2ind(size(current_level),r,c);
    blobs = [blobs; c,r,ones(length(c),1)*sigma(i)*sqrt(2),current_level(idx)];
end
[numblobs,~] = size(blobs);
if numblobs < 1000
    fprintf('number of blobs: %d (< 1000), try a smaller threshold :p\n',numblobs);
end
end

