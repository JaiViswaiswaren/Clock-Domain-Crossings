# Dual Flip-Flop Synchronizer (SystemVerilog)

This project implements a **Dual Flip-Flop Synchronizer** in SystemVerilog to safely transfer signals across clock domains.

## 📌 Features
- Two-stage flip-flop synchronizer  
- Reduces **metastability** probability in CDC  
- Works for single-bit control/status signals  
<img width="736" height="148" alt="image" src="https://github.com/user-attachments/assets/78b8e021-227e-4a46-8693-071c613c179b" />

## 📂 Module
### `DUAL_FF_SYNC.sv`
- Generic synchronizer  
- Takes asynchronous input (`d_in`)  
- Produces synchronized output (`q_out`)  


