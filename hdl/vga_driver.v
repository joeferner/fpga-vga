`timescale 1ns / 1ps

module VGA_driver(CLK_3_33_MHZ, vga_h_sync, vga_v_sync, r, g, b);
  input wire CLK_3_33_MHZ;
  output wire vga_h_sync;
  output wire vga_v_sync;
  output wire r;
  output wire g;
  output wire b;
    
  VGA vga(CLK_3_33_MHZ, vga_h_sync, vga_v_sync, r, g, b);
    
endmodule