# Cochlear Model Simulation Tools

This repository contains MATLAB and Python source code used for the paper:

**Vetešník et al. (2025). _Evaluating a cochlear transducer function and its operating point from low-frequency modulated distortion-product_. Journal of the Acoustical Society of America.**

The repository includes tools for simulating otoacoustic emissions in a cochlear model.

---

## Contents

### **CochleaRGB_Tone_AVDisertace_Tone2**
Used for generating **stationary responses for two tones**.  
This function produces cochlear responses needed for two-tone stimulation conditions.

### **Sim2ToneCDQD**
Used for simulations with a **single combination of** L1, L2, F1, and F2.  
It calls `CochleaRGB_Tone_AVDisertace_Tone2` internally and, after completing the simulation, performs a **DFT (Discrete Fourier Transform)** on the output.

---

## Purpose

The repository includes MATLAB and Python code used to simulate **three types of otoacoustic emissions** in a cochlear model:

1. Distortion-product OAE  
2. (additional types if you want to specify them)  
3. (optional text — tell me if you'd like to expand this section)

These tools support analysis of cochlear transducer functions, operating points, and modulation effects in low-frequency DP measurements.

---

## Citation

If you use this code in your research, please cite:

Vetešník et al. (2025), *Evaluating a cochlear transducer function and its operating point from low-frequency modulated distortion-product*, JASA.

