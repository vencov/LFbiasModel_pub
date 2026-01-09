function [Sig]=Inp_sig2PrimariesME(F1,A1,F2,A2,t,phi1,phi2,T12on)
% generate input signal composed of 2 tones 
% 
%

om1=2*pi*F1;
AM1=db2inputME(A1);
om2=2*pi*F2;
AM2=db2inputME(A2);
  
durHW = T12on; % duration of  onset ramp

  
    
  % two tones
      if t<T12on  
          Sig=m_hann(t,durHW)*(AM1*cos(om1*t+phi1)+AM2*cos(om2*t+phi2));
      else          
          Sig=AM1*cos(om1*t+phi1)+AM2*cos(om2*t+phi2);
      end
     %

 
 
  function w=m_hann(t,dur)
      framp = 1/(2*dur);
      if t<=dur
        w = 0.5 * (1 - cos(2*pi*t*framp));  
      else
          w = 1;
      end