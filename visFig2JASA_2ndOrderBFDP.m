% generates Figure 2 in the paper

clear all
N=3200;%number of time points
Fs=204.8E3;%[Hz] sampling frequency
f1=2176;%[Hz]
f2=2688;%[Hz]
fdp=2*f1-f2;%[Hz]
A1=[0.001,0.005,0.007,0.01,0.02,0.03,0.04,0.05];%amplitude of f1 tone
A2=[0.001,0.005,0.007,0.01,0.02,0.03,0.04,0.05];%amplitude of f2 tone
Ts=1/Fs;
t=Ts*(1:N);
%for DFT
I=sqrt(-1);
E1=exp(I*2*pi*f1*t);
E2=exp(I*2*pi*f2*t);
Edp=exp(I*2*pi*fdp*t);
Eqdp = exp(I*2*pi*(f2-f1)*t);
bias=-0.2:0.001:0.2;
%
x=bias;
Nx=length(bias);
% x=linspace(-0.02,0.02,Nx);
[yn,y1d,y2d,y3d]=NonlinLN(bias);
y3da=abs(y3d);%absolute value of third derivative of second order Boltzman function
y2da=abs(y2d);%absolute value of second derivative of second order Boltzman function
y1da=abs(y1d);%absolute value of first derivative of second order Boltzman function
a=(y1d.^3).*(abs(y3d));


for j=1:8
    S1=A1(j)*sin(2*pi*f1*t);
    S2=A2(j)*sin(2*pi*f2*t);
    S=S1+S2;
    
    %adding DC bias,passing throught nonlinearity,DFT
    for i=1:length(bias)
        %adding DC bias+nonlinearity
        [y]=NonlinLN(S+bias(i));
        %DFT
        y=y-mean(y);
        Adp(j,i)=2/N*abs(sum(y.*Edp));
        An1(j,i)=2/N*abs(sum(y.*E1));
        An2(j,i)=2/N*abs(sum(y.*E2));
        Aqdp(j,i)=2/N*abs(sum(y.*Eqdp));
    end
    R=corrcoef([y3da',Adp(j,:)']);
    rr2(j)=R(1,2)^2;
    RF1=corrcoef([y1da',An1(j,:)']);
    rr2F1(j)=RF1(1,2)^2;
    RF2=corrcoef([y1da',An2(j,:)']);
    rr2F2(j)=RF2(1,2)^2;
    Rqdp=corrcoef([y2da',Aqdp(j,:)']);
    rr2qdp(j)=Rqdp(1,2)^2;
end


%% Figure
figure(110), clf

% Figure size 2× smaller and centered
screenSize = get(0, 'Screensize');
width = screenSize(3) / 2;
height = screenSize(4) / 2;
left = screenSize(1) + screenSize(3)/4;
bottom = screenSize(2) + screenSize(4)/4;
set(gcf, 'Position', [left, bottom, width, height])

% Tight layout
tiledlayout(2,3,'TileSpacing','compact','Padding','loose')

iFontSize = 11;
lw = 1.5; % line width

% === 1st COLUMN ===
nexttile(1)
hold on
plot(bias, An1(1,:)/max(An1(1,:)), 'k-', 'LineWidth', lw)
plot(bias, An1(3,:)/max(An1(3,:)), '-', 'Color', [0.5 0.5 0.5], 'LineWidth', lw)
plot(bias, An1(5,:)/max(An1(5,:)), 'k:', 'LineWidth', lw)
plot(bias, An1(7,:)/max(An1(7,:)), 'k--', 'LineWidth', lw)
plot(x, y1da/max(y1da), 'r--', 'LineWidth', lw)
hold off
title('{\itf_1} comp. and 1st derivative')
ylabel('Normalized amplitude')
set(gca,'FontSize',iFontSize)
text(0.02, 0.9, 'A', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', iFontSize+2)
box on

nexttile(4)
hold on
plot(A1, rr2F1, 'k','LineWidth',2)
plot(A1(1), rr2F1(1), 'k+', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(3), rr2F1(3), 'ko', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(5), rr2F1(5), 'kx', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(7), rr2F1(7), 'k*', 'MarkerSize', 12, 'LineWidth', lw)
hold off
ylabel('{\itr^2}')
set(gca,'FontSize',iFontSize)
xlim([0 0.05])
ylim1 = ylim;
text(0.95, 0.9, 'D', 'Units', 'normalized', 'HorizontalAlignment', 'right', 'FontWeight', 'bold', 'FontSize', iFontSize+2)
box on

% === 2nd COLUMN ===
nexttile(2)
hold on
plot(bias, Aqdp(1,:)/max(Aqdp(1,:)), 'k-', 'LineWidth', lw)
plot(bias, Aqdp(3,:)/max(Aqdp(3,:)), '-', 'Color', [0.5 0.5 0.5], 'LineWidth', lw)
plot(bias, Aqdp(5,:)/max(Aqdp(5,:)), 'k:', 'LineWidth', lw)
plot(bias, Aqdp(7,:)/max(Aqdp(7,:)), 'k--', 'LineWidth', lw)
plot(x, y2da/max(y2da), 'r--', 'LineWidth', lw)
hold off
t = title('QDT comp. and 2nd derivative');
pos = t.Position;       % Get current [x y z] position
pos(2) = pos(2) + 0.04; % Shift upward (increase y)
t.Position = pos;
xlabel('static OP shift')
set(gca,'FontSize',iFontSize)
text(0.02, 0.9, 'B', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', iFontSize+2)
box on

nexttile(5)
hold on
plot(A1, rr2qdp, 'k','LineWidth',2)
plot(A1(1), rr2qdp(1), 'k+', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(3), rr2qdp(3), 'ko', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(5), rr2qdp(5), 'kx', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(7), rr2qdp(7), 'k*', 'MarkerSize', 12, 'LineWidth', lw)
hold off
xlabel('Amplitude of primaries {\itA}_1, {\itA}_2')
set(gca,'FontSize',iFontSize)
xlim([0 0.05])
ylim2 = ylim;
text(0.95, 0.9, 'E', 'Units', 'normalized', 'HorizontalAlignment', 'right', 'FontWeight', 'bold', 'FontSize', iFontSize+2)
box on

% === 3rd COLUMN ===
nexttile(3)
hold on
plot(bias, Adp(1,:)/max(Adp(1,:)), 'k-', 'LineWidth', lw)
plot(bias, Adp(3,:)/max(Adp(3,:)), '-', 'Color', [0.5 0.5 0.5], 'LineWidth', lw)
plot(bias, Adp(5,:)/max(Adp(5,:)), 'k:', 'LineWidth', lw)
plot(bias, Adp(7,:)/max(Adp(7,:)), 'k--', 'LineWidth', lw)
plot(x, y3da/max(y3da), 'r--', 'LineWidth', lw)
hold off
t = title('CDT comp. and 3rd derivative')
pos = t.Position;       % Get current [x y z] position
pos(2) = pos(2) + 0.04; % Shift upward (increase y)
t.Position = pos;
% xlabel('DC bias')
hLeg = legend('{\itA}_1={\itA}_2=0.001','{\itA}_1={\itA}_2=0.007','{\itA}_1={\itA}_2=0.02','{\itA}_1={\itA}_2=0.04','Derivatives of S','FontSize',iFontSize-2);
pos = get(hLeg, 'Position'); % [left bottom width height]
pos(1) = pos(1) + 0.08;       % Shift to the right (increase the 'left' value)
set(hLeg, 'Position', pos);
set(gca,'FontSize',iFontSize)
text(0.02, 0.9, 'C', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', iFontSize+2)
box on

nexttile(6)
hold on
plot(A1, rr2, 'k','LineWidth',2)
plot(A1(1), rr2(1), 'k+', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(3), rr2(3), 'ko', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(5), rr2(5), 'kx', 'MarkerSize', 12, 'LineWidth', lw)
plot(A1(7), rr2(7), 'k*', 'MarkerSize', 12, 'LineWidth', lw)
hold off
set(gca,'FontSize',iFontSize)
xlim([0 0.05])
ylim3 = ylim;
text(0.95, 0.9, 'F', 'Units', 'normalized', 'HorizontalAlignment', 'right', 'FontWeight', 'bold', 'FontSize', iFontSize+2)
box on

% === Match y-limits for bottom row ===
ylims = [ylim1; ylim2; ylim3];
common_ylim = [min(ylims(:,1)), 1.1*max(ylims(:,2))];
nexttile(4), ylim(common_ylim)
nexttile(5), ylim(common_ylim)
nexttile(6), ylim(common_ylim)

% === Export ===

exportgraphics(gcf,'Figures/Figure02.jpg', 'resolution', 600);
