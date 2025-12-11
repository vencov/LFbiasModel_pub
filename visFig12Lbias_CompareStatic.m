% generate Figure 12 in the paper

load('../Data/dataLbias_Comparison.mat');
 
load ../Data/DPOAEOPL130L230V3.mat oaeFdp2a oaeFdpa
oaeFdpa30 = oaeFdpa;
load ../Data/DPOAEOPL150L250V3 oaeFdp2a oaeFdpa
oaeFdpa50 = oaeFdpa;
load ../Data/DPOAEOPL170L270V3 oaeFdp2a oaeFdpa
oaeFdpa70 = oaeFdpa;

% Normalize each signal to its value at TMdataFrame == 0
[~, idx30] = min(abs(TMdataFrame30));  % index closest to 0
[~, idx50] = min(abs(TMdataFrame50));
[~, idx70] = min(abs(TMdataFrame70));

normSig30 = 20 * log10(sig_oae_30 / sig_oae_30(idx40));
normSig50 = 20 * log10(sig_oae_50 / sig_oae_50(idx60));
normSig70 = 20 * log10(sig_oae_70 / sig_oae_70(idx80));

OPo=[-0.1:0.01:-0.05,-0.047:0.003:0,0,0.003:0.003:0.05,0.05:0.01:0.2];

[~, idxOP30] = min(abs(OPo));  % index closest to 0

% Plotting
figure;
clf
clf
screenSize = get(0, 'Screensize');
width = screenSize(3) / 4;  % smaller width
height = screenSize(4) / 3.4; % smaller height
left = screenSize(1) + screenSize(3)/3;  
bottom = screenSize(2) + screenSize(4)/4; 
set(gcf, 'Position', [left, bottom, width, height])


hold on;
lw = 1.5;
plot(TMdataFrame30, normSig30, 'b', 'DisplayName', '30 dB, LF biased','LineWidth',lw);
plot(OPo,20*log10(abs(oaeFdpa30/oaeFdpa30(idxOP30))),'b--', 'DisplayName', '30 dB, static shift','LineWidth',lw);
plot(TMdataFrame50, normSig50, 'r', 'DisplayName', '50 dB, LF biased','LineWidth',lw);
plot(OPo,20*log10(abs(oaeFdpa50/oaeFdpa50(idxOP30))),'r--', 'DisplayName', '50 dB, static shift','LineWidth',lw);
plot(TMdataFrame70, normSig70, 'k', 'DisplayName',  '70 dB, LF biased','LineWidth',lw);
plot(OPo,20*log10(abs(oaeFdpa70/oaeFdpa70(idxOP30))),'k--', 'DisplayName', '70 dB, static shift','LineWidth',lw);
xlim([-0.015,0.015])
xlabel('{\ity}_0 or {\ity}_{{OP}_{\itD}}');
ylabel('Normalized amplitude [dB]');
legend('Location', 'South');
grid on;
%title('OAE signal normalized to t = 0');
set(gca, 'FontSize', 12);
box on;

%% Export the figure
exportgraphics(gcf, 'Figures/Figure12.jpg', 'resolution', 600);
