clear all
close all
A1o=65; %[dB SPL]
F1o=2176;%[Hz]
A2o=60; %[dB SPL]
F2o=2688; %[Hz]
phi1o=0;
phi2o=0;
T12ono=0.05;
visual = 1;
Fs=204.8E3;
A3o=[100:2:130];
A3o = [100:5:125]
A3o = [90:5:120];
A3o = 115;
F3o=32;% 25, 32, 50, 75, and 100 [Hz]
phi3o=-pi/2;
T3ono=0.1;  
%nastaveni zesilovace
facb=0.2;
faca=0.2;
TMres = 0.35;
gain = 1.45;

Wn=1600;%3200 pro mensi nez 50 Hz
Fc=400;

OPs = 0;

for i=1:length(A3o)
    
    %i=1;
    
    oae=[];tim=[];x=[];RR=[];UU=[];UUr=[];oaeSt=[];TMdisp=[];
    phi1o = 0
    phi2o = 0
    [oae1,tim,x,RR1,UU1,UUr1,oaeSt1,TMdisp1]=CochleaRGB_Tone_AVDisertace_Tone3N_OP(A1o,F1o,A2o,F2o,gain,phi1o,phi2o,T12ono,visual,TMres,A3o(i),F3o,phi3o,T3ono,faca,facb,OPs);
    phi1o = pi/2
    phi2o = pi
    [oae2,tim,x,RR2,UU2,UUr2,oaeSt2,TMdisp2]=CochleaRGB_Tone_AVDisertace_Tone3N_OP(A1o,F1o,A2o,F2o,gain,phi1o,phi2o,T12ono,visual,TMres,A3o(i),F3o,phi3o,T3ono,faca,facb,OPs);
    phi1o = pi
    phi2o = 0
    [oae3,tim,x,RR3,UU3,UUr3,oaeSt3,TMdisp3]=CochleaRGB_Tone_AVDisertace_Tone3N_OP(A1o,F1o,A2o,F2o,gain,phi1o,phi2o,T12ono,visual,TMres,A3o(i),F3o,phi3o,T3ono,faca,facb,OPs);
    phi1o = 3/2*pi
    phi2o = pi
    [oae4,tim,x,RR4,UU4,UUr4,oaeSt4,TMdisp4]=CochleaRGB_Tone_AVDisertace_Tone3N_OP(A1o,F1o,A2o,F2o,gain,phi1o,phi2o,T12ono,visual,TMres,A3o(i),F3o,phi3o,T3ono,faca,facb,OPs);
    
    %save vysledek_32_115_1st oae tim RR F3o
    %save(['PhAnDPOAE_OPp50_8_65_55_' num2str(A3o(i)) '.mat'], 'oae1', 'oae2','oae3', 'oae4', 'tim', 'RR1', 'RR2', 'RR3', 'RR4', 'F3o','TMdisp1','TMdisp2','TMdisp3','TMdisp4')
    save(['PhNewAnDPOAE_OP0_32_65_60_' num2str(A3o(i)) '.mat'], 'oae1', 'oae2','oae3', 'oae4', 'tim', 'RR1', 'RR2', 'RR3', 'RR4', 'F3o','TMdisp1','TMdisp2','TMdisp3','TMdisp4')
    
    % [Foaef1Ap(i),Foaef1Php(i),Foaef2Ap(i),Foaef2Php(i),FoaefdpAp(i),FoaefdpPhp(i),Foaefdp1Ap(i),Foaefdp1Php(i), ...
    %        Foaef1At(i),Foaef1Pht(i),Foaef2At(i),Foaef2Pht(i),FoaefdpAt(i),FoaefdpPht(i),Foaefdp1At(i),Foaefdp1Pht(i), ...
    %        FoaeStf1Ap(i),FoaeStf1Php(i),FoaeStf2Ap(i),FoaeStf2Php(i),FoaeStfdpAp(i),FoaeStfdpPhp(i),FoaeStfdp1Ap(i),FoaeStfdp1Php(i), ...
    %        FoaeStf1At(i),FoaeStf1Pht(i),FoaeStf2At(i),FoaeStf2Pht(i),FoaeStfdpAt(i),FoaeStfdpPht(i),FoaeStfdp1At(i),FoaeStfdp1Pht(i), ...
    %        FRRf1Ap(i,:),FRRf1Php(i,:),FRRf2Ap(i,:),FRRf2Php(i,:),FRRf3A(i,:),FRRf3Ph(i,:),FRRfdpAp(i,:),FRRfdpPhp(i,:),FRRfdp1Ap(i,:),FRRfdp1Php(i,:),...
    %        FRRf1At(i,:),FRRf1Pht(i,:),FRRf2At(i,:),FRRf2Pht(i,:),FRRfdpAt(i,:),FRRfdpPht(i,:),FRRfdp1At(i,:),FRRfdp1Pht(i,:),...
    %        FUUf1Ap(i,:),FUUf1Php(i,:),FUUf2Ap(i,:),FUUf2Php(i,:),FUUf3A(i,:),FUUf3Ph(i,:),FUUfdpAp(i,:),FUUfdpPhp(i,:),FUUfdp1Ap(i,:),FUUfdp1Php(i,:),...
    %        FUUf1At(i,:),FUUf1Pht(i,:),FUUf2At(i,:),FUUf2Pht(i,:),FUUfdpAt(i,:),FUUfdpPht(i,:),FUUfdp1At(i,:),FUUfdp1Pht(i,:), ...
    %        FUUrf1Ap(i,:),FUUrf1Php(i,:),FUUrf2Ap(i,:),FUUrf2Php(i,:),FUUrf3A(i,:),FUUrf3Ph(i,:),FUUrfdpAp(i,:),FUUrfdpPhp(i,:),FUUrfdp1Ap(i,:),FUUrfdp1Php(i,:), ...
    %        FUUrf1At(i,:),FUUrf1Pht(i,:),FUUrf2At(i,:),FUUrf2Pht(i,:),FUUrfdpAt(i,:),FUUrfdpPht(i,:),FUUrfdp1At(i,:),FUUrfdp1Pht(i,:), ...
    %        FTMdispf1Ap(i,:),FTMdispf1Php(i,:),FTMdispf2Ap(i,:),FTMdispf2Php,FTMdispf3A(i,:),FTMdispf3Ph(i,:),FTMdispfdpAp(i,:),FTMdispfdpPhp(i,:) ,...
    %        FTMdispfdp1Ap(i,:),FTMdispfdp1Php(i,:),FTMdispf1At(i,:),FTMdispf1Pht(i,:),FTMdispf2At(i,:),FTMdispf2Pht(i,:),...
    %        FTMdispfdpAt(i,:),FTMdispfdpPht(i,:),FTMdispfdp1At(i,:),FTMdispfdp1Pht(i,:)]=ProcesData2HumanSupresD(Fc,Fs,F3o,Wn,F1o,F2o,oae,oaeSt,RR,UU,UUr,TMdisp,tim);
    %
    % i
    
end

% save data2L150L255L370_105F3100faca02facb02 x tim Foaef1Ap Foaef1Php Foaef2Ap Foaef2Php FoaefdpAp FoaefdpPhp Foaefdp1Ap Foaefdp1Php ...
%        Foaef1At Foaef1Pht Foaef2At Foaef2Pht FoaefdpAt FoaefdpPht Foaefdp1At Foaefdp1Pht ...
%        FoaeStf1Ap FoaeStf1Php FoaeStf2Ap FoaeStf2Php FoaeStfdpAp FoaeStfdpPhp FoaeStfdp1Ap FoaeStfdp1Php ...
%        FoaeStf1At FoaeStf1Pht FoaeStf2At FoaeStf2Pht FoaeStfdpAt FoaeStfdpPht FoaeStfdp1At FoaeStfdp1Pht ...
%        FRRf1Ap FRRf1Php FRRf2Ap FRRf2Php FRRf3A FRRf3Ph FRRfdpAp FRRfdpPhp FRRfdp1Ap FRRfdp1Php...
%        FRRf1At FRRf1Pht FRRf2At FRRf2Pht FRRfdpAt FRRfdpPht FRRfdp1At FRRfdp1Pht ...
%        FUUf1Ap FUUf1Php FUUf2Ap FUUf2Php FUUf3A FUUf3Ph FUUfdpAp FUUfdpPhp FUUfdp1Ap FUUfdp1Php ...
%        FUUf1At FUUf1Pht FUUf2At FUUf2Pht FUUfdpAt FUUfdpPht FUUfdp1At FUUfdp1Pht ...
%        FUUrf1Ap FUUrf1Php FUUrf2Ap FUUrf2Php FUUrf3A FUUrf3Ph FUUrfdpAp FUUrfdpPhp FUUrfdp1Ap FUUrfdp1Php ...
%        FUUrf1At FUUrf1Pht FUUrf2At FUUrf2Pht FUUrfdpAt FUUrfdpPht FUUrfdp1At FUUrfdp1Pht ...
%        FTMdispf1Ap FTMdispf1Php FTMdispf2Ap FTMdispf2Php FTMdispf3A FTMdispf3Ph FTMdispfdpAp FTMdispfdpPhp ...
%        FTMdispfdp1Ap FTMdispfdp1Php FTMdispf1At FTMdispf1Pht FTMdispf2At FTMdispf2Pht...
%        FTMdispfdpAt FTMdispfdpPht FTMdispfdp1At FTMdispfdp1Pht

% save bindata.mat UUr


% a3=20E-6*10.^(A3o/20);
%
% figure(1)
%  clf
%   plot(a3,FoaefdpAp,'r',-a3,FoaefdpAt,'b')
%
% figure(2)Fs = 20
%  clf
%   semilogy(a3,FoaefdpAp,'r',-a3,FoaefdpAt,'b')


% figure(3)
%  clf
%   plot(a3,FoaeStfdpAp,'r',-a3,FoaeStfdpAt,'b')



