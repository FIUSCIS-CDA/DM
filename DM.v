`timescale 1ns / 1ps
module DM(a, rd, wd, we);    
   input[31:0] a;
   input we;
   output wire [31:0] rd;
   input [31:0] wd;
   
   reg [31:0] memory [0:1023];
   
   always @(*) begin
     if (we) begin
         memory[a >> 2] = wd;
      end
   end
   
   assign rd = memory[a >> 2];
endmodule


