`timescale 1ns/1ps

module tb_async_fifo;

  // Clock and reset
  logic wclk, rclk, wrst_n, rrst_n;
  logic w_en, r_en;
  logic [7:0] data_in, data_out;

  // Pointers
  logic [3:0] b_wptr, g_wptr, g_wptr_sync;
  logic [3:0] b_rptr, g_rptr, g_rptr_sync;
  logic full, empty;

  // Simple FIFO memory
  logic [7:0] mem [0:15];

  // Write Pointer
  WPTR wptr_u (
    .wclk(wclk), .wrst_n(wrst_n), .w_en(w_en),
    .g_rptr_sync(g_rptr_sync),
    .b_wptr(b_wptr), .g_wptr(g_wptr),
    .full(full)
  );

  // Read Pointer
  RPTR rptr_u (
    .rclk(rclk), .rrst_n(rrst_n), .r_en(r_en),
    .g_wptr_sync(g_wptr_sync),
    .b_rptr(b_rptr), .g_rptr(g_rptr),
    .empty(empty)
  );

  // Synchronizers
  DUAL_FF_SYNC sync_r2w (.clk(wclk), .rst_n(wrst_n), .d_in(g_rptr), .q_out(g_rptr_sync));
  DUAL_FF_SYNC sync_w2r (.clk(rclk), .rst_n(rrst_n), .d_in(g_wptr), .q_out(g_wptr_sync));

  // Write Logic
  always_ff @(posedge wclk) begin
    if (w_en && !full)
      mem[b_wptr[3:0]] <= data_in;
  end

  // Read Logic
  always_ff @(posedge rclk) begin
    if (r_en && !empty)
      data_out <= mem[b_rptr[3:0]];
  end

  // Clock Generation
  initial begin
    wclk = 0; forever #5 wclk = ~wclk;   // 100 MHz
  end
  initial begin
    rclk = 0; forever #7 rclk = ~rclk;   // ~71 MHz (async)
  end

  // Stimulus
  initial begin
    wrst_n = 0; rrst_n = 0; w_en = 0; r_en = 0; data_in = 0;
    #20 wrst_n = 1; rrst_n = 1;

    // Fill FIFO until full
    repeat (20) begin
      @(posedge wclk);
      if (!full) begin
        w_en <= 1; data_in <= $random;
      end else begin
        w_en <= 0;
      end
    end

    // Start reading
    repeat (30) begin
      @(posedge rclk);
      if (!empty) begin
        r_en <= 1;
      end else begin
        r_en <= 0;
      end
    end


    #200 $finish;
  end

  // Dump waves
  initial begin
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0, tb_async_fifo);
  end

endmodule
