# Asynchronous FIFO (SystemVerilog)

This project implements an **Asynchronous FIFO** in SystemVerilog using **Gray-coded pointers** and **dual-flop synchronizers** to safely transfer data between two clock domains.

##  Features
- Separate **write** and **read** clock domains (`wclk`, `rclk`)
- **Gray code** pointer implementation for metastability protection
- **Dual flip-flop synchronizers** for pointer transfer
- Correct **full** and **empty** detection
- Simple **testbench** included with VCD waveform output
<img width="500" height="282" alt="image" src="https://github.com/user-attachments/assets/28eb5eab-b93f-4b1c-82c5-e172211cefc0" />

## 📂 Modules
### 1. `WPTR.sv`
- Write pointer logic  
- Maintains binary and Gray-coded write pointers  
- Generates **full flag** based on next write pointer  

### 2. `RPTR.sv`
- Read pointer logic  
- Maintains binary and Gray-coded read pointers  
- Generates **empty flag**  

### 3. `DUAL_FF_SYNC.sv`
- Two flip-flop synchronizer  
- Used to safely transfer Gray-coded pointers across clock domains  

### 4. `tb_async_fifo.sv`
- Testbench for simulation  
- Stimulates write until FIFO is **full**  
- Then reads until FIFO is **empty**  
- Dumps waveforms (`fifo_tb.vcd`)  

## Waveform Example
<img width="895" height="258" alt="Screenshot 2025-09-14 at 7 06 04 PM" src="https://github.com/user-attachments/assets/4255b978-9c88-41f4-b87c-50fc5b3052ff" />
Write until `full` is asserted, then read until `empty`:

## Note
- There is a small error in the code, the last value written cant be read properly. This error will be corrected ASAP.
