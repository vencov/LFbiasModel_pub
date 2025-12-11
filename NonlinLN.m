function [y,y1d,y2d,y3d]=NonlinLN(x)
% second order BF and its derivatives

%input parameters
A=0.1;
b = -1/0.01139;


m=0.7293;n=1.4974;k=-1/0.03736;
%auxilary parameters
p=1+m*exp(b*x)+n*exp(k*x);

bk=b*m*exp(b*x)+k*n*exp(k*x);
bk2=b*b*m*exp(b*x)+k*k*n*exp(k*x);
bk3=b*b*b*m*exp(b*x)+k*k*k*n*exp(k*x);

%second-order Boltzmann function
y=A./p-A./(1+m+n);
%third derivative of second-order Boltzmann function


%first derivative of second-order Boltzmann function
y1d=-A*bk./(p.^2);
%second derivative of second-order Boltzmann function
y2d=-(A./(p.^3)).*(p.*bk2-2*bk.*bk);
%third derivative of second-order Boltzmann function
y3d=-(A./(p.^4)).*((p.^2).*bk3-6*p.*bk.*bk2+6*bk.*bk.*bk);

