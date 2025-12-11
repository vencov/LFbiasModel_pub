function [x,N,M,stiff,damp0,ShSp,G,Gs,Ginv,Qbm,Qs,MEinv,mME,kME,hME,Gme,Sty,gammaAir, ...
      Ve,GammaMi,Sow,W,Pea] = bmdatargMEP(N); 


 if nargin <1, N=800; end  

  H = 0.1;  %height (cm) 
   L = 3.5;  %length (cm)
   W = 1; %0.029; % width of the BM (cm)
   Sow = H*W;% (cm^2)
   rho = 1;  %water density (g/cm^3)

   [G,Gs,x,Sh]= cgsgreenf(N, L, H);%Green's function
   Sh=2e-4*Sh;
%    Sh = Sh;
  %Gs=Sow*Gs(:);
  %G=G*W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------- MASS -------------------------------------------------
  m0 = 0.005;
 % m0 = 1e-4; % g/cm
  M = diag(m0*ones(size(x)));
%---------------------TONOPIC MAP FOR MAN --------------------------
  cf =GetHumanCF(x,L,1,0);
%-------------------- STIFFNESS --------------------------------------
  stiff=(H/3+m0)*((2*pi*cf).^2);
  %stiff=(m0)*((2*pi*cf).^2);
%-------------------  DAMPING ----------------------------------------
  h0= 6000; 
  fact=10;%????
  damp0=sqrt(stiff);damp0=h0*(damp0./damp0(1));
  damp=damp0+fact*damp0(N)*exp(x-L);
  Ce=80*damp(N);	% increased damping near appex (VV)			
  damp = damp + Ce*exp((x/L-1)/0.055);  % VV

  ShSp=sparse(diag(damp)) + sparse(Sh);
 
 % ME PARAMETERS
 mME = 0.0531; % Mass of the oval window [g]
 hME = 1298; %20*500*mME; % damping of the ME [g/s]
 kME = 6.8130e+06; % stiffness of the ME [g/s^2]

 Sty = 0.49; % cm^2 effective area of tympanic membrane
 gammaAir = 1.4; % ratio of specific heats of air
 Ve = 0.5; % cm^3 volume of outer ear cavity
 GammaMi = 1.4; % level ratio of incus
 Gme = Sty/Sow*GammaMi;
 Pea = 1e6; % adiabatic pressue in the ear canal [dyn/m^2] (assumed equal to athmospheric pressure)
   
 %-------------TIME DOMAIN--------------------
 Qbm=G(1,:);
 Qs=Gs(1); 
 G1G = Gs*Qbm;
 MEinv = 1/(mME + Sow*Qs/W);
 
 Ginv = inv(G+M-G1G*Sow/W*MEinv); 
 
 %save bmdatargME.mat x N M stiff damp0 ShSp G Gs Ginv Qbm Qs MEinv mME kME hME Gme Sty gammaAir ...
 %     Vtc GammaMi Sow W Pec