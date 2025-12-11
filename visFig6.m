% Fig. 6

load ../Data/DPOAEOPL140L240V3.mat 
load bmdataME.mat x 
OPo1=[-0.1:0.01:-0.05,-0.047:0.003:0,0,0.003:0.003:0.05,0.05:0.01:0.2];

oaeFdpaA=oaeFdpa;
oaeFdp2aA=oaeFdp2a;

[Sila1Ma,indM1a]=max(UUr1Fdpa');
[Sila2Ma,indM2a]=max(UUrFdp2a');

load ../Data/DPOAEOPL140L240V3sym 

oaeFdpaS=oaeFdpa;
oaeFdp2aS=oaeFdp2a;


OPo=[-0.1:0.01:-0.05,-0.047:0.003:0];
OPo2=[OPo,0,-OPo(end:-1:1)];

[Sila1Ms,indM1s]=max(UUr1Fdpa');
[Sila2Ms,indM2s]=max(UUrFdp2a');


[ya,y1da,y2da,y3da]=NonlinLN(OPo1);

[ys,y1ds,y2ds,y3ds]=NonlinSNorm(OPo2);


%%

figure(2)
clf
screenSize = get(0, 'Screensize');
width = screenSize(3) / 2;
height = screenSize(4) / 2;
left = screenSize(1) + screenSize(3)/4;
bottom = screenSize(2) + screenSize(4)/4;
set(gcf, 'Position', [left, bottom, width, height])

tiledlayout(2,2,'TileSpacing','compact','Padding','loose')
idx = 1:8:length(x);
FSl = 13;
lw = 1.6;

% === SUBPLOT A ===
nexttile
semilogy(OPo1,oaeFdpaA/max(oaeFdpaA),'r',OPo1,Sila1Ma/max(Sila1Ma),'r:', 'LineWidth',lw)
lgd = legend('$\mathrm{OAE}_{\mathrm{CDT}}$', '$\max(U^{\mathrm{NL}}_{\mathrm{CDT}})$', 'Interpreter', 'latex');
set(lgd, 'Position', [0.34 0.81 0.13 0.1])  % Adjust as needed
xlim([OPo1(1),OPo1(end)])
xlim([OPo1(1),0.1])

ylim([1E-4,2])
ylabel('Normalized amplitude ')
set(gca,'FontSize',FSl)
set(gca, 'YTick', [0.0001 0.01 1 100])
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]
grid on
title('2nd-order Boltzmann function')

% Label A
ax = gca;
text(ax.XLim(1)+0.05*range(ax.XLim), ax.YLim(2)-0.7*range(ax.YLim), 'A', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')
ax = gca;
ax.XMinorTick = 'off';
ax.YMinorTick = 'off';
ax.MinorGridLineStyle = 'none';  % ensure no minor grid
% === SUBPLOT B ===
nexttile
semilogy(OPo2,oaeFdpaS/max(oaeFdpaS),'r',OPo2,Sila1Ms/max(Sila1Ms),'r:', 'LineWidth',2)
lgd = legend('$\mathrm{OAE}_{\mathrm{CDT}}$', '$\max(U^{\mathrm{NL}}_{\mathrm{CDT}})$', 'Interpreter', 'latex');
set(lgd, 'Position', [0.77 0.81 0.13 0.1])  % Adjust as needed
xlim([OPo2(1),OPo2(end)])
ylim([1e-4,2])
set(gca,'FontSize',FSl)
set(gca, 'YTick', [0.0001 0.01 1 100])
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]
grid on
title('1st-order Boltzmann function')

% Label B
ax = gca;
text(ax.XLim(1)+0.05*range(ax.XLim), ax.YLim(2)-0.7*range(ax.YLim), 'B', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')
ax = gca;
ax.XMinorTick = 'off';
ax.YMinorTick = 'off';
ax.MinorGridLineStyle = 'none';  % ensure no minor grid
% === SUBPLOT C ===
nexttile
semilogy(OPo1,oaeFdp2aA/max(oaeFdp2aA),'b',OPo1,Sila2Ma/max(Sila2Ma),'b:', 'LineWidth',2)
xlabel('{\ity}_0')
ylabel('Normalized amplitude ')
lgd = legend('$\mathrm{OAE}_{\mathrm{QDT}}$', ['$\max(U^{\mathrm{NL}}_{\mathrm{' ...
    'QDT}})$'], 'Interpreter', 'latex');
set(lgd, 'Position', [0.22 0.16 0.13 0.1])  % Adjust as needed
xlim([OPo1(1),OPo1(end)])
xlim([OPo1(1),0.1])
ylim([1e-4,2])
set(gca,'FontSize',FSl)
set(gca, 'YTick', [0.0001 0.01 1 100])
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]
grid on

% Label C
ax = gca;
text(ax.XLim(1)+0.05*range(ax.XLim), ax.YLim(2)-0.7*range(ax.YLim), 'C', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')
ax = gca;
ax.XMinorTick = 'off';
ax.YMinorTick = 'off';
ax.MinorGridLineStyle = 'none';  % ensure no minor grid
% === SUBPLOT D ===
nexttile
semilogy(OPo2,oaeFdp2aS/max(oaeFdp2aS),'b',OPo2,Sila2Ms/max(Sila2Ms),'b:', 'LineWidth',lw)
xlabel('{\ity}_0')
lgd = legend('$\mathrm{OAE}_{\mathrm{QDT}}$', ['$\max(U^{\mathrm{NL}}_{\mathrm{' ...
    'QDT}})$'], 'Interpreter', 'latex');
set(lgd, 'Position', [0.735 0.16 0.13 0.1])  % Adjust as needed
ylim([1e-4,2])
set(gca,'FontSize',FSl)
set(gca, 'YTick', [0.0001 0.01 1 100])
set(gca, 'TickLength', [0.015 0.015])  % Default is usually [0.01 0.025]
grid on

% Label D
ax = gca;
text(ax.XLim(1)+0.05*range(ax.XLim), ax.YLim(2)-0.7*range(ax.YLim), 'D', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')

ax = gca;
ax.XMinorTick = 'off';
ax.YMinorTick = 'off';
ax.MinorGridLineStyle = 'none';  % ensure no minor grid

%% === Export do EPS ===
% print('-depsc2', '-loose', 'BodovostsilyV2.eps')
exportgraphics(gcf,'Figures/Figure06.jpg', 'resolution', 600);