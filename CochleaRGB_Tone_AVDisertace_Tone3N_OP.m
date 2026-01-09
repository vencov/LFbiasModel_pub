function [oae,tim,x,RR,UU,UUr,oaeSt,TMdisp,UUr1]=CochleaRGB_Tone_AVDisertace_Tone3N_OP(A1o,F1o,A2o,F2o,gain,phi1o,phi2o,T12ono,visual,TMres,A3o,F3o,phi3o,T3ono,faca0,facb0,OPo)
%performs time domain simulation of nonlinear hydrodynamic cochlea model for three tones, second order BF 
%OUTPUT
%oae .... OAE estimated by the displacement of first BM segment
%tim .... time vector
%x   .... coordinates along the BM in the longitudinal direction
%RR  .... matrix with BM displacement in steady state
%UU  .... matrix with U, i.e. feedback force in steady state
%UUr ..... matrix with nonlinear part of U in steady state, not multiplied by first derivative of BF
%oaeSt ... OAE estimated by at ear drum, probably wrong not used
%TMdisp ... matrix with TM displacement in steady state
%UUrl .... matrix with nonlinear part of U in steady state, multiplied by first derivative of BF

if nargin < 1,  A1o=40; end %[dB SPL] amplitude of F1 primary
if nargin < 2,  F1o=2000; end%[Hz] frequency of F1 primary
if nargin < 3,  A2o=40; end %[dB SPL] amplitude of F2 primary
if nargin < 4,  F2o=2400; end%[Hz] frequency of F2 primary
if nargin < 5,  gain=1.32; end %parameter to control gain of feedback force U
if nargin < 6,  phi1o=0; end %phase of F1 primary
if nargin < 7,  phi2o=0; end %phase of F2 primary
if nargin < 8, T12ono = 0.005; end; %input onset
if nargin < 9, visual = 1; end; %flag to control visualisation during calculation
if nargin < 10, TMres = 0.42; end; %shift between BM CF and TM resonance
if nargin < 11, A3o=20; end %[dB SPL] amplitude of F3 primary
if nargin < 12, F3o=32; end%[Hz] frequency of bias
if nargin < 13, phi3o=0; end %phase of F3 primary
if nargin < 14, T3ono =0.005; end %F3 input onset
if nargin < 15, faca0 =0.01; end %parameter of TM transfer function
if nargin < 16, facb0 =0.01; end %parameter of TM transfer function
if nargin < 17, OPo =0; end %OP shift

global Ginv DampSp  stiff bigamma wm2 undamp N MEinv kME hME Gme Sty gammaAir ...
      Ve GammaMi Gs Qbm Sow Wbm Pea
  
global A1 A2 A3 F1 F2 F3 phi1 phi2 phi3 T12on T3on  Opsh faca facb

ResetAll; %reset global

A1=A1o;A2=A2o;A3=A3o;F1=F1o;F2=F2o;F3=F3o;phi1=phi1o; phi2=phi2o; phi3=phi3o; 
Opsh = OPo;
T12on = T12ono; T3on = T3ono; 
faca=faca0;
facb=facb0;

Fs=204.8E3;
h=1/Fs;   %time step 5e-6/3; 
I=sqrt(-1);


%________________________MODEL PARAMETERS_____________________________________%
 N=800;

 [x,Ginv,stiff,DampSp,undamp,bigamma,wm2,Qbm,Qs, MEinv, kME, hME, Gme, Sty, gammaAir, ...
     Ve, GammaMi, Gs, Sow, Wbm, Pea] = alldataRGmePaTM(N,gain,TMres); 
  
 
  %oughScale = 0.07;

 
 
Lp=19*Fs/F3; % 32 Hz
Lp=8*Fs/F3; % 32 Hz  % used in the paper
%Lp=20*Fs/F3; % 96 Hz
t1=(0:Lp-1)*h;
Sig = zeros(size(t1));

for k=1:length(t1)
    [Sig(k)]=Inp_sig3PrimariesME(F1,A1,F2,A2,F3,A3,t1(k),phi1,phi2,phi3,T12on,T3on); 
end

Ma1 = max(abs(Sig));
Ma1=Ma1*1.1;
Lp=length(t1);
%________________________Graphics_________________________________
 y=zeros(size(x));
if visual 
 H_FIG = figure('Name','HUMAN COCHLEA MODEL','DoubleBuffer','on','NumberTitle','off');
   H_BM=axes('Position', [.072 .1 .9 .4], 'Box', 'on','XLim',[x(1),x(N)],'YLim',[-1E-4,1E-4]);
      h_tit1 = text(-1, 0, 'BM displacement');
      set(H_BM, 'Title', h_tit1);
      h_L1 = line('XData',x,'YData',zeros(N,1),'Color', 'r');
           xlabel('Distance from stapes [cm]');
         
   H_SIG =	axes('Box', 'on','Position',[0.072,0.675,0.9,0.25]);
   set(H_SIG,'Xlim', [0, t1(Lp)], 'Ylim', [-Ma1, Ma1]);
   h_tit2 = text(-1, 0, ['Input signal-->F1:=',num2str(F1),' F2:=',num2str(F2) ' [Hz]',' F3:=',num2str(F3) ' [Hz]'],'Tag','h_tit2');
   h_xlbl2 = text(-1,0, 'Time [sec]', 'Tag','h_xlbl2');
   h_ylbl2 = text(-1,0, 'Amplitude', 'Tag', 'h_ylbl2');
   set(H_SIG, 'Title', h_tit2,'XLabel', h_xlbl2, 'YLabel',h_ylbl2);
   h_L2 = line('XData',t1,'YData',Sig,'Color', 'b');
   h_L0=line('Xdata', [t1(1), t1(1)], 'Ydata', [-Ma1, Ma1]);   
   set(h_L0, 'Color', 'r');
   drawnow;
end
 %_________________________RUNGE KUTTA____________________________________%
 n_c=1;             %statistic for graphics 
 t0=0;              %start time
 y0=zeros(4*N+3,1);   %initial conditions
 y=y0(:);
 t=t0;
 neq = length(y);
 %------------------------------------------- 
 pow = 1/5;
 A = [1/5; 3/10; 4/5; 8/9; 1; 1];
 B = [
    1/5         3/40    44/45   19372/6561      9017/3168       35/384
    0           9/40    -56/15  -25360/2187     -355/33         0
    0           0       32/9    64448/6561      46732/5247      500/1113
    0           0       0       -212/729        49/176          125/192
    0           0       0       0               -5103/18656     -2187/6784
    0           0       0       0               0               11/84
    ];

F = zeros(neq,6);


hA = h * A;
hB = h * B;
%____________________Main routine___________________________________%
oae = zeros(Lp,1);
oaeSt = zeros(Lp,1);
tim = zeros(Lp,1);

count=0;
ind1=1;%find(x>0.8);
ind2=N;%find(x>2,1,'first');

RR = zeros(N,Lp);
UU = zeros(N,Lp);
UUr = zeros(N,Lp);
TMdisp = zeros(N,Lp);
[qq,qq1d,~,qq3d]=NonlinLN(Opsh);
while count<Lp   
                             
       F(:,1) = activeCN(t,y);
       F(:,2) = activeCN(t + hA(1), y + F*hB(:,1));
       F(:,3) = activeCN(t + hA(2), y + F*hB(:,2));
       F(:,4) = activeCN(t + hA(3), y + F*hB(:,3));
       F(:,5) = activeCN(t + hA(4), y + F*hB(:,4));
       F(:,6) = activeCN(t + hA(5), y + F*hB(:,5));
       
       
       dy=F*hB(:,6);
       

       oae(count+1) = F(4*N+3); 
       oaeSt(count+1)=Qs*dy(4*N+2)/h+Qbm*dy(N+1:2*N)/h;
      % oae(count+1)=Qbm*dy(N+1:2*N)/h;%????
      % tim(count+1) = Qs*II;
       
       tim(count+1)=t + hA(5);
       %tim(count+1)=t + hA(5);
        
       t = t + hA(6);
       y = y + F*hB(:,6);
       
       RR(:,count+1)=y(ind1:ind2);%\ksi BM displacement?
       %2*N+1:3*N % pro TM disp
       UU(:,count+1)= undamp(ind1:ind2).*(nonlin(y(2*N+ind1:2*N+ind2)));%U?
       UUr(:,count+1)= undamp(ind1:ind2).*((nonlin(y(2*N+ind1:2*N+ind2)+Opsh)-nonlin(Opsh))-y(2*N+ind1:2*N+ind2));%U?
       UUr1(:,count+1)= undamp(ind1:ind2).*((nonlin(y(2*N+ind1:2*N+ind2)+Opsh)-nonlin(Opsh))-qq1d*y(2*N+ind1:2*N+ind2));
       TMdisp(:,count+1) = y(2*N+ind1:2*N+ind2);
              
       if n_c==160&&visual %graphics
           Ma1=1.5*max(abs(y(1:N)));
           set(h_L1,'Ydata',y(1:N));
           set(h_L0, 'Xdata', [t, t], ...
             'Color', 'r');   
           set(H_BM,'Ylim', [-Ma1, Ma1]);
           n_c=0;
           drawnow; 
       end
       n_c=n_c+1;
       count=count+1;
      
      
                
end
if visual, close(H_FIG); end;

    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------UTILITY----------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-----------------------------------------------------------%%     
function ResetAll

 global Ginv DampSp  stiff bigamma wm2 undamp N MEinv kME hME Gme Sty gammaAir ...
        Ve GammaMi Gs Qbm Sow Wbm Pea faca facb
 
 global  Sf A1 A2 A3 F1 F2 F3 phi1 phi2 phi3 T12on 
 
 Ginv=[]; DampSp=[]; stiff=[]; bigamma=[]; wm2=[];
 MEinv=[]; kME = []; hME = []; Gme = []; Sty=[]; gammaAir = []; Ve = []; 
 GammaMi = []; Gs = []; Qbm = []; Sow = []; Wbm = [];   Pea = [];
 T12on = []; 
 
 undamp=[]; N=[];
 Sf=[]; A1=[]; A2=[];  A3=[];  F1=[]; F2=[]; F3=[]; phi1=[]; phi2=[];phi3=[];
 faca=[]; facb=[];
    
  
%---------------------------------------
function dXdV = passiveC(t,XV)

  global BMinput Ginv DampSp  stiff  N   
  global om om2 fac 
  
   inp=-tanh(t*fac)*om2*cos(om*t);
   X=XV(1:N);
   V=XV(N+1:2*N);

   dV = -BMinput*inp-Ginv*(stiff.*X + DampSp*V); 

   dXdV=[V
          dV];

%---------------------------------------
 function dXdVdYdW = activeC(t,XVYW)

global Ginv DampSp  stiff bigamma wm2 undamp N MEinv kME hME Gme Sty gammaAir ...
        Ve GammaMi Gs Qbm Sow Wbm Pea
    
global A1 A2 A3 F1 F2 F3 phi1 phi2 phi3 T12on T3on
 
    inp=Inp_sig3PrimariesME(F1,A1,F2,A2,F3,A3,t,phi1,phi2,phi3,T12on,T3on); 
      
    X=XVYW(1:N);
    V=XVYW(N+1:2*N);
    Y=XVYW(2*N+1:3*N);
    W=XVYW(3*N+1:4*N);
    Xme = XVYW(4*N+1);
    Vme = XVYW(4*N+2);
    

    Ycut=nonlin(Y);
   
    dV = -1*Ginv*(stiff.*X + DampSp*V + undamp.*Ycut - Gs*MEinv*hME*Vme - Gs*MEinv*kME*Xme + Gs*MEinv*Sow*Gme*inp);
    dVme = -1*MEinv*(hME*Vme + kME*Xme + Sow*Qbm*dV/Wbm - Sow*Gme*inp);
    
    Pe = inp - gammaAir*Pea*Sty*GammaMi/Ve*Xme;
        
    dXdVdYdW=[ V                          %N
               dV                         %2N 
               W                          %3N
               -bigamma.*W - wm2.*Y - dV  %4N
               Vme                        %4N+1   
               dVme                       %4N+2 
               Pe                         %4N+3
                ];  
            %---------------------------------------
 function dXdVdYdW = activeCN(t,XVYW)

global Ginv DampSp  stiff bigamma wm2 undamp N MEinv kME hME Gme Sty gammaAir ...
        Ve GammaMi Gs Qbm Sow Wbm Pea
    
global A1 A2 A3 F1 F2 F3 phi1 phi2 phi3 T12on T3on faca facb Opsh
 
    inp=Inp_sig3PrimariesME(F1,A1,F2,A2,F3,A3,t,phi1,phi2,phi3,T12on,T3on); 
      
    X=XVYW(1:N);
    V=XVYW(N+1:2*N);
    Y=XVYW(2*N+1:3*N);
    W=XVYW(3*N+1:4*N);
    Xme = XVYW(4*N+1);
    Vme = XVYW(4*N+2);
    

    %Ycut=nonlin(Y) - nonlin(0);
    Ycut=nonlin(Y+Opsh) - nonlin(Opsh);
    dV = -1*Ginv*(stiff.*X + DampSp*V + undamp.*Ycut - Gs*MEinv*hME*Vme - Gs*MEinv*kME*Xme + Gs*MEinv*Sow*Gme*inp);
    dVme = -1*MEinv*(hME*Vme + kME*Xme + Sow*Qbm*dV/Wbm - Sow*Gme*inp);
    
    Pe = inp - gammaAir*Pea*Sty*GammaMi/Ve*Xme;
        
    dXdVdYdW=[ V                          %N
               dV                         %2N 
               W                          %3N
               -bigamma.*W - wm2.*Y - dV-faca*bigamma.*V-facb*wm2.*X  %4N
               Vme                        %4N+1   
               dVme                       %4N+2 
               Pe                         %4N+3
                ];  



 
