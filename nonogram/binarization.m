clear all
close all
clc
A = imread('dziadek3.jpg');
%A = imrotate(A, 90);
scale = 1/15;
B = imresize(A, scale);
number_of_colors = 2;
X = [];
tresh = 230;
C = [];
% Segmentation (kmeans)
for i = 1:size(B,1)
    for j = 1:size(B,2)
        CC(i,j,1) = B(i,j,1)+B(i,j,2)+B(i,j,3)/3;
        if (B(i,j,1)+B(i,j,2)+B(i,j,3))/3 > tresh
            X(i,j,1) = 1;
            X(i,j,2) = 1;
            X(i,j,3) = 1;
        else
            X(i,j,1) = 0;
            X(i,j,2) = 0;
            X(i,j,3) = 0;
        end
    end
end
X = CC>tresh
imshow(X)
% Vectors (rows)
M = {};
COLORS = {};
for i = 1:size(X,1)
    N = [];
    number = 1;
    v = X(i,:);
    last = v(1);
    V = last;
    for j = 2:length(v)
        new = v(j);
        if new ~= V(length(V))
            V = [V, new];
            N = [N, number];
            number = 1;
        else
            number = number + 1;
        end
    end
    N = [N, number];
    V,N,
    M{i} = N;
    COLORS{i} = V;
end
figure(2)
BLACKS_R = {};
for i = 1:length(M)
    vv = M{i};
    cc = im2double((1-COLORS{i}))*255/(number_of_colors-1);
    blacks = [];
    for j = 1:length(vv)
        text(j,-i,num2str(vv(j)));
        if cc(j) == 0
            blacks = [blacks,vv(j)];
        end
    end
    BLACKS_R{i} = blacks;
end
axis([-1,13,-75,1])

% Vectors (columns)
M = {};
COLORS = {};
for i = 1:size(X,2)
    N = [];
    number = 1;
    v = X(:,i);
    last = v(1);
    V = last;
    for j = 2:length(v)
        new = v(j);
        if new ~= V(length(V))
            V = [V, new];
            N = [N, number];
            number = 1;
        else
            number = number + 1;
        end
    end
    N = [N, number];
    V,N,
    M{i} = N;
    COLORS{i} = V;
end
figure(4)
BLACKS_C = {};
for i = 1:length(M)
    vv = M{i};
    cc = im2double((1-COLORS{i}))*255/(number_of_colors-1)
    blacks = [];
    for j = 1:length(vv)
        text(i,-j,num2str(vv(j)));
        if cc(j) == 0
            blacks = [blacks,vv(j)];
        end
    end
    BLACKS_C{i} = blacks;
end
axis([-1,40,-10,1])

% Increase in size of pixels (make a function of this to show images in zoomed form)
figure(3)
S = size(X);
scl = 1/scale/4;
C = zeros(scl*S(1),scl*S(2),'uint8');
for i = 1:scl*S(1)
    for j = 1:scl*S(2)
        C(i,j) = X(ceil(i/scl), ceil(j/scl));
    end
end
%imshow(C,map);