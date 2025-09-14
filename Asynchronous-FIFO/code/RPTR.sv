`timescale 1ns/1ps

module RPTR(
  input  logic rclk, rrst_n, r_en,
  input  logic [3:0] g_wptr_sync,
  output logic [3:0] b_rptr, g_rptr,
  output logic empty
);
  logic [3:0] b_rptr_next;

  // Next binary pointer calculation
  assign b_rptr_next = b_rptr + (r_en && !empty);

  // Binary-to-Gray conversion
  assign g_rptr = (b_rptr >> 1) ^ b_rptr;

  // Pointer updates and reset
  always_ff @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) begin
      b_rptr <= 0;
    end else begin
      b_rptr <= b_rptr_next;
    end
  end

  // Empty condition logic 
  assign empty = (g_rptr == g_wptr_sync);
endmodule
