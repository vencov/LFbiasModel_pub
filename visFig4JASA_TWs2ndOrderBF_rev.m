% generates Figure 4 in the paper

load ../Data/DPOAEOPL140L240V3.mat
load ../Data/pomocnedata.mat
OPo=[-0.1:0.01:-0.05,-0.047:0.003:0,0,0.003:0.003:0.05,0.05:0.01:0.2];

%whos
ind=23;%nulovy posuv ind=23;
indp=3;
indp2=6;

% --- Axis limit control variables ---
xlimAmpCDT = [0.8, 1.7];     % for amplitude subplots (log scale)
xlimAmp = [0, 2.5];     % for amplitude subplots (log scale)
ylimsAmp = [1e-8, 6e-2]; % for amplitude subplots (log scale)

xlimPhaseCDT = [0.8, 1.7];      % for phase subplots
xlimPhase = [0, 2.5];      % for phase subplots
ylimsPhase = [-5, 2.5];       % adjust this range as needed




% -------- Layout positions (adjust as needed) --------
left = 0.08; midX = 0.52;
bottom1 = 0.08; bottom2 = 0.46;
w = 0.38; h = 0.33;
FS = 13;
lw = 1.5;  % nastavení šířky čáry, uprav podle potřeby

% ---- ROZMÍSTĚNÍ SUBPLOTŮ ---- 
figure(1)
clf
screenSize = get(0, 'Screensize');
bottom = 271;
width = 960;
height = 720;

set(gcf, 'Position', [left, bottom, width, height])
tiledlayout(2,2,'TileSpacing','compact','Padding','loose')
idx = 1:8:length(x);


line_colors = [ ...
    get(groot, 'defaultAxesColorOrder');  % 7 colors
    [0.5 0.5 0.5];  % gray
    [0 0 0]         % black
];

% --- SUBPLOT 1 (top-left) ---
ax1 = axes('Position', [left bottom2 w h]);
hold on
% Define color shades (light → dark)
reds  = [0 0 0; 1 0.6 0.6; 1 0.4 0.4; 1 0.2 0.2; 1 0 0];
reds  = [0 0 0; 0 0 1; 1 0 0; 0 1 0; 1 0 1];
trP = 0.8;
reds  = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(2,:)  trP]; [line_colors(3,:)  trP]; [line_colors(4,:)  trP]];
blues = [0 0 0; 0.6 0.6 1; 0.4 0.4 1; 0.2 0.2 1; 0 0 1];
blues  = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(2,:)  trP]; [line_colors(3,:)  trP]; [line_colors(4,:)  trP]];
blacks = [0.7 0.7 0.7; 0.6 0.6 0.6; 0.4 0.4 0.4; 0.2 0.2 0.2; 0 0 0];
blacks  = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(2,:)  trP]; [line_colors(3,:)  trP]; [line_colors(4,:)  trP]];
reds  = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];
blacks = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];
blues = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];



% Offsets corresponding to each color shade
offsets = [0, -indp, indp, -indp2, indp2 ];

% Define line widths (thickest at center)
lwVals = [3, 2.5, 2, 1.5, 1];   % You can tweak these
lwVals = [2, 2, 2, 2, 2];   % You can tweak these

hold on
for i = 1:length(offsets)
    off = offsets(i);
    lw_now = lwVals(i);
    j = i;
    semilogy(x, RRF1a(ind+off,:), 'Color', reds(j,:), 'LineWidth', lw_now,'linestyle','-');
    semilogy(x, RRF2a(ind+off,:), 'Color', blues(j,:), 'LineWidth', lw_now,'linestyle','--');
    semilogy(x, RRFdpa(ind+off,:), 'Color', blacks(j,:), 'LineWidth', lw_now,'linestyle',':');
end
hold off
xlim(xlimAmpCDT); 

ylim(ylimsAmp)
ylabel('Amplitude [a.u.]')
set(gca, 'yscale','log', 'ytick',[1e-9,1e-7,1e-5,1e-3,1e-1], 'TickLength', [0.015 0.015],'fontsize',FS)
box on;
yl = ylim;
x_patch = [1.17 1.32 1.32 1.17];
y_patch = [yl(1) yl(1) yl(2) yl(2)];
p = patch(x_patch, y_patch, [0.6 0.6 0.6], 'FaceAlpha', 0.7, 'EdgeColor', 'none');
uistack(p, 'bottom')
text(0.05+xlimAmpCDT(1), ylimsAmp(2)*0.3, 'A', 'FontWeight','bold','FontSize',20)

set(gca, 'YMinorTick', 'off');  % optional, if you want only custom ticks
grid on
ax = gca;
ax.XMinorTick = 'off';
ax.YMinorTick = 'off';
ax.MinorGridLineStyle = 'none';  % ensure no minor grid



hLabelf1 = text(1.1, ...
              10e-3, ...
              '$f_2$', ...
              'Interpreter','latex', ...
              'FontWeight','bold', ...
              'FontSize', FS, ...
              'Units','data');

          
hLabelf2 = text(1.45, ...
              7e-3, ...
              '$f_1$', ...
              'Interpreter','latex', ...
              'FontWeight','bold', ...
              'FontSize', FS, ...
              'Units','data');


          
hLabelf2 = text(1.6, ...
              14e-5, ...
              '$f_{\rm CDT}$', ...
              'Interpreter','latex', ...
              'FontWeight','bold', ...
              'FontSize', FS, ...
              'Units','data');
   

% --- SUBPLOT 2 (top-right) ---
ax2 = axes('Position', [midX bottom2 w h]);

hold on
for i = 1:length(offsets)
    off = offsets(i);
    lw_now = lwVals(i);
    j = i;
    semilogy(x, RRF1a(ind+off,:), 'Color', reds(j,:), 'LineWidth', lw_now,'linestyle','-');
    semilogy(x, RRF2a(ind+off,:), 'Color', blues(j,:), 'LineWidth', lw_now,'linestyle','--');
    semilogy(x, RRFdp2a(ind+off,:), 'Color', blacks(j,:), 'LineWidth', lw_now,'linestyle',':');
end

xlim(xlimAmp); ylim(ylimsAmp)
set(gca, 'yscale','log', 'ytick',[1e-9,1e-7,1e-5,1e-3,1e-1], 'TickLength', [0.015 0.015],'fontsize',FS)
box on;
text(0.05+xlimAmp(1), ylimsAmp(2)*0.3, 'B', 'FontWeight','bold','FontSize',20)

x_patch = [1.1 1.3 1.3 1.1];
y_patch = [yl(1) yl(1) yl(2) yl(2)];
p = patch(x_patch, y_patch, [0.6 0.6 0.6], 'FaceAlpha', 0.7, 'EdgeColor', 'none');
uistack(p, 'bottom')  % posune patch do pozadí, aby nezkryl čáry
hold off
grid on

          
hLabelf2 = text(2.2, ...
              14e-5, ...
              '$f_{\rm QDT}$', ...
              'Interpreter','latex', ...
              'FontWeight','bold', ...
              'FontSize', FS, ...
              'Units','data');

ax = gca;
ax.XMinorTick = 'off';
ax.YMinorTick = 'off';
ax.MinorGridLineStyle = 'none';  % ensure no minor grid
% --- SUBPLOT 3 (bottom-left) ---
ax3 = axes('Position', [left bottom1 w h]);
hold on
for i = 1:length(offsets)
    off = offsets(i);
    lw_now = lwVals(i);
    j = i;
    semilogy(x, RRF1ph(ind+off,:), 'Color', reds(j,:), 'LineWidth', lw_now,'linestyle','-');
    semilogy(x, RRF2ph(ind+off,:), 'Color', blues(j,:), 'LineWidth', lw_now,'linestyle','--');
    semilogy(x, RRFdpph(ind+off,:), 'Color', blacks(j,:), 'LineWidth', lw_now,'linestyle',':');
    
end
gr1 = 240
gr2 = 310
semilogy(x(gr1:gr2), 2*RRF1ph(ind,gr1:gr2) - RRF2ph(ind,gr1:gr2)+1.65, 'Color', [0,1,0,0.4],'LineWidth', lw_now,'linestyle','-');
hold off
xlim(xlimPhaseCDT); ylim(ylimsPhase)
xlabel('Distance from stapes [cm]')
ylabel('Phase [cycle]')
grid on; box on;
set(gca, 'TickLength', [0.015 0.015],'fontsize',FS)
text(0.05+xlimAmpCDT(1), ylimsPhase(2)*0.8, 'C', 'FontWeight','bold','FontSize',20)

yl = ylim;
x_patch = [1.17 1.32 1.32 1.17];
y_patch = [yl(1) yl(1) yl(2) yl(2)];
p = patch(x_patch, y_patch, [0.6 0.6 0.6], 'FaceAlpha', 0.7, 'EdgeColor', 'none');
uistack(p, 'bottom')

% --- SUBPLOT 4 (bottom-right) ---
ax4 = axes('Position', [midX bottom1 w h]);
hold on
for i = 1:length(offsets)
    off = offsets(i);
    lw_now = lwVals(i);
    j = i;
    semilogy(x, RRF1ph(ind+off,:), 'Color', reds(j,:), 'LineWidth', lw_now,'linestyle','-');
    semilogy(x, RRF2ph(ind+off,:), 'Color', blues(j,:), 'LineWidth', lw_now,'linestyle','--');
    semilogy(x, RRFdp2ph(ind+off,:)+1, 'Color', blacks(j,:), 'LineWidth', lw_now,'linestyle',':');
    
end
gr1 = 200
gr2 = 330
semilogy(x(gr1:gr2),RRF2ph(ind,gr1:gr2) - RRF1ph(ind,gr1:gr2)+1.55, 'Color', [0,1,0,0.4],'LineWidth', lw_now,'linestyle','-');
hold off
xlim(xlimPhase); ylim(ylimsPhase)
xlabel('Distance from stapes [cm]')
grid on; box on;
set(gca, 'TickLength', [0.015 0.015],'fontsize',FS)
text(0.05+ xlimAmp(1), ylimsPhase(2)*0.8, 'D', 'FontWeight','bold','FontSize',20)

yl = ylim;
x_patch = [1.1 1.3 1.3 1.1];
y_patch = [yl(1) yl(1) yl(2) yl(2)];
p = patch(x_patch, y_patch, [0.6 0.6 0.6], 'FaceAlpha', 0.7, 'EdgeColor', 'none');
uistack(p, 'bottom')

% Vytvoř nové malé axes (inset) v pravém horním rohu subplotu (2,2,1)
insetAx = axes('Position',[0.77 0.825 0.13 0.15]);  % např. pravý horní roh

% Vykresli obsah insetu
plot(OPo,y,'k','LineWidth',2), hold on
plot(OPo(ind),y(ind),'color',reds(1,:),'linewidth',2,'Marker','o')
plot(OPo(ind-indp2),y(ind-indp2),'color',reds(4,:),'linewidth',2,'Marker','o')
plot(OPo(ind-indp),y(ind-indp),'color',reds(2,:),'linewidth',2,'Marker','o')
plot(OPo(ind+indp),y(ind+indp),'color',reds(3,:),'linewidth',2,'Marker','o')
plot(OPo(ind+indp2),y(ind+indp2),'color',reds(5,:),'linewidth',2,'Marker','o')


% Position the letter a bit inside the upper-left corner
text(-0.09, 0.045, 'E', ...
    'FontWeight','bold', 'FontSize', 12, 'Units','data')

grid on
xlim([OPo(1),OPo(end-10)])
set(gca,'fontsize',10,'Box','on')  % <- zde jsou zachovány XTick a YTick
title('Operating points','FontSize',10)



% ---- VLASTNÍ LEGENDA se skupinou tří čar + jedno číslo ----
% Vytvoříme novou osu pro legendu (např. nahoře)
legendAx = axes('Position',[0.2 0.85 0.5 0.03]); % [left bottom width height]
axis(legendAx, 'off')  % vypnout osy
hold(legendAx, 'on')

% Y-pozice tří čar v každé skupině
ybase = [3 2 1];

% X-počáteční body pro každou skupinu
xstart = [1, 4, 7, 10, 13];  % nastav podle počtu skupin

% Indexy posuvů
offsets = [0, -indp,indp,-indp2,indp2];
reds  = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];
colors = {reds,reds,reds};  % RRF1, RRF2, DPOAE


LineStyles ={'-','--',':','-.','-'};
MarkerS = {'none','none','none','none','none'};
cS = {'k','b','g','r','m'};
for g = 1:length(offsets)
    x0 = xstart(g);
    opIndex = ind + offsets(g);
    for i = 1:3
        plot(legendAx, [x0-0.5 x0 x0+0.5], [ybase(i) ybase(i) ybase(i)], ...
            'Color', colors{i}(g,:), ...
            'LineWidth', 2, ...
            'LineStyle', LineStyles{i},...
            'Marker',MarkerS{g})
    end
    % Zobraz číslo OPo vpravo od skupiny
    if OPo(opIndex)==0
        text(x0+0.7, 2, num2str(OPo(opIndex),'%d'), ...
            'FontSize', 10, 'VerticalAlignment', 'middle','color',cS{1})    
    else
        text(x0+0.7, 2, num2str(OPo(opIndex),'%0.3f'), ...
            'FontSize', 10, 'VerticalAlignment', 'middle','color',cS{1})
    end
end

%% === Export do JPG ===

exportgraphics(gcf,'Figures/Figure04.jpg', 'resolution', 600);
