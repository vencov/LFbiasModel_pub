function [x,Ginv,stiff,ShSp,undamp,bigamma,wm2,Qbm,Qs, MEinv, kME, hME, Gme, Sty, gammaAir, ...
      Vtc, GammaMi, Gs, Sow, W, Pec] = alldataRGmePaTM(N,gain,TMres)

if nargin< 3, TMres = 0.25; end
if nargin <2, gain = 1; end
if nargin <1,N=800; end

%________________________BM data_______________________________
	
[x,N,M,stiff,damp0,ShSp,G,Gs,Ginv,Qbm,Qs,MEinv,mME,kME,hME,Gme,Sty,gammaAir, ...
    Vtc,GammaMi,Sow,W,Pec] = bmdatargMEP(N); 

[bigamma,wm2] = tmdatargPTM(x,TMres);

%UmpBas = 1.04+ScAmp*(tanh((Sc*(Xzero-x)/max(x)))); % g2
%UmpBas = 1.02+ScAmp*(tanh((Sc*(Xzero-x)/max(x)))); % g3
%UmpBas = 1.02+ScAmp*(tanh((Sc*(Xzero-x)/max(x)))); % g4
%UmpBas  = 0.5-0.6*(tanh((1*(x-4)/max(x))));
%________________________________________________
%  undamp=1.34*damp0(:).*bigamma; % def
shapeOn = hann(100);
shapeAll = [shapeOn(1:50); ones(N-100,1); shapeOn(51:end)];
% undamp=1.34*gain*damp0(:).*bigamma.*shapeAll;
undamp=gain*damp0(:).*bigamma.*shapeAll;
stiff=stiff(:);