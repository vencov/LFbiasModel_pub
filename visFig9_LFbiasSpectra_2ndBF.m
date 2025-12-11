% generate Figure 9 in the paper

close all;


% Define filenames and corresponding Lbias levels
Lbias_levels = [95, 105, 115];
filenames = ["../Data/spectrum_results_2nd_95.mat", ...
             "../Data/spectrum_results_2nd_105.mat", ...
             "../Data/spectrum_results_2nd_115.mat"];

% Adjustable font size
fontsize = 11;

% Frequencies of interest
f1 = 2176;
f2 = 2688;
fcdt = 2*f1 - f2;  % = 1664 Hz

% Create figure for journal single-column format
figure('Units', 'centimeters', 'Position', [5, 5, 9, 17]);  % taller for 4 panels

% Axis base and limits
stem_base = -100;
yl = [-20, 120];
xL = [100 3000];

ax_array = gobjects(1,3); % for storing axes handles
for i = 1:3
    data = load(filenames(i));
    ax = subplot(4,1,i); hold on;
    ax_array(i) = ax;

    % Plot entire signal
    for j = 1:length(data.fx_pos)
        x = data.fx_pos(j);
        y = data.amp_pos(j);
        line([x x], [stem_base y], 'Color', 'b');
        plot(x, y, 'bo', 'MarkerFaceColor', 'b');
    end

    % Plot phase ensemble
    for j = 1:length(data.fx_pos)
        x = data.fx_pos(j);
        y = data.amp_pos_s(j);
        line([x x], [stem_base y], 'Color', 'r', 'LineStyle', '--');
        plot(x, y, 'rx');
    end

    % Mark fdp
    xline(data.fdp, 'k:', '', 'FontSize', fontsize);

    % Frequency labels
    text(f1+120, yl(2)-10, '$f_1$', 'Interpreter', 'latex', ...
        'HorizontalAlignment', 'center', 'FontSize', fontsize);
    text(f2+120, yl(2)-10, '$f_2$', 'Interpreter', 'latex', ...
        'HorizontalAlignment', 'center', 'FontSize', fontsize);
    text(fcdt+120, yl(2)-50, '$f_{\mathrm{CDT}}$', 'Interpreter', 'latex', ...
        'HorizontalAlignment', 'center', 'FontSize', fontsize);

    xlim(xL);
    ylim(yl);
    set(gca, 'FontSize', fontsize);
    if i < 3
        set(gca, 'XTickLabel', []);
    else
        xlabel('Frequency [kHz]', 'FontSize', fontsize);
    end

    % Lbias label
    text(110, 90, ['{\it L}_{\rmbias} = ', num2str(Lbias_levels(i)), ' dB'], ...
         'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
         'FontSize', fontsize);

    grid on; box on;

    % Add subplot label A/B/C
    text(xL(1)+30, yl(2)-10, char('A'+(i-1)), ...
        'FontWeight', 'bold', 'FontSize', fontsize, 'Units', 'data');
end

xticks_kHz = get(gca, 'XTick');
xticklabels_kHz = arrayfun(@(x) sprintf('%.1f', x/1000), xticks_kHz, 'UniformOutput', false);
set(gca, 'XTickLabel', xticklabels_kHz);

% Adjust spacing between top 3 subplots
for i = 1:3
    pos = get(ax_array(i), 'Position');
    pos(4) = 0.18;  % height
    pos(2) = 0.80 - (i-1)*0.20;  % vertical position
    pos(1) = 0.19;
    set(ax_array(i), 'Position', pos);
end
% Dummy plots for legend

% Add shared y-label between 2nd and 3rd subplots
% Use normalized figure units to place it visually centered
annotation('textbox', [0.2, 0.6, 0.8, 0.1], ...
    'String', 'Amplitude [dB]', ...
    'Interpreter', 'tex', ...
    'FontSize', fontsize, ...
    'EdgeColor', 'none', ...
    'Rotation', 90);

%% Fourth panel: Lbias dependence of sideband amplitudes

filenames_all = ["../Data/spectrum_results_2nd_90.mat", ...
                 "../Data/spectrum_results_2nd_95.mat", ...
                 "../Data/spectrum_results_2nd_100.mat", ...
                 "../Data/spectrum_results_2nd_105.mat", ...
                 "../Data/spectrum_results_2nd_110.mat", ...
                 "../Data/spectrum_results_2nd_115.mat",...
                 "../Data/spectrum_results_2nd_120.mat"];
Lbias_all = 90:5:120;

% Known constants
fbias = 32;
flsbII = fcdt - 2*fbias;  % 1600 Hz
flsbI  = fcdt - fbias;    % 1632 Hz
fusbI  = fcdt + fbias;    % 1696 Hz
fusbII = fcdt + 2*fbias;  % 1728 Hz

% Initialize arrays to hold amplitudes
n = length(Lbias_all);
amp_lsbII = nan(1, n);
amp_lsbI  = nan(1, n);
amp_usbI  = nan(1, n);
amp_usbII = nan(1, n);
amp_cdt   = nan(1, n);

for i = 1:n
    data = load(filenames_all(i));

    % Find amplitude at closest frequency bin
    [~, idx] = min(abs(data.fx_pos - flsbII)); amp_lsbII(i) = data.amp_pos_s(idx);
    [~, idx] = min(abs(data.fx_pos - flsbI));  amp_lsbI(i)  = data.amp_pos_s(idx);
    [~, idx] = min(abs(data.fx_pos - fusbI));  amp_usbI(i)  = data.amp_pos_s(idx);
    [~, idx] = min(abs(data.fx_pos - fusbII)); amp_usbII(i) = data.amp_pos_s(idx);
    [~, idx] = min(abs(data.fx_pos - fcdt));   amp_cdt(i)   = data.amp_pos_s(idx);
end

% Plot in fourth subplot
ax4 = subplot(4,1,4); hold on;
plot(Lbias_all, amp_lsbII, '-o', 'DisplayName', '$f_{\mathrm{CDT}} - 2f_b$', 'LineWidth', 1.2);
plot(Lbias_all, amp_lsbI,  '-o', 'DisplayName', '$f_{\mathrm{CDT}} - f_b$',  'LineWidth', 1.2);
plot(Lbias_all, amp_cdt,   '-o', 'DisplayName', '$f_{\mathrm{CDT}}$',        'LineWidth', 1.2);  % Added line
plot(Lbias_all, amp_usbI,  '-o', 'DisplayName', '$f_{\mathrm{CDT}} + f_b$',  'LineWidth', 1.2);
plot(Lbias_all, amp_usbII, '-o', 'DisplayName', '$f_{\mathrm{CDT}} + 2f_b$', 'LineWidth', 1.2);

xlabel('{\it L}_{bias} [dB SPL]', 'FontSize', fontsize);
annotation('textbox', [0.2, 0.09, 0.8, 0.1], ...
    'String', 'Amplitude [dB]', ...
    'Interpreter', 'tex', ...
    'FontSize', fontsize, ...
    'EdgeColor', 'none', ...
    'Rotation', 90);
set(gca, 'FontSize', fontsize);
grid on; box on;

% Add legend above panel
lg = legend({'LSB II', 'LSB I', 'CDT', 'USB I', 'USB II'}, ...
            'Orientation', 'horizontal', ...
            'NumColumns', 3,... 
            'position', [0.2 0.27 0.8 0.05], ...
            'FontSize', fontsize-2);
set(lg, 'Box', 'off');

% Add panel label 'D'
text(Lbias_all(1)+0.3, max([amp_lsbII amp_lsbI amp_usbI amp_usbII amp_cdt]) - 4, ...
     'D', 'FontWeight', 'bold', 'FontSize', fontsize);


%set('gcf','Units', 'centimeters', 'Position', [5, 5, 9, 17]);  % taller to fit 4 panels

  pos = get(ax4, 'Position');
  pos(4) = 0.18;  % height  
  pos(2) = 0.09;  % vertical position
  pos(1) = 0.19;
  set(ax4, 'Position', pos);


%% Export the figure
exportgraphics(gcf,'Figures/Figure09.jpg','Resolution',600)