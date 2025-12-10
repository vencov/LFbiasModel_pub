%script to use for repeatedly calling the function Sim2ToneCDQDBF1
   A1o=[40,45,50,55,60,65,70,75,80];%[dB SPL] amplitude of F1 primary 
   F1o=2176; %[Hz] frequency of F1 primary
   A2o=[40,45,50,55,60,65,70,75,80]; %[dB SPL] amplitude of F2 primary
   F2o=2688; %[Hz] frequency of F2 primary 
   gain=1.45; %parameter to control gain of feedback force U
   phi1o=0; %phase of F1 primary
   phi2o=0; %phase of F2 primary
   T12ono = 0.01;%input onset
   visual = 1; %flag to control visualisation during calculation
   TMres = 0.35; %shift between BM CF and TM resonance
   faca0=0.2;%parameter of TM transfer function
   facb0=0.2;%parameter of TM transfer function
   OPo=[-0.1:0.01:-0.05,-0.047:0.003:0,0,0.003:0.003:0.05,0.05:0.01:0.2]; %OP shifts
   cycle=2*pi;%auxiliary parameter
   
   NOPo=length(OPo);
   Nlevel=length(A1o);

for j=1:Nlevel
    nc=1;
    for i=1:NOPo


            [tim,x,oaeFdp,oaeFdp2,oaeF1,oaeF2,oaeStFdp,oaeStFdp2,oaeStF1,oaeStF2,...
             RRFdp,RRFdp2,RRF1,RRF2,UUFdp,UUFdp2,UUF1,...
             UUF2,UUrFdp,UUrFdp2,UUrF1,UUrF2,TMdispFdp,TMdispFdp2,...
             TMdispF1,TMdispF2,UUr1Fdp,UUr1Fdp2,UUr1F1,UUr1F2] = Sim2ToneCDQDBF1(A1o(j),F1o,A2o(j),F2o,gain,phi1o,...
                phi2o,T12ono,visual,TMres,faca0,facb0,OPo(i));
            RRF1a(nc,:)=abs(RRF1);RRF1ph(nc,:)=unwrap(angle(RRF1))/cycle;
            RRF2a(nc,:)=abs(RRF2);RRF2ph(nc,:)=unwrap(angle(RRF2))/cycle;
            RRFdpa(nc,:)=abs(RRFdp);RRFdpph(nc,:)=unwrap(angle(RRFdp))/cycle;
            RRFdp2a(nc,:)=abs(RRFdp2);RRFdp2ph(nc,:)=unwrap(angle(RRFdp2))/cycle;
            TMdispF1a(nc,:)=abs(TMdispF1);TMdispF1ph(nc,:)=unwrap(angle(TMdispF1))/cycle;
            TMdispF2a(nc,:)=abs(TMdispF2);TMdispF2ph(nc,:)=unwrap(angle(TMdispF2))/cycle;
            TMdispFdpa(nc,:)=abs(TMdispFdp);TMdispFdpph(nc,:)=unwrap(angle(TMdispFdp))/cycle;
            TMdispFdp2a(nc,:)=abs(TMdispFdp2);TMdispFdp2ph(nc,:)=unwrap(angle(TMdispFdp2))/cycle;
            UUrFdpa(nc,:)=abs(UUrFdp);UUrFdpph(nc,:)=unwrap(angle(UUrFdp))/cycle;
            UUrFdp2a(nc,:)=abs(UUrFdp2);UUrFdp2ph(nc,:)=unwrap(angle(UUrFdp2))/cycle;
            UUr1Fdpa(nc,:)=abs(UUr1Fdp);UUr1Fdpph(nc,:)=unwrap(angle(UUr1Fdp))/cycle;
            UUr1Fdp2a(nc,:)=abs(UUr1Fdp2);UUr1Fdp2ph(nc,:)=unwrap(angle(UUr1Fdp2))/cycle;
            oaeFdpa(nc)=abs(oaeFdp); oaeFdp2a(nc)=abs(oaeFdp2);
            oaeStFdpa(nc)=abs(oaeStFdp);oaeStFdp2a(nc)=abs(oaeStFdp2);
            nc=nc+1;
    end
     savefilename=['DPOAEOPL1',num2str(A1o(j)),'L2',num2str(A2o(j)),'V4.mat'];
     A1c=A1o(j);A2c=A2o(j);
    save(savefilename,'A1c','A2c','F1o','F2o','TMres','faca0','facb0','oaeFdpa','oaeFdp2a',...
        'oaeStFdpa','oaeStFdp2a','RRF1a','RRF1ph','RRF2a','RRF2ph','RRFdpa','RRFdpph',...
        'RRFdp2a','RRFdp2ph','TMdispF1a','TMdispF1ph',...
         'TMdispF2a','TMdispF2ph','TMdispFdpa','TMdispFdpph','TMdispFdp2a','TMdispFdp2ph',...
         'UUrFdpa','UUrFdpph','UUrFdp2a','UUrFdp2ph','UUr1Fdpa','UUr1Fdpph','UUr1Fdp2a','UUr1Fdp2ph')
end
 
 % figure(1)
 % clf
 % surface(A1o,A2o,oaeFdpa)
 % 
 % figure(2)
 % clf
 % surface(A1,A2,oaeStFdpa)
 % 
 %  figure(11)
 % clf
 % surface(A1,A2,oaeFdp2a)
 % 
 % figure(12)
 % clf
 % surface(A1,A2,oaeStFdp2a)