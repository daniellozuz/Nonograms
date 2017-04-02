clear all
close all
clc
A = imread('Sylwusia.jpg');
A = imrotate(A, 90);
scale = 1/40;
B = imresize(A, scale);
number_of_colors = 2;

% Segmentation (kmeans)
MAP = [];
for i = 1:number_of_colors
    MAP = [MAP; (number_of_colors - i)/(number_of_colors - 1) (number_of_colors - i)/(number_of_colors - 1) (number_of_colors - i)/(number_of_colors - 1)];
end
[X,map]= rgb2ind(B,MAP,'nodither');
figure, imshow(X,map);

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
txt1 = num2str(5);
text(0,0,txt1,'Color','red')

for i = 1:length(M)
    vv = M{i};
    cc = im2double((1-COLORS{i}))*255/(number_of_colors-1)
    for j = 1:length(vv)
        text(j,-i,num2str(vv(j)),'Color',[cc(j),cc(j),cc(j)]);
    end
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
for i = 1:length(M)
    vv = M{i};
    cc = im2double((1-COLORS{i}))*255/(number_of_colors-1)
    for j = 1:length(vv)
        text(i,-j,num2str(vv(j)),'Color',[cc(j),cc(j),cc(j)]);
    end
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
imshow(C,map);