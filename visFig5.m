% generates Figure 5 in the paper

load ../Data/DPOAEOPL140L240V3.mat
load bmdataME.mat x
OPo=[-0.1:0.01:-0.05,-0.047:0.003:0,0,0.003:0.003:0.05,0.05:0.01:0.2];

%whos
ind=23;%nulovy posuv ind=23;
indp=3;
indp2=6;

line_colors = [ ...
    get(groot, 'defaultAxesColorOrder');  % 7 colors
    [0.5 0.5 0.5];  % gray
    [0 0 0]         % black
    ];

trP = 1;
reds  = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];
blacks = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];
blues = [0 0 0 1; [line_colors(1,:) trP]; [line_colors(3,:)  trP]; [line_colors(2,:)  trP]; [line_colors(4,:)  trP]];


%% Figure 5, TM disp
% -------- Layout positions (adjust as needed) --------
left = 0.08; midX = 0.52;
bottom1 = 0.10; bottom2 = 0.56;
w = 0.38; h = 0.36;
ylimsAmp = [1e-2 2e0];
FSl = 13;  % fontsize for gca

lw = 1.8;  % nastavení šířky čáry, uprav podle potřeby

% ---- ROZMÍSTĚNÍ SUBPLOTŮ ----
figure(2)
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
hold on
%semilogy(x, RRF1a(ind,:), 'r', 'LineWidth', lw)
Uesta=(TMdispF1a(ind,:).^2).*TMdispF2a(ind,:);
Uesta1P=(TMdispF1a(ind+indp,:).^2).*TMdispF2a(ind+indp,:);
Uesta2P=(TMdispF1a(ind+indp2,:).^2).*TMdispF2a(ind+indp2,:);
Uesta1L=(TMdispF1a(ind-indp,:).^2).*TMdispF2a(ind-indp,:);
Uesta2L=(TMdispF1a(ind-indp2,:).^2).*TMdispF2a(ind-indp2,:);


hold on;
semilogy(x,UUrFdpa(ind,:)./max(UUrFdpa(ind,:)),'color',reds(1,:),'linewidth',lw)
semilogx(x,Uesta./max(Uesta),'--','color',reds(1,:),'linewidth',lw)

semilogy(x,UUrFdpa(ind-indp,:)./max(UUrFdpa(ind-indp,:)),'color',reds(2,:),'linewidth',lw)
semilogx(x,Uesta1L./max(Uesta1L),'--','color',reds(2,:),'linewidth',lw)


semilogy(x,UUrFdpa(ind+indp,:)./max(UUrFdpa(ind+indp,:)),'color',reds(3,:),'linewidth',lw)
semilogx(x,Uesta1P./max(Uesta1P),'--','color',reds(3,:),'linewidth',lw)

semilogy(x,UUrFdpa(ind-indp2,:)./max(UUrFdpa(ind-indp2,:)),'color',reds(4,:),'linewidth',lw)
semilogx(x,Uesta2L./max(Uesta2L),'--','color',reds(4,:),'linewidth',lw)

semilogy(x,UUrFdpa(ind+indp2,:)./max(UUrFdpa(ind+indp2,:)),'color',reds(5,:),'linewidth',lw)
semilogx(x,Uesta2P./max(Uesta2P),'--','color',reds(5,:),'linewidth',lw)
hold off
set(gca,'xscale','log');


%semilogy(x,UUrFdpa(ind,:)./max(UUrFdpa(ind,:)),'r',x,Uesta./max(Uesta),'r--' ,...
%    x,UUrFdpa(ind+indp,:)./max(UUrFdpa(ind+indp,:)),'b',x,Uesta1P./max(Uesta1P),'b--', ...
%    x,UUrFdpa(ind+indp2,:)./max(UUrFdpa(ind+indp2,:)),'m',x,Uesta2P./%max(Uesta2P),'m--',...
%    x,UUrFdpa(ind-indp,:)./max(UUrFdpa(ind-indp,:)),'g',x,Uesta1L./max(Uesta1L),'g--',...
%    x,UUrFdpa(ind-indp2,:)./max(UUrFdpa(ind-indp2,:)),'k',x,Uesta2L./%max(Uesta2L),'k--','LineWidth',lw)
xmin1=1.1;xmax1=1.35;
xmin2=1;xmax2=1.35;

set(gca,'FontSize',FSl)
set(gca, 'YTick', [0.01 0.1 1])
hold off
xlim([xmin1,xmax1]); ylim(ylimsAmp)
%xlabel('Distance from stapes [cm]')
ylabel('$|U|^{\mathrm{NL}_{\mathrm{norm}}}_{\mathit{n}_{\mathrm{CDT}}}(x)$', 'Interpreter', 'latex');
set(gca,'yscale','log')
grid on;
box on;
% Add letter in the top-left corner of the subplot axes

hold on
yl = ylim;   % rozsah y-ové osy aktuálního grafu

ax = gca;
xlims = xlim(ax);
ylims = ylim(ax);


% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.5*range(ylims), 'A', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')


%lgd=legend(num2str(OPo(ind)),num2str(OPo(ind)),...
%          num2str(OPo(ind+indp)),num2str(OPo(ind+indp)),...
%          num2str(OPo(ind+indp2)),num2str(OPo(ind+indp2)),...
%          num2str(OPo(ind-indp)),num2str(OPo(ind-indp)),...
%          num2str(OPo(ind-indp2)),num2str(OPo(ind-indp2)));
%    lgd.Title.String='x_0';



% --- SUBPLOT 2 --- amp
nexttile
hold on

Uesta2=(TMdispF1a(ind,:)).*TMdispF2a(ind,:);
Uesta1P2=(TMdispF1a(ind+indp,:)).*TMdispF2a(ind+indp,:);
Uesta2P2=(TMdispF1a(ind+indp2,:)).*TMdispF2a(ind+indp2,:);
Uesta1L2=(TMdispF1a(ind-indp,:)).*TMdispF2a(ind-indp,:);
Uesta2L2=(TMdispF1a(ind-indp2,:)).*TMdispF2a(ind-indp2,:);


hold on;
semilogy(x,UUrFdp2a(ind,:)./max(UUrFdp2a(ind,:)),'color',reds(1,:),'linewidth',lw)
semilogx(x,Uesta2./max(Uesta2),'--','color',reds(1,:),'linewidth',lw)

semilogy(x,UUrFdp2a(ind-indp,:)./max(UUrFdp2a(ind-indp,:)),'color',reds(2,:),'linewidth',lw)
semilogx(x,Uesta1L2./max(Uesta1L2),'--','color',reds(2,:),'linewidth',lw)


semilogy(x,UUrFdp2a(ind+indp,:)./max(UUrFdp2a(ind+indp,:)),'color',reds(3,:),'linewidth',lw)
semilogx(x,Uesta1P2./max(Uesta1P2),'--','color',reds(3,:),'linewidth',lw)

semilogy(x,UUrFdp2a(ind-indp2,:)./max(UUrFdp2a(ind-indp2,:)),'color',reds(4,:),'linewidth',lw)
semilogx(x,Uesta2L2./max(Uesta2L2),'--','color',reds(4,:),'linewidth',lw)

semilogy(x,UUrFdp2a(ind+indp2,:)./max(UUrFdp2a(ind+indp2,:)),'color',reds(5,:),'linewidth',lw)
semilogx(x,Uesta2P2./max(Uesta2P2),'--','color',reds(5,:),'linewidth',lw)
hold off
set(gca,'xscale','log');

xlim([xmin2,xmax2])
%xlabel('Distance from stapes [cm]')
ylabel('$|U|^{\mathrm{NL}_{\mathrm{norm}}}_{\mathit{n}_{\mathrm{QDT}}}(x)$', 'Interpreter', 'latex');

set(gca, 'YTick', [0.01 0.1 1])
set(gca, 'FontSize', FSl)
set(gca, 'yscale', 'log')
ylim(ylimsAmp)
box on;
grid on;



ax = gca;

xlims = xlim(ax);
ylims = ylim(ax);

% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.5*range(ylims), 'B', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')



Uestph=2*TMdispF1ph(ind,:)-TMdispF2ph(ind,:)+1.5;
Uestph1P=2*TMdispF1ph(ind+indp,:)-TMdispF2ph(ind+indp,:)+1.5;
Uestph2P=2*TMdispF1ph(ind+indp2,:)-TMdispF2ph(ind+indp2,:)+1.5;
Uestph1L=2*TMdispF1ph(ind-indp,:)-TMdispF2ph(ind-indp,:)+1.5;
Uestph2L=2*TMdispF1ph(ind-indp2,:)-TMdispF2ph(ind-indp2,:)+1.5;


nexttile
hold on


hold on;
plot(x,UUrFdpph(ind,:)+1,'color',reds(1,:),'linewidth',lw)
plot(x,Uestph,'--','color',reds(1,:),'linewidth',lw)
plot(x,UUrFdpph(ind-indp,:),'color',reds(2,:),'linewidth',lw)
plot(x,Uestph1L,'--','color',reds(2,:),'linewidth',lw)
plot(x,UUrFdpph(ind+indp,:),'color',reds(3,:),'linewidth',lw)
plot(x,Uestph1P,'--','color',reds(3,:),'linewidth',lw)
plot(x,UUrFdpph(ind-2*indp,:),'color',reds(4,:),'linewidth',lw)
plot(x,Uestph2L,'--','color',reds(4,:),'linewidth',lw)
plot(x,UUrFdpph(ind+2*indp,:),'color',reds(5,:),'linewidth',lw)
plot(x,Uestph2P,'--','color',reds(5,:),'linewidth',lw)
hold off
%
% plot(x,UUrFdpph(ind,:)+1,'r',x,Uestph,'r--',...
%     x,UUrFdpph(ind+indp,:),'b',x,Uestph1P,'b--',...
%     x,UUrFdpph(ind+indp2,:),'m',x,Uestph2P,'m--',...
%     x,UUrFdpph(ind-indp,:),'g',x,Uestph1L,'g--',...
%     x,UUrFdpph(ind-indp2,:),'k',x,Uestph2L,'k--','LineWidth',lw);
xlim([xmin1,xmax1])
ylabel('$\angle U^{\mathrm{NL}}_{\mathit{n}_{\mathrm{CDT}}}(x)$ [cycles]', 'Interpreter', 'latex');

xlabel('Distance from stapes [cm]')
set(gca,'FontSize',FSl)
grid on;
box on;

Uesta2=(TMdispF1a(ind,:).^1).*TMdispF2a(ind,:);
Uesta1P2=(TMdispF1a(ind+indp,:).^1).*TMdispF2a(ind+indp,:);
Uesta2P2=(TMdispF1a(ind+indp2,:).^1).*TMdispF2a(ind+indp2,:);
Uesta1L2=(TMdispF1a(ind-indp,:).^1).*TMdispF2a(ind-indp,:);
Uesta2L2=(TMdispF1a(ind-indp2,:).^1).*TMdispF2a(ind-indp2,:);


ax = gca;

xlims = xlim(ax);
ylims = ylim(ax);


% Position the letter a bit inside the upper-left corner
text(xlims(1) + 0.05*range(xlims), ylims(2) - 0.135*range(ylims), 'C', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')

yl = ylim;   % rozsah y-ové osy aktuálního grafu

% --- SUBPLOT 4 ---
nexttile
hold on



Uestph2= TMdispF2ph(ind,:)-TMdispF1ph(ind,:)+0;
Uestph1P2=TMdispF2ph(ind+indp,:)-TMdispF1ph(ind+indp,:)+0.0;
Uestph2P2=TMdispF2ph(ind+indp2,:)-TMdispF1ph(ind+indp2,:)-0.0;
Uestph1L2=TMdispF2ph(ind-indp,:)-TMdispF1ph(ind-indp,:);
Uestph2L2=TMdispF2ph(ind-indp2,:)-TMdispF1ph(ind-indp2,:);

hold on;
plot(x,UUrFdp2ph(ind,:),'color',reds(1,:),'linewidth',lw)
plot(x,Uestph2,'--','color',reds(1,:),'linewidth',lw)
plot(x,UUrFdp2ph(ind-indp,:),'color',reds(2,:),'linewidth',lw)
plot(x,Uestph1L2,'--','color',reds(2,:),'linewidth',lw)
plot(x,UUrFdp2ph(ind+indp,:)+0.5,'color',reds(3,:),'linewidth',lw)
plot(x,Uestph1P2,'--','color',reds(3,:),'linewidth',lw)
plot(x,UUrFdp2ph(ind-2*indp,:),'color',reds(4,:),'linewidth',lw)
plot(x,Uestph2L2,'--','color',reds(4,:),'linewidth',lw)
plot(x,UUrFdp2ph(ind+2*indp,:)+0.5,'color',reds(5,:),'linewidth',lw)
plot(x,Uestph2P2,'--','color',reds(5,:),'linewidth',lw)
hold off


xlim([xmin2,xmax2])
ylabel('$\angle U^{\mathrm{NL}}_{\mathit{n}_{\mathrm{QDT}}}(x)$ [cycles]', 'Interpreter', 'latex');

xlabel('Distance from stapes [cm]')
set(gca, 'FontSize', FSl)
grid on;

box on;

ax = gca;
xlims = xlim(ax);
ylims = ylim(ax);

% Position the letter a bit inside the upper-left corner
text(xlims(2) - 0.1*range(xlims), ylims(2) - 0.135*range(ylims), 'D', ...
    'FontWeight','bold', 'FontSize', FSl+6, 'Units','data')

% Zvetsi fonty v popiscích os a titulcích
%set(get(gca,'xlabel'),'FontSize',14)
%set(get(gca,'ylabel'),'FontSize',14)

% Zvetsi font legendy (hlavni subplot 1, pokud pouzitas)
%set(lgd, 'FontSize', 14)
%set(lgd.Title, 'FontSize', 16)


% Find all axes in figure (order is usually in plotting order)
%allAxes = findall(gcf, 'Type', 'axes');

% Collect y-label handles for the first column (left column)
% Assuming subplots are in order: 1 2 (top row), 3 4 (bottom row)
%ylabs = cell(2,1);
%ylabs{1} = get(allAxes(4), 'YLabel');  % Top-left subplot (usually last found axes)
%ylabs{2} = get(allAxes(2), 'YLabel');  % Bottom-left subplot

% Get current x positions
%pos1 = get(ylabs{1}, 'Position');  % [x y z]
%pos2 = get(ylabs{2}, 'Position');

% Choose common x position (e.g., minimum or fixed number)
%commonX = min(pos1(1), pos2(1));  % or just set e.g. -0.1

% Set y-label x position to the same for both
%%set(ylabs{1}, 'Position', [commonX pos1(2) pos1(3)]);
%set(ylabs{2}, 'Position', [commonX pos2(2) pos2(3)]);

% ---- VLASTNÍ LEGENDA se skupinou tří čar + jedno číslo ----
% Vytvoříme novou osu pro legendu (např. nahoře)
legendAx = axes('Position',[0.2 0.95 0.5 0.015]); % [left bottom width height]
axis(legendAx, 'off')  % vypnout osy
hold(legendAx, 'on')

% Y-pozice tří čar v každé skupině
ybase = [3 2 1];

% X-počáteční body pro každou skupinu
xstart = [1, 4, 7, 10, 13];  % nastav podle počtu skupin


%lgd=legend(num2str(OPo(ind)),num2str(OPo(ind)),...
%          num2str(OPo(ind+indp)),num2str(OPo(ind+indp)),...
%          num2str(OPo(ind+indp2)),num2str(OPo(ind+indp2)),...
%          num2str(OPo(ind-indp)),num2str(OPo(ind-indp)),...
%          num2str(OPo(ind-indp2)),num2str(OPo(ind-indp2)));
%    lgd.Title.String='x_0';


% Indexy posuvů
offsets = [0, -indp,+indp,-indp2,+indp2];
colors = {'r', 'b', 'm','g','k'};  % RRF1, RRF2, DPOAE
LineStyles ={'--','-'};
MarkerS = {'none','none','none','none','none'};
cS = {'k','b','g','r','m'};
for g = 1:length(offsets)
    x0 = xstart(g);
    opIndex = ind + offsets(g);
    for i = 1:2
        plot(legendAx, [x0-0.5 x0 x0+0.5], [ybase(i) ybase(i) ybase(i)], ...
            'Color', reds(g,:), ...
            'LineWidth', 2, ...
            'LineStyle', LineStyles{mod(i,2)+1},...
            'Marker',MarkerS{g})
    end
    % Zobraz číslo OPo vpravo od skupiny
    if OPo(opIndex)==0
        text(x0+0.7, 2.5, num2str(OPo(opIndex),'%d'), ...
            'FontSize', 10, 'VerticalAlignment', 'middle','color','k')
    else
        text(x0+0.7, 2.5, num2str(OPo(opIndex),'%0.3f'), ...
            'FontSize', 10, 'VerticalAlignment', 'middle','color','k')
    end
end

%% === Export do JPG ===

exportgraphics(gcf,'Figures/Figure05.jpg','resolution',600)

