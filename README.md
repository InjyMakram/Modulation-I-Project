This project simulates a block diagram of a digital communications system using MATLAB. The key steps include modulating a speech signal, applying various analog modulation techniques, passing the signal through an AWGN (Additive White Gaussian Noise) channel, and then demodulating the signal to retrieve the original message.

Project Breakdown:

1) Modulating Speech Signal: A downloaded speech signal is used as the modulating signal.
  
2) Analog Modulation: The modulating signal is modulated using three analog modulation techniques:
   -Conventional AM (Amplitude Modulation)
   -DSB (Double Sideband)
   -SSB (Single Sideband)
   
3) AWGN Channel: White Gaussian noise with zero mean is generated and added to the modulated signal. Different noise powers are used to adjust the Signal-to-Noise Ratio (SNR).
   
4) Demodulation: Suitable demodulation techniques are applied at the receiver to extract the message signal based on the modulation type used.

   
Key Features:

-Modulation Techniques: AM, DSB, SSB
-Noise Simulation: AWGN channel with adjustable SNR
-Signal Processing: Extracting the original message from noisy modulated signals
