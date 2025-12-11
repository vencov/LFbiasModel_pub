#%% code which compares effect of number of sidebands during biasing on the envelope
# comparison is done at two different bias levels and two different primary levels
# we chose 2 and 3 and 4 sidebands on each side

import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat
from scipy.signal import butter, filtfilt
from scipy.signal.windows import hamming  # Add this import at the top if not already

plt.close('all')

    

def process_sim_dlouhe(SimA, Fdp1, Fdp2, Nframe,fx):
    """
    Process simulated results for suppression analysis using third tone.
    
    Parameters:
    - tim: time vector
    - SimA: 2D array or vector with simulations (each row is one signal)
    - Fdp1: start frequency bin of modulation
    - Fdp2: end frequency bin of modulation
    - F3: frequency bin of the suppressor

    Returns:
    - SigBack: time-domain signal reconstructed from modulated frequencies
    - SigBackF3: time-domain signal reconstructed from suppressor frequency
    """
    
    #INDf3 = F3 + 1  # MATLAB to Python index adjustment
    #INDf3 = np.where(fx==32)[0]
    SimA = np.atleast_2d(SimA)
    if SimA.shape[0] > SimA.shape[1]:
        SimA = SimA.T  # transpose if needed

    m, n = SimA.shape
    
    SigBack = np.zeros((m, n), dtype=np.complex128)
    #SigBackF3 = np.zeros((m, n), dtype=np.complex128)
    IdxFdp1 = np.where(fx==Fdp1)[0][0]
    IdxFdp2 = np.where(fx==Fdp2)[0][0]
    
    for i in range(m):
        u = SimA[i, :]
        Sig = u  
        SigF = np.fft.rfft(Sig)

        # Zero vectors for selective reconstruction
        SigFVyb = np.zeros_like(SigF, dtype=complex)
        #SigFVybF3 = np.zeros_like(SigF, dtype=complex)

        # Copy modulation frequency band (positive + negative freq)
        SigFVyb[IdxFdp1:IdxFdp2+1] = SigF[IdxFdp1:IdxFdp2+1]
        #SigFVyb[-IdxFdp2+1:-IdxFdp1] = SigF[-IdxFdp2+1:-IdxFdp1]

        # Copy suppressor frequency (positive + negative freq)
        #SigFVybF3[INDf3] = SigF[INDf3]
        #SigFVybF3[-INDf3+1] = SigF[-INDf3+1]

        # IFFT to time domain
        SigBack[i, :] = np.fft.irfft(SigFVyb)
        #SigBackF3[i, :] = np.fft.irfft(SigFVybF3)

    return SigBack


f1 = 2176 # Hz
f2 = 2688  # Hz
fs = 204800  # sampling freq
fbias = 32  # frequency of bias tone
Lbias = 120
fdp = 2*f1 - f2



def loadBiasData(FileName):
    #data = loadmat('PhAnDPOAE_32_65_55_110.mat')
    data = loadmat(FileName)


    #oae = data['RR'][0]
    #oae1 = data['oae1'].flatten()
    #oae2 = data['oae2'].flatten()
    #oae3 = data['oae3'].flatten()
    #oae4 = data['oae4'].flatten()

    Pr1 = data['oae1'].flatten()
    #Pr1 = data['RR1'][0,:].flatten()
    
    BM1 = data['RR1'][0,:]  # BM displ. at base
    #oae2 = data['RR2'][0,:]
    #oae3 = data['RR3'][0,:]
    #oae4 = data['RR4'][0,:]

    oae1 = data['oae1'].flatten()
    oae2 = data['oae2'].flatten()
    oae3 = data['oae3'].flatten()
    oae4 = data['oae4'].flatten()

    oae = (oae1+oae2+oae3+oae4)/4
    tmdata1 = data['TMdisp1'][0,:]
    tmdata2 = data['TMdisp2'][0,:]
    tmdata3 = data['TMdisp3'][0,:]
    tmdata4 = data['TMdisp4'][0,:]

    tmdata = (tmdata1 + tmdata2 + tmdata3 + tmdata4)/4

    return Pr1,BM1,oae,tmdata


Pr1_105,BMd_105,oae_105,tmdata_105  = loadBiasData('PhNewAnDPOAE_OP0_65_60_' + str(105) +  '.mat')
Pr1_115,BMd_115,oae_115,tmdata_115  = loadBiasData('PhNewAnDPOAE_OP0_65_60_' + str(115) +  '.mat')

def apply_raised_cosine(signal, ramp_length):
    """Applies a raised cosine (half Hann) ramp of `ramp_length` samples to both ends of a 1D signal."""
    N = len(signal)
    if 2 * ramp_length > N:
        raise ValueError("Ramp length too long for signal")

    # Create the raised cosine ramp
    ramp = 0.5 * (1 - np.cos(np.linspace(0, np.pi, ramp_length)))

    # Create full window
    window = np.ones(N)
    window[:ramp_length] = ramp        # fade in
    window[-ramp_length:] = ramp[::-1] # fade out

    # Apply the window
    return signal * window

def biased_envelope(Pr1,BMd,oae,tmdata,Nside):

    # ramp_signals
    ramp_len = 6400
    oae_r = apply_raised_cosine(oae, ramp_len)
    oae1_r = apply_raised_cosine(Pr1, ramp_len)
    BMd_r = apply_raised_cosine(BMd, ramp_len)
    tmdata_r = apply_raised_cosine(tmdata,ramp_len)



    order = 3
    Fc = 800
    # Butterworth filter design
    b, a = butter(order, Fc / (fs / 2), btype='high')
    bLP, aLP = butter(order, Fc / (fs / 2), btype='low')

    # filter Phase Ensembled signal
    oaeHP = filtfilt(b, a, oae_r) # filter and skip onset of the signal because of onset transient
    uuBF = filtfilt(bLP, aLP, oae_r) # lowpass filter for suppressor
      
    # filtering for single response
    oaeHP_s = filtfilt(b, a, oae1_r) # filter and skip onset of the signal because of onset transient
    uuB_sF = filtfilt(bLP, aLP, oae1_r) # lowpass filter for suppressor

    BMd_rF = filtfilt(bLP, aLP, BMd_r)  # low pass filter BM displacement at base

    # filter TM data signal for bias of TM part
    TMdataF = filtfilt(bLP, aLP, tmdata_r) # lowpass filter for suppressor (TMdata)
    
    Nframe = 6400


    segment = oaeHP[-4*Nframe:-1*Nframe]  # selected HP filtered ph ans. oae signal
    segment_s = oaeHP_s[-4*Nframe:-1*Nframe]  # selected HP filtered ph ans. oae signal

    TMdataFSel = TMdataF[4*Nframe:-1*Nframe]
    uuB_sSel = uuB_sF[4*Nframe:-1*Nframe]
    BMd_rSel = BMd_rF[4*Nframe:-1*Nframe]
    
    N = len(segment_s)
    fx = np.fft.fftfreq(N, d=1/fs)  # fs is your sampling rate

    #Nside = 4 # number of side bands around fcdt

    sig_oae = process_sim_dlouhe(segment, fdp-Nside*fbias, fdp+Nside*fbias, Nframe,fx)
    sig_oae_s = process_sim_dlouhe(segment_s, fdp-Nside*fbias, fdp+Nside*fbias, Nframe,fx)

    sig_oaeS = np.real(sig_oae.flatten())
    from scipy.signal import hilbert
    #fig,ax = plt.subplots()
    #ax.plot(sig_oae.flatten())
    # Assume `signal` is your 1D NumPy array (time-domain signal)   
    sig_oae = hilbert(np.real(sig_oae)).flatten()

    sig_oae = np.abs(sig_oae)
    fig,(ax1,ax2) = plt.subplots(2,1)
    ax1.plot(sig_oae)
    ax2.plot(sig_oaeS)

    sig_oae_s = hilbert(np.real(sig_oae_s)).flatten()
    sig_oae_s = np.abs(sig_oae_s)

    # Find peaks
    from scipy.signal import find_peaks
    # Find peaks
    peaks, _ = find_peaks(TMdataFSel) # find first peak 

    # Index of maximal value in TM disp
    IdxP = peaks[0]
     
    sig_oae = sig_oae[IdxP:IdxP+Nframe+Nframe//2]
    sig_oae_s = sig_oae_s[IdxP:IdxP+Nframe+Nframe//2]
    TMdataFSel = TMdataFSel[IdxP:IdxP+Nframe+Nframe//2]
    uuB_sSel = uuB_sSel[IdxP:IdxP+Nframe+Nframe//2]
    BMd_rSel = BMd_rSel[IdxP:IdxP+Nframe+Nframe//2]

    return sig_oae, sig_oae_s, TMdataFSel, uuB_sSel, BMd_rSel


sig_oae_105_2, sig_oae_105_s_2, TMdataFrame105_2, Pr105_2, BMd_105_2 = biased_envelope(Pr1_105, BMd_105,oae_105,tmdata_105,2)
sig_oae_115_2, sig_oae_115_s_2, TMdataFrame115_2, Pr115_2, BMd_115_2 = biased_envelope(Pr1_115, BMd_115,oae_115,tmdata_115,2)

sig_oae_105_4, sig_oae_105_s_4, TMdataFrame105_4, Pr105_4, BMd_105_4 = biased_envelope(Pr1_105, BMd_105,oae_105,tmdata_105,4)
sig_oae_115_4, sig_oae_115_s_4, TMdataFrame115_4, Pr115_4, BMd_115_4 = biased_envelope(Pr1_115, BMd_115,oae_115, tmdata_115,4)

sig_oae_105_6, sig_oae_105_s_6, TMdataFrame105_6, Pr105_6, BMd_105_6 = biased_envelope(Pr1_105, BMd_105,oae_105,tmdata_105,6)
sig_oae_115_6, sig_oae_115_s_6, TMdataFrame115_6, Pr115_6, BMd_115_6 = biased_envelope(Pr1_115, BMd_115,oae_115,tmdata_115,6)




plt.show()
#%% plot

fig,(ax1,ax2) = plt.subplots(2,1)
ax1.plot(20*np.log10(sig_oae_105_2))
ax1.plot(20*np.log10(sig_oae_105_4))
ax1.plot(20*np.log10(sig_oae_105_6))
ax2.plot(TMdataFrame105_2/np.max(TMdataFrame105_2))
ax2.plot(Pr105_2/np.max(Pr105_2))
ax2.plot(BMd_105_2/np.max(BMd_105_2),':')


fig,(ax1,ax2) = plt.subplots(2,1)
ax1.plot(20*np.log10(sig_oae_115_2))
ax1.plot(20*np.log10(sig_oae_115_4))
ax1.plot(20*np.log10(sig_oae_115_6))
ax2.plot(TMdataFrame115_2/np.max(TMdataFrame115_2))
ax2.plot(Pr115_2/np.max(Pr115_2))
ax2.plot(BMd_115_2/np.max(BMd_115_2),':')

plt.show()

#%%

import scipy.io as sio

# Prepare your data dictionary
data = {
    'sig_oae_105_2': sig_oae_105_2,
    'sig_oae_105_4': sig_oae_105_4,
    'sig_oae_105_6': sig_oae_105_6,
    'TMdataFrame105_2': TMdataFrame105_2,
    'Pr105_2': Pr105_2,
    'BMd_105_2': BMd_105_2,
    'sig_oae_115_2': sig_oae_115_2,
    'sig_oae_115_4': sig_oae_115_4,
    'sig_oae_115_6': sig_oae_115_6,
    'TMdataFrame115_2': TMdataFrame115_2,
    'Pr115_2': Pr115_2,
    'BMd_115_2': BMd_115_2
}

# Save to MAT-file
sio.savemat('ForMatlabFigures/AdataLbias_effect_NumSidebands_65_60.mat', data)