`timescale 1ns/1ps

// Asynchronous FIFO Top Module
module ASYNC_FIFO(
  input  logic wclk, rclk,
  input  logic wrst_n, rrst_n,
  input  logic wen, ren,
  input  logic [7:0] data_in,
  output logic [7:0] data_out,
  output logic full, empty
);
  // Memory declaration: 8-deep, 8-bit wide
  logic [7:0] mem [0:7];

  // Pointers for write and read domains
  logic [3:0] b_wptr, g_wptr;
  logic [3:0] b_rptr, g_rptr;

  // Synchronized pointers for crossing clock domains
  logic [3:0] g_rptr_sync; // Gray read pointer synchronized to write clock
  logic [3:0] g_wptr_sync; // Gray write pointer synchronized to read clock

  // Write pointer logic
  WPTR wptr_inst (
    .wclk(wclk),
    .wrst_n(wrst_n),
    .w_en(wen),
    .g_rptr_sync(g_rptr_sync),
    .b_wptr(b_wptr),
    .g_wptr(g_wptr),
    .full(full)
  );

  // Read pointer logic
  RPTR rptr_inst (
    .rclk(rclk),
    .rrst_n(rrst_n),
    .r_en(ren),
    .g_wptr_sync(g_wptr_sync),
    .b_rptr(b_rptr),
    .g_rptr(g_rptr),
    .empty(empty)
  );

  // Synchronizers to pass Gray pointers between clock domains
  // Ensures pointers are stable before being used in the other clock domain
  DUAL_FF_SYNC sync_w2r (
    .clk(rclk),
    .rst_n(rrst_n),
    .d_in(g_wptr),
    .q_out(g_wptr_sync)
  );
  DUAL_FF_SYNC sync_r2w (
    .clk(wclk),
    .rst_n(wrst_n),
    .d_in(g_rptr),
    .q_out(g_rptr_sync)
  );

  // Memory write operation
  always_ff @(posedge wclk) begin
    if (wen && !full)
      mem[b_wptr[2:0]] <= data_in;
  end

  // Memory read operation
  always_ff @(posedge rclk) begin
    if (ren && !empty)
      data_out <= mem[b_rptr[2:0]];
  end

endmodule
