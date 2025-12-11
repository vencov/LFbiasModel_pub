function [bigamma, wm2] = tmdatargPTM(x,x0)

  %x0=0.25;
  L=3.5;
  [CF]=GetHumanCF(x,L,0,x0);
  fact1=43;
 %-------------------------------------------
  wm=2*pi*CF;
  wm2=wm.*wm;  % equivalent to K/M along the TM 
 
  bigamma=2*pi*fact1*sqrt(CF(:));
  wm2=wm2(:);% equivalent to H/M along the TM 
  
  %save tmdatarg.mat bigamma wm2
