X_HOR = ['{['];
for i = 1:length(BLACKS_R)
    for j = 1:length(BLACKS_R{i})
        X_HOR = [X_HOR, num2str(BLACKS_R{i}(j)), ', '];
    end
    if i < length(BLACKS_R)
        X_HOR = [X_HOR, '],['];
    end
end
X_HOR = [X_HOR, ']}'];

X_VERT = ['{['];
for i = 1:length(BLACKS_C)
    for j = 1:length(BLACKS_C{i})
        X_VERT = [X_VERT, num2str(BLACKS_C{i}(j)), ', '];
    end
    if i < length(BLACKS_C)
        X_VERT = [X_VERT, '],['];
    end
end
X_VERT = [X_VERT, ']}'];