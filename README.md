# Clock Domain Crossing (CDC) – (SystemVerilog)

This repository collects and documents **Clock Domain Crossing (CDC) techniques** implemented in SystemVerilog.  
CDC ensures reliable communication between circuits running on different clocks by addressing **metastability** and **data integrity** issues.

---

##  Present Work
1. [Asynchronous FIFO](https://github.com/JaiViswaiswaren/Clock-Domain-Crossings-/tree/main/Asynchronous-FIFO)  
   - Dual-clock FIFO using **Gray-coded pointers**  
   - Full and empty detection  
   - Dual-flop synchronizers  

2. [Dual Flip-Flop Synchronizer](https://github.com/JaiViswaiswaren/Clock-Domain-Crossings-/tree/main/Dual-Flop-Synchroniser)  
   - Standard **two-stage synchronizer** for single-bit signals  
   - Reduces probability of metastability  

---

##  Future Plans
1. **Synchronous FIFO**  
   - Single-clock FIFO implementation  
   - Simpler design without Gray coding  

2. **Handshake Synchronizer**  
   - Request/Acknowledge protocol  
   - Reliable transfer of multi-bit data  

3. **Pulse Synchronizer**  
   - Synchronization of **short pulses**  
   - Ensures safe edge detection across domains  

---

##  CDC Overview
- **Dual FF Sync** → Single-bit signals  
- **Handshake Sync** → Multi-bit data (control + data bus)  
- **Pulse Sync** → Short event signals  
- **Async FIFO** → Bulk data transfer  



---

##  Usage
- Each technique has its **own repository** with code + testbench  
- This repo acts as the **master index** for all CDC implementations  

---

**Author:** Jai Viswaiswaren S  
**Project:** CDC – (SystemVerilog)  
