function [tim,x,oaeFdp,oaeFdp2,oaeF1,oaeF2,oaeStFdp,oaeStFdp2,oaeStF1,oaeStF2,...
    RRFdp,RRFdp2,RRF1,RRF2,UUFdp,UUFdp2,UUF1,...
    UUF2,UUrFdp,UUrFdp2,UUrF1,UUrF2,TMdispFdp,TMdispFdp2,...
    TMdispF1,TMdispF2,UUr1Fdp,UUr1Fdp2,UUr1F1,UUr1F2] = Sim2ToneCDQD(A1o,F1o,A2o,F2o,gain,phi1o,...
    phi2o,T12ono,visual,TMres,faca0,facb0,OPo)
%simulation for one combination L1,L2,F1,F2, 
%calls "CochleaRGB_Tone_AVDissertace_Tone2"
%after simulation performs FFT at F1,F2,2F1-F2 (CDT),F2-F1(QDT)
%OUTPUT
%tim .... time vector
%x   .... coordinates along the BM in the longitudinal direction
%oaeFdp,oaeFdp2,oaeF1,oaeF2 .... OAE at CDT, QDT, F1, F2 estimated by the displacement of first BM segment
%oaeStFdp,oaeStFdp2,oaeStF1,oaeStF2 ... OAE at CDT, QDT, F1, F2 estimated by at ear drum, probably wrong not used
%RRFdp,RRFdp2,RRF1,RRF2  .... matrices with BM displacement in steady state
%UUFdp,UUFdp2,UUF1,UUF2  .... matrices with U at CDT, QDT, F1, F2, i.e. feedback force in steady state
%UUrFdp,UUrFdp2,UUrF1,UUrF2 ..... matrices with nonlinear part of U at CDT, QDT, F1, F2 in steady state, not multiplied by first derivative of BF
%TMdispFdp,TMdispFdp2,TMdispF1,TMdispF2 ... matrices with TM displacement at CDT, QDT, F1, F2 in steady state
%UUr1Fdp,UUr1Fdp2,UUr1F1,UUr1F2 .... matrices with nonlinear part of U at CDT, QDT, F1, F2 in steady state, multiplied by first derivative of BF
%

%INPUT
if nargin<1, A1o=50; end%[dB SPL] amplitude of F1 primary
if nargin<2, F1o=2176; end%[Hz] frequency of F1 primary
if nargin<3, A2o=A1o; end%[dB SPL] amplitude of F2 primary
if nargin<4, F2o=2688; end%[Hz] frequency of F2 primary
if nargin<5, gain=1.45; end%parameter to control gain of feedback force U
if nargin<5, phi1o=0; end%phase of F1 primary
if nargin<7, phi2o=0; end%phase of F2 primary
if nargin<8,T12ono = 0.01;end %input onset
if nargin<9,visual = 1; end %flag to control visualisation during calculation
if nargin<10,TMres = 0.35;end %shift between BM CF and TM resonance
if nargin<11,faca0=0.2;end %parameter of TM transfer function
if nargin<12,facb0=0.2;end %parameter of TM transfer function
if nargin<13,OPo=0;end  %OP shift
  
  %Simulation

  [oae,tim,x,RR,UU,UUr,oaeSt,TMdisp,UUr1]=CochleaRGB_Tone_AVDisertace_Tone2(A1o,F1o,A2o,F2o,gain,phi1o,phi2o,T12ono,visual,TMres,faca0,facb0,OPo);
  
   %DFT
        f1=F1o;%[Hz]
        f2=F2o;%[Hz]
        fdp=2*f1-f2;%[Hz]
        fdp2=f2-f1;%[Hz]
        h=1/204.8E3;   %time step
        Fs=204.8E3;   %sampling frequency
        Tan = 90e-3; % start of analysis window
        Nan = round(Tan*Fs);
        Nw =3200;
        Nwin=Nw;
       % fw = Fs*(0:(Nw/2))/Nw;
        idxFdp2=round(fdp2*Nw/Fs)+1; 
        idxFdp=round(fdp*Nw/Fs)+1;
        idxF1=round(F1o*Nw/Fs)+1;
        idxF2=round(F2o*Nw/Fs)+1;
        oaeF = fft(oae(Nan:Nw+Nan-1))/Nw;
        oaeFdp2= abs(2*oaeF(idxFdp2));
        oaeFdp= abs(2*oaeF(idxFdp));
        oaeF1= abs(2*oaeF(idxF1));
        oaeF2= abs(2*oaeF(idxF2));
        %
        oaeStF = fft(oaeSt(Nan:Nwin+Nan-1))/Nwin;
        oaeStFdp2= abs(2*oaeStF(idxFdp2));
        oaeStFdp= abs(2*oaeStF(idxFdp));
        oaeStF1= abs(2*oaeStF(idxF1));
        oaeStF2= abs(2*oaeStF(idxF2));
    %



         RRF = fft(RR(:,Nan:Nwin+Nan-1).')/Nwin;
         RRFdp2 = 2*RRF(idxFdp2,:);
         RRFdp = 2*RRF(idxFdp,:);
         RRF1= 2*RRF(idxF1,:);
         RRF2= 2*RRF(idxF2,:);

         UUrF = fft(UUr(:,Nan:Nwin+Nan-1).')/Nwin;
         UUrFdp2= 2*UUrF(idxFdp2,:);
         UUrFdp= 2*UUrF(idxFdp,:);
         UUrF1= 2*UUrF(idxF1,:);
         UUrF2 = 2*UUrF(idxF2,:);
         
         UUr1F = fft(UUr1(:,Nan:Nwin+Nan-1).')/Nwin;
         UUr1Fdp2= 2*UUr1F(idxFdp2,:);
         UUr1Fdp= 2*UUr1F(idxFdp,:);
         UUr1F1= 2*UUr1F(idxF1,:);
         UUr1F2 = 2*UUr1F(idxF2,:);

        UUF = fft(UU(:,Nan:Nwin+Nan-1).')/Nwin;
        UUFdp2= 2*UUF(idxFdp2,:);
        UUFdp= 2*UUF(idxFdp,:);
        UUF1= 2*UUF(idxF1,:);
        UUF2= 2*UUF(idxF2,:);

        TMdispF = fft(TMdisp(:,Nan:Nwin+Nan-1).')/Nwin;
        TMdispFdp2 = 2*TMdispF(idxFdp2,:);
        TMdispFdp = 2*TMdispF(idxFdp,:);
        TMdispF1= 2*TMdispF(idxF1,:);
        TMdispF2= 2*TMdispF(idxF2,:);
        
     


end

