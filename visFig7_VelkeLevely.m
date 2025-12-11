close all



OPo=[-0.1:0.01:-0.05,-0.047:0.003:0,0,0.003:0.003:0.05,0.05:0.01:0.2];

load bmdataME.mat x

load ../Data/DPOAEOPL140L240V3 oaeFdp2a oaeFdpa
oaeFdp2a40=oaeFdp2a;
oaeFdpa40=oaeFdpa;
oaeFdpa40N= oaeFdpa40/max(oaeFdpa40);
oaeFdp2a40N= oaeFdp2a40/max(oaeFdp2a40);

load ../Data/DPOAEOPL145L245V3 oaeFdp2a oaeFdpa
oaeFdp2a45=oaeFdp2a;
oaeFdpa45=oaeFdpa;
oaeFdpa45N= oaeFdpa45/max(oaeFdpa45);
oaeFdp2a45N= oaeFdp2a45/max(oaeFdp2a45);

load ../Data/DPOAEOPL150L250V3 oaeFdp2a oaeFdpa
oaeFdp2a50=oaeFdp2a;
oaeFdpa50=oaeFdpa;
oaeFdpa50N= oaeFdpa50/max(oaeFdpa50);
oaeFdp2a50N= oaeFdp2a50/max(oaeFdp2a50);

load ../Data/DPOAEOPL155L255V3 oaeFdp2a oaeFdpa
oaeFdp2a55=oaeFdp2a;
oaeFdpa55=oaeFdpa;
oaeFdpa55N= oaeFdpa55/max(oaeFdpa55);
oaeFdp2a55N= oaeFdp2a55/max(oaeFdp2a55);

load ../Data/DPOAEOPL160L260V3 oaeFdp2a oaeFdpa
oaeFdp2a60=oaeFdp2a;
oaeFdpa60=oaeFdpa;
oaeFdpa60N= oaeFdpa60/max(oaeFdpa60);
oaeFdp2a60N= oaeFdp2a60/max(oaeFdp2a60);

load ../Data/DPOAEOPL165L265V3 oaeFdp2a oaeFdpa
oaeFdp2a65=oaeFdp2a;
oaeFdpa65=oaeFdpa;
oaeFdpa65N= oaeFdpa65/max(oaeFdpa65);
oaeFdp2a65N= oaeFdp2a65/max(oaeFdp2a65);

load ../Data/DPOAEOPL170L270V3 oaeFdp2a oaeFdpa
oaeFdp2a70=oaeFdp2a;
oaeFdpa70=oaeFdpa;
oaeFdpa70N= oaeFdpa70/max(oaeFdpa70);
oaeFdp2a70N= oaeFdp2a70/max(oaeFdp2a70);



[y,y1d,y2d,y3d]=NonlinLN(OPo);
y2dN=abs(y2d)/max(abs(y2d));
y3dN=abs(y3d)/max(abs(y3d));


%%



% -------- Layout positions (adjust as needed) --------
left = 0.08; midX = 0.52;
bottom1 = 0.10; bottom2 = 0.56;
w = 0.38; h = 0.36;
ylimsAmp = [1e-2 2e0];
FSl = 13;  % fontsize for gca

lw = 1.8;  % nastavení šířky čáry, uprav podle potřeby

line_colors = [ ...
    get(groot, 'defaultAxesColorOrder');  % 7 colors
    [0.5 0.5 0.5];  % gray
    [0 0 0]         % black
    ];

% ---- ROZMÍSTĚNÍ SUBPLOTŮ ----
figure(1)
clf
screenSize = get(0, 'Screensize');
width = screenSize(3) / 2;
height = screenSize(4) / 2;
left = screenSize(1) + screenSize(3)/4;  % center horizontally
bottom = screenSize(2) + screenSize(4)/4; % center vertically
set(gcf, 'Position', [left, bottom, width, height])
tiledlayout(2,2,'TileSpacing','compact','Padding','loose')
idx = 1:8:length(x);
% --- SUBPLOT 1 ---
nexttile
hold on;
%plot(OPo,20*log10(oaeFdpa40),'color',line_colors(1,:),'linewidth',lw);
%plot(OPo,20*log10(oaeFdpa45),'color',line_colors(2,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa40),'color',line_colors(1,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa45),'color',line_colors(2,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa50),'color',line_colors(3,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa55),'color',line_colors(4,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa60),'color',line_colors(5,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa65),'color',line_colors(6,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdpa70),'color',line_colors(7,:),'linewidth',lw);
set(gca, 'YTick', [-50,-25,0,25,50])
lgd = legend( ...
    '40', '45', '50', ...
    '55', '60', '65', ...
    '70 dB SPL', ...
    'NumColumns', 9, ...
    'Orientation', 'horizontal', ...
    'FontSize', FSl - 2);

% Add legend title
% Add text label next to it
annotation('textbox', [0.03, 0.94, 0.1, 0.05], ...
    'String', '{\itL}_{1,2}', ...
    'EdgeColor', 'none', ...
    'FontSize', FSl - 1, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'Interpreter', 'tex');  % or 'latex' if needed
% Optional: remove box and reposition
set(lgd, 'Box', 'off');
lgd.Position(1:2) = [0.13, 0.94];  % Adjust as needed
%xlabel('{\ity_0} [a.u.]');
ylabel('{\itp}_{\rm CDT} [dB re 1 a.u.]');
%xlim([OPo(1),OPo(end)])
xlim([-0.1,0.1])
ylim([-50,70])
grid on
set(gca,'FontSize',FSl,'yscale','lin')
set(gca, 'XColor', 'k', 'YColor', 'k')
box on;
%set(gca, 'YTick', [0.0001 0.01 1 100])
%set(gca, 'YMinorTick', 'on')  % for even finer ticks
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]

ax = gca;
xlims = xlim(ax);
ylims = ylim(ax);

% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.1*range(ylims), 'A', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')


% --- SUBPLOT 3 ---

nexttile

hold on;
%plot(OPo,oaeFdp2a40,'color',line_colors(1,:),'linewidth',lw);
%plot(OPo,oaeFdp2a45,'color',line_colors(2,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a40),'color',line_colors(1,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a45),'color',line_colors(2,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a50),'color',line_colors(3,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a55),'color',line_colors(4,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a60),'color',line_colors(5,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a65),'color',line_colors(6,:),'linewidth',lw);
plot(OPo,20*log10(oaeFdp2a70),'color',line_colors(7,:),'linewidth',lw);

%xlabel('{\ity_0} [a.u.]');
ylabel('{\itp}_{\rm QDT} [dB re 1 a.u.]');
%xlim([OPo(1),OPo(end)])
xlim([-0.1,0.1])
ylim([-50,70])
grid on
set(gca,'FontSize',FSl,'yscale','lin')
set(gca, 'XColor', 'k', 'YColor', 'k')
box on;
set(gca, 'YTick', [-50,-25,0,25,50])
%set(gca, 'YMinorTick', 'on')  % for even finer ticks
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]

ax = gca;
xlims = xlim(ax);
ylims = ylim(ax);

% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.1*range(ylims), 'B', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')



% --- SUBPLOT 2 ---

nexttile
hold on;
%plot(OPo,oaeFdpa40N,'color',line_colors(1,:),'linewidth',lw);
%plot(OPo,oaeFdpa45N,'color',line_colors(2,:),'linewidth',lw);
plot(OPo,oaeFdpa40N,'color',line_colors(1,:),'linewidth',lw);
plot(OPo,oaeFdpa45N,'color',line_colors(2,:),'linewidth',lw);
plot(OPo,oaeFdpa50N,'color',line_colors(3,:),'linewidth',lw);
plot(OPo,oaeFdpa55N,'color',line_colors(4,:),'linewidth',lw);
plot(OPo,oaeFdpa60N,'color',line_colors(5,:),'linewidth',lw);
plot(OPo,oaeFdpa65N,'color',line_colors(6,:),'linewidth',lw);
plot(OPo,oaeFdpa70N,'color',line_colors(7,:),'linewidth',lw);
xlabel('{\ity_0}');
ylabel('Normalized {\itp}_{\rm CDT}');
%xlim([OPo(1),OPo(end)])
xlim([-0.1,0.1])
grid on
set(gca, 'XColor', 'k', 'YColor', 'k')
box on;
%set(gca, 'YMinorTick', 'on')  % for even finer ticks
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]


plot(OPo,y3dN,'k-.','LineWidth',lw+0.4)
%xlim([OPo(1),OPo(end)])
xlim([-0.1,0.1])
set(gca,'FontSize',FSl)
grid on
hold off


ax = gca;
xlims = xlim(ax);
ylims = ylim(ax);

% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.135*range(ylims), 'C', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')

% --- SUBPLOT 4 ---

nexttile

hold on;
%plot(OPo,oaeFdp2a40N,'color',line_colors(1,:),'linewidth',lw);
%plot(OPo,oaeFdp2a45N,'color',line_colors(2,:),'linewidth',lw);
plot(OPo,oaeFdp2a40N,'color',line_colors(1,:),'linewidth',lw);
plot(OPo,oaeFdp2a45N,'color',line_colors(2,:),'linewidth',lw);
plot(OPo,oaeFdp2a50N,'color',line_colors(3,:),'linewidth',lw);
plot(OPo,oaeFdp2a55N,'color',line_colors(4,:),'linewidth',lw);
plot(OPo,oaeFdp2a60N,'color',line_colors(5,:),'linewidth',lw);
plot(OPo,oaeFdp2a65N,'color',line_colors(6,:),'linewidth',lw);
plot(OPo,oaeFdp2a70N,'color',line_colors(7,:),'linewidth',lw);

xlabel('{\ity_0}');
ylabel('Normalized {\itp}_{\rm QDT}');
%xlim([OPo(1),OPo(end)])
xlim([-0.1,0.1])
grid on
set(gca,'FontSize',FSl,'yscale','lin')
set(gca, 'XColor', 'k', 'YColor', 'k')
box on;
%set(gca, 'YMinorTick', 'on')  % for even finer ticks
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]
hold on
plot(OPo,y2dN,'k-.','LineWidth',lw+0.4)
%xlim([OPo(1),OPo(end)])
xlim([-0.1,0.1])
set(gca,'FontSize',FSl)
grid on

ax = gca;
xlims = xlim(ax);
ylims = ylim(ax);

% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.135*range(ylims), 'D', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')

%% === Export do JPG ===
exportgraphics(gcf,'Figures/Figure07.jpg', 'resolution', 600);
