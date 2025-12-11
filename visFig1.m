% generates Figure 01 in the paper

close all;

x = linspace(-0.2, 0.2, 1E3);
[ys, ys1d, ys2d, ys3d] = NonlinSNorm(x);
[ya, ya1d, ya2d, ya3d] = NonlinLN(x);

figure(1);
clf
set(gcf, 'Units', 'normalized', 'Position', [0.1, 0.1, 0.6, 0.8]);  % Enlarged figure size

% Use tiledlayout for better subplot control
t = tiledlayout(2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

fontSize = 14;
labelSize = round(fontSize * 1.5);  % ~50% larger for panel labels
fontName = 'Arial';

% Panel A
nexttile
plot(x, ys, 'k:', x, ya, 'k', 'LineWidth', 2)
title('Boltzmann functions')
legend('first-order', 'second-order', 'Location', 'SE')
xlabel('a\eta')
ylabel('S[a\eta] - S[0]')
text(0.01, 0.95, 'A', 'Units', 'normalized', ...
     'FontWeight', 'bold', 'FontSize', labelSize)
set(gca, 'FontSize', fontSize, 'FontName', fontName)
grid on

% Panel B
nexttile
plot(x, ys1d, 'k:', x, ya1d, 'k', 'LineWidth', 2)
title('First derivative')
xlabel('a\eta')
ylabel('S^{(1)}[a\eta]')
text(0.01, 0.95, 'B', 'Units', 'normalized', ...
     'FontWeight', 'bold', 'FontSize', labelSize)
set(gca, 'FontSize', fontSize, 'FontName', fontName)
grid on

% Panel C
nexttile
plot(x, ys2d, 'k:', x, ya2d, 'k', 'LineWidth', 2)
title('Second derivative')
xlabel('a\eta')
ylabel('S^{(2)}[a\eta]')
text(0.01, 0.95, 'C', 'Units', 'normalized', ...
     'FontWeight', 'bold', 'FontSize', labelSize)
set(gca, 'FontSize', fontSize, 'FontName', fontName)
grid on

% Panel D
nexttile
plot(x, ys3d, 'k:', x, ya3d, 'k', 'LineWidth', 2)
title('Third derivative')
xlabel('a\eta')
ylabel('S^{(3)}[a\eta]')
text(0.01, 0.95, 'D', 'Units', 'normalized', ...
     'FontWeight', 'bold', 'FontSize', labelSize)
set(gca, 'FontSize', fontSize, 'FontName', fontName)
grid on

% Export to jpg

exportgraphics(gcf, 'Figures/Figure01.jpg', 'resolution', 600');  % Save as EPS
