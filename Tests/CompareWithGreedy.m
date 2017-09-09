disp('# Generating elevations');

E = GenerateHills(1000);

disp('# Computing Best Path');

[bestRow, bestCol, bestElev] = BestPath(E);

disp('# Computing Greedy Path');

[greedyRow, greedyCol, greedyElev] = BestGreedyPath(E);

disp('# Adding path to surface color data');
C = E;
for c = bestCol
	C(bestRow(c), c) = 1.5;
	C(greedyRow(c), c) = 1.5;
end

disp('# Plotting surface');
figure(1);
s = surf(E, C, 'EdgeColor', 'none');
s.FaceLighting = 'gouraud';
camlight left;
lighting phong;
xlabel('Columns');
ylabel('Rows');

disp('# Plotting contour map');
figure(2);
contourf(E, 30);
hold on;
plot(bestCol, bestRow, 'r');
plot(greedyCol, greedyRow, 'r--');
legend('Elevations', 'Best path', 'Greedy path');
xlabel('Columns');
ylabel('Rows');
hold off;

disp('# Done');
