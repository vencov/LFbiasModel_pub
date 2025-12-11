function [y,y1d,y2d,y3d]=NonlinSNorm(x)
%pocita symetrickou sigmoidu spolu s jejimi derivacemi
%first order BF and its derivatives

%Input parameters
A=0.1;
y1 = 0.025;
%Sigmoida:
y = A./(1 + exp(-x/y1))-A./2;
%First derivative of sigmoid:
y1d=A*exp(-(x/y1))./(y1*(1 + exp(-(x/y1))).^2);
%Second derivative of sigmoid:
y2d=A*(2*exp(-((2*x)/y1))./((y1^2)*(1 + exp(-(x/y1))).^3 )-...
    exp(-x/y1)./((y1^2)*(1 + exp(-x/y1)).^2));
%Third derivative of sigmoid:
y3d=A*((6*exp(-((3*x)/y1)))./( (y1^3)*(1 + exp(-(x/y1))).^4)-...
    (6*exp(-((2*x)/y1)))./((y1^3)*(1 + exp(-(x/y1))).^3)+...
    exp(-(x/y1))./((y1^3)*(1 + exp(-(x/y1))).^2));
