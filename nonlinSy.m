function [y]=nonlinSy(x)
%pocita symetrickou sigmoidu spolu s jejimi derivacemi

%Input parameters
 y1 = 0.025;
%Sigmoida:
  y = 1./(1 + exp(-x/y1))-1./2;
  y=0.1*y;
