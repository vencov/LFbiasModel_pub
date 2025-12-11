# Cochlear Model Simulation Tools

This repository contains MATLAB and Python source code used for the paper:

**Vetešník et al. (2025). _Evaluating a cochlear transducer function and its operating point from low-frequency modulated distortion-product_. Journal of the Acoustical Society of America.**

The repository includes tools for simulating otoacoustic emissions in a cochlear model.

---

## Contents

### **CochleaRGB_Tone_AVDisertace_Tone2**
Used for generating **stationary responses for two tones and static OP shift**.  
This function produces cochlear responses needed for two-tone stimulation conditions.

### **CochleaRGB_Tone_AVDisertace_Tone3**
Used for generating **stationary responses for two tones and LF bias tone**  
This function produces cochlear responses needed for two-tone stimulation conditions.


### **Sim2ToneCDQD**
Used for simulations with a **single combination of** L1, L2, F1, and F2.  
It calls `CochleaRGB_Tone_AVDisertace_Tone2` internally and, after completing the simulation, performs a **DFT (Discrete Fourier Transform)** on the output.

## **LF Bias Tone Simulation Scripts**

These scripts are used for simulating **low-frequency (LF) bias tone effects**.  
The term **1st** refers to *first-order BF*, and **2nd** refers to *second-order BF* conditions.

---

### **LF Bias Simulation – 2nd Order BF (Phase Analysis)**
**File:** `Notas2Supression_2nd_PhaseAns_OPs.m`  
This script performs LF bias tone simulations for **second-order BF** and generates the corresponding *phase analysis* outputs.

### **LF Bias Simulation – 1st Order BF (Phase Analysis)**
**File:** `Notas2Supression_1st_PhaseAns_OPs.m`  
This script performs LF bias tone simulations for **first-order BF** and generates the corresponding *phase analysis* outputs.

### **LF Bias Simulation – 2nd Order BF (L1/L2 Analysis)**
**File:** `Notas2Supression_2nd_L1L2.m`  
This script performs LF bias tone simulations for **second-order BF** and produces the *L1/L2 parametric analysis* outputs.

---



## **Overview of Figure-Generating Scripts (Fig. 1–12)**

Below is the ordered list of all scripts used to generate the figures in the paper.  
Each script explicitly states **which Figure XX** in the paper it produces.

---

### **Fig1**
**File:** `visFig1.m`  
This script creates **Figure 01** in the paper.

### **Fig2**
**File:** `visFig2JASA_2ndOrderBFDP.m`  
This script creates **Figure 02** in the paper.

### **Fig3**
**File:** `visFig3JASA_1stOrderBFDP.m`  
This script creates **Figure 03** in the paper.

### **Fig4**
**File:** `visFig4JASA_TWs2ndOrderBF_rev.m`  
This script creates **Figure 04** in the paper.

### **Fig5**
**File:** `visFig5.m`  
This script creates **Figure 05** in the paper.

### **Fig6**
**File:** `visFig6.m`  
This script creates **Figure 06** in the paper.

### **Fig7**
**File:** `visFig7_VelkeLevely.m`  
This script creates **Figure 07** in the paper.

### **Fig8**
**File:** `visFig8_VelkeLevelySym.m`  
This script creates **Figure 08** in the paper.

### **Fig9**
**File:** `visFig9_LFbiasSpectra_2ndBF.m`  
This script creates **Figure 09** in the paper.

### **Fig10**
**File:** `visFig10_LFbiasSpectra_1stBF_OPm100.m`  
This script creates **Figure 10** in the paper.

### **Fig11**
**File:** `visFig11_NumSideBandsEffect2ndBF.m`  
This script creates **Figure 11** in the paper.

### **Fig12**
**File:** `visFig12Lbias_CompareStatic.m`  
This script creates **Figure 12** in the paper.

---

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

