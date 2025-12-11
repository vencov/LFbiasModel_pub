function input = db2inputME(dB);

%	rescales dB SPL into corresponding input values for human cochlea  


%AMo = 500;
AMo =424;

input = sqrt(2)*AMo*10.^(dB/20);
