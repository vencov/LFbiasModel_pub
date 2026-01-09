function [Sig]=Inp_sig3PrimariesME(F1,A1,F2,A2,F3,A3,t,phi1,phi2,phi3,T12on,T3on)
% generate input signal composed of 3 tones, two primaries (F1,F2) and one
% low frequency bias tone (F3)
%
%

om1=2*pi*F1;
AM1=db2inputME(A1);
om2=2*pi*F2;
AM2=db2inputME(A2);
om3=2*pi*F3;
AM3=db2inputME(A3);




if t<T3on
    Sig=m_hann(t,T12on)*(AM1*cos(om1*t+phi1)+AM2*cos(om2*t+phi2))+m_hann(t,T3on)*AM3*cos(om3*t+phi3);
else
    Sig=AM1*cos(om1*t+phi1)+AM2*cos(om2*t+phi2)+AM3*cos(om3*t+phi3);
end
%



function w=m_hann(t,dur)
framp = 1/(2*dur);
if t<=dur
    w = 0.5 * (1 - cos(2*pi*t*framp));
else
    w = 1;
end