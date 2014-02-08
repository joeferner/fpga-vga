`timescale 1ns / 1ps

module VGA_tb;
  reg clk;
  wire vga_h_sync;
  wire vga_v_sync;
  wire r;
  wire g;
  wire b;

  VGA vga(clk, vga_h_sync, vga_v_sync, r, g, b);

  initial begin
    #100 $finish;
  end
  
  always begin
    clk = 1'b0;
    forever
      #1 clk = ~clk; 
  end
endmodule
