`timescale 1ns/1ps
module DUAL_FF_SYNC(
  input  logic clk, rst_n,
  input  logic [3:0] d_in,
  output logic [3:0] q_out
);
  logic [3:0] q1;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q1 <= 0;
      q_out <= 0;
    end else begin
      q1 <= d_in;
      q_out <= q1;
    end
  end
endmodule
