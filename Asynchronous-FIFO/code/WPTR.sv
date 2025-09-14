`timescale 1ns/1ps
module WPTR(
  input  logic wclk, wrst_n, w_en,
  input  logic [3:0] g_rptr_sync,
  output logic [3:0] b_wptr, g_wptr,
  output logic full
);
  logic [3:0] b_wptr_next;

  // Next binary pointer calculation
  assign b_wptr_next = b_wptr + (w_en && !full);

  // Binary-to-Gray conversion
  // This is a combinatorial assignment, not a register.
  assign g_wptr = (b_wptr >> 1) ^ b_wptr;

  // Pointer updates and reset
  always_ff @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) begin
      b_wptr <= 0;
    end else begin
      b_wptr <= b_wptr_next;
    end
  end

  // Full condition logic (Corrected)
  // Full occurs when the MSB of the write pointer is different from the synchronized
  // read pointer's MSB, and the rest of the bits are the same. This distinguishes
  // the full state from the empty state.
  assign full = (g_wptr[3:2] != g_rptr_sync[3:2]) && (g_wptr[1:0] == g_rptr_sync[1:0]);

endmodule