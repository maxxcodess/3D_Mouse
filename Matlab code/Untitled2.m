figure('position',[100 100 850 600])
Z = peaks; surf(Z); 
axis tight
set(gca,'nextplot','replacechildren');
% Record the movie
for j = 1:10 
	surf(sin(2*pi*j/20)*Z,Z)
	F(j) = getframe;
end
[h, w, p] = size(F(1).cdata);  % use 1st frame to get dimensions
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf, 'position', [150 150 w h]);
axis off
% tell movie command to place frames at bottom left
movie(hf,F,4,30,[0 0 10 0]);