% generate Figure 11 in the paper

close all


Fs = 204800;  % Sampling frequency in Hz

load('../Data/AdataLbias_effect_NumSidebands_65_60.mat');

N = length(sig_oae_105_2);  % Assumes all signals have same length
t = 1000*(0:N-1) / Fs;  % Time vector in seconds


figure(2)
clf
screenSize = get(0, 'Screensize');
width = screenSize(3) / 4;  % smaller width
height = screenSize(4) / 1.5; % smaller height
left = screenSize(1) + screenSize(3)/3;  
bottom = screenSize(2) + screenSize(4)/4; 
set(gcf, 'Position', [left, bottom, width, height])

tiledlayout(3,1,'TileSpacing','compact','Padding','loose')
FSl = 12;
lw = 1.4;

% Prepare signals for zero-crossings and extrema
signals = {TMdataFrame115_2, Pr115_2, BMd_115_2};
colors = {'k', [0.6,0.6,0.6], 'r'};
labels = {'\eta(0)', '{\itp}_{EC}', '\xi(0)'};
normSignals = cellfun(@(s) s / max(s), signals, 'UniformOutput', false);

% Detect features (zero-crossings, maxima, minima)
xLines = cell(1,3); % store x positions of vertical lines
for i = 1:3
    y = normSignals{i};
    zeroCross = find(diff(sign(y)) ~= 0);
    [~, maxIdx] = max(y);
    [~, minIdx] = min(y);
    xLines{i} = sort([zeroCross(:); maxIdx; minIdx]);
end

% Panel A: OAE 105
nexttile
plot(t,20*log10(sig_oae_105_2), 'b', 'LineWidth', lw); hold on
plot(t,20*log10(sig_oae_105_4), 'r', 'LineWidth', lw);
plot(t,20*log10(sig_oae_105_6), 'g', 'LineWidth', lw);
% vertical lines
for i = 1:length(xLines)
    xline(t(xLines{i}), '--', 'Color', colors{i})
end

title('{\itL}_{bias} = 105 dB SPL, {\itf}_{bias} = 32 Hz','FontWeight','normal'); ylabel('Amplitude [dB]');
lgd = legend('4 sb', '8 sb', '12 sb'); grid on;
set(lgd, 'Position', [0.68 0.72 0.17 0.07])  % Adjust as needed
set(gca, 'FontSize', FSl);
set(gca,'ylim',[-125,-115]+170)
%text(100, max(ylim)*1.01, 'A', 'FontWeight','bold','FontSize',FSl+5)
xlim([t(1), t(end)])
text(t(1)+0.5, max(ylim)*0.98, 'A', 'FontWeight','bold', 'FontSize', FSl+6)
% Panel B: OAE 115
nexttile
plot(t,20*log10(sig_oae_115_2), 'b', 'LineWidth', lw); hold on
plot(t,20*log10(sig_oae_115_4), 'r', 'LineWidth', lw);
plot(t,20*log10(sig_oae_115_6), 'g', 'LineWidth', lw);
% vertical lines
for i = 1:length(xLines)
    xline(t(xLines{i}), '--', 'Color', colors{i})
end
title('{\itL}_{bias} = 115 dB SPL, {\itf}_{bias} = 32 Hz','FontWeight','normal'); ylabel('Amplitude [dB]');
lgd = legend('4 sb', '8 sb', '12 sb'); grid on;
set(lgd, 'Position', [0.75 0.42 0.17 0.07])  % Adjust as needed

set(gca, 'FontSize', FSl);
xlim([t(1), t(end)])
text(t(1)+0.5, max(ylim)*0.98, 'B', 'FontWeight','bold', 'FontSize', FSl+6)
set(gca,'ylim',[-145,-115]+170)

% Panel C: Mechanical responses
nexttile

for i = 1:3
    plot(t,normSignals{i}, 'color', colors{i}, 'LineWidth', lw); hold on
end
% vertical lines
for i = 1:length(xLines)
    xline(t(xLines{i}), '--', 'Color', colors{i})
end
title('Bias tone');
xlim([t(1), t(end)])

xlabel('Time [ms]'); ylabel('Normalized amplitude');
lgd = legend(labels); grid on;
set(lgd,'position',[0.79,0.12,0.14,0.075])
set(gca, 'FontSize', FSl);
text(t(1)+0.5, max(ylim)*0.7, 'C', 'FontWeight','bold','FontSize',FSl+5)

%% Export the figure

exportgraphics(gcf, 'Figures/Figure09.jpg', 'resolution', 600);
