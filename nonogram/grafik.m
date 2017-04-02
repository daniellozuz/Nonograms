figure
plot(0,0)
grid on
axis([-10 S(2) 0 S(1)+10])
axis equal
x = -10:S(2);
set(gca,'XTick',x)
y = 0:(S(1)+10);
set(gca,'YTick',y)
set(gca, 'XColor', [0.9,0.9,0.9])
set(gca, 'YColor', [0.9,0.9,0.9])

line([0, 0],[0,S(1)],'LineWidth', 2);
line([0, S(2)],[0,0],'LineWidth', 2);
line([S(2), S(2)],[0,S(1)],'LineWidth', 2);
line([0, S(2)],[S(1),S(1)],'LineWidth', 2);

% every 5
i = 5;
while i<S(2)
    line([i, i],[0,S(1)],'Color', [0.9,0.9,0.9]);
    i = i + 5;
end

i = 5;
while i<S(1)
    line([0, S(2)],[i,i],'Color', [0.9,0.9,0.9]);
    i = i + 5;
end

% columns
ver = []
for i = 1:S(2)
    v = BLACKS_C{i};
    if length(v) > 0
        ver = [ver,'['];
        for j = 1:length(v)
            text((i-1)+0.1,S(1)+0.5+length(v)-j,num2str(v(j)),'FontSize', 6);
            ver = [ver, num2str(v(j))];
            if j ~= length(v)
                ver = [ver,','];
            end
        end
        ver = [ver,'],'];
    end
end

% rows
hor = []
for i = 1:S(1)
    v = BLACKS_R{i};
    if length(v) > 0
        hor = [hor,'['];
        for j = 1:length(v)
            text(0.1-length(v)+j-1,S(1)+0.5-i,num2str(v(j)),'FontSize', 6);
            hor = [hor, num2str(v(j))];
            if j ~= length(v)
                hor = [hor,','];
            end
        end
        hor = [hor,'],'];
    end
end