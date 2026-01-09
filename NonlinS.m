function [y,y1d,y2d,y3d]=NonlinS(x)
%calculates the symmetric sigmoid (first order BF) along with its derivatives

%Input parameters
 A=0.1;
 y1 = 0.025;
%Sigmoid:
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
