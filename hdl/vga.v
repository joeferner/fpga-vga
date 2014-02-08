`timescale 1ns / 1ps

// http://tinyvga.com/vga-timing
// http://www.xess.com/static/media/uploads/blog/devbisme/2011-06-11/app001_2.png (docs/vga_timing.png)

module VGA(clk, vga_h_sync, vga_v_sync, r, g, b);
  input wire clk;
  output wire vga_h_sync;
  output wire vga_v_sync;
  output wire r;
  output wire g;
  output wire b;

  reg[10:0] counterX; // 0 - 832
  reg[10:0] counterY; // 0 - 520
  reg vga_hs;
  reg vga_vs;
  
  wire counterXmaxed = (counterX == 832);
  wire counterYmaxed = (counterY == 520);
  
  always @(posedge clk) begin
    if(counterXmaxed)
      counterX <= 0;
    else
      counterX <= counterX + 1;
  end
  
  always @(posedge clk) begin
    if(counterXmaxed) begin
      if(counterYmaxed)
        counterY <= 0;
      else
        counterY <= counterY + 1;
    end
  end
  
  always @(posedge clk) begin
    vga_hs <= (counterX > 664) & (counterX < 704);
    vga_vs <= (counterY > 489) & (counterY < 491);
  end
  
  // v-sync and h-sync are active low so invert
  assign vga_h_sync = ~vga_hs;
  assign vga_v_sync = ~vga_vs;
  
  wire visible = (counterX < 640) & (counterY < 480);
  
  assign r = visible & (counterX > 0) & (counterX < 10);
  assign g = visible & (counterX > 630) & (counterX < 640);
  assign b = visible & ( ((counterY > 0) & (counterY < 10)) | ((counterY > 470) & (counterY < 480)) );
endmodule
