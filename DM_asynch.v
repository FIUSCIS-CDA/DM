///////////////////////////////////////////////////////////////////////////////////
// Component: DM_asynch (Latency=90)
// Package: FIUSCIS-CDA
// Course: CDA3102 (Computer Architecture), Florida International University
// Developer: Trevor Cickovski
// License: MIT, (C) 2020 All Rights Reserved
///////////////////////////////////////////////////////////////////////////////////

module DM_asynch(a, rd, wd, we);    
   input[31:0] a;
   input we;
   output wire [31:0] rd;
   input [31:0] wd;
   
   reg [31:0] memory [0:1023];
   reg [31:0] buffer;   

   always @(*) begin
     #90;
     if (we) begin
         memory[a >> 2] = wd;
      end
     buffer = memory[a >> 2];
   end
   
   assign rd = buffer;
endmodule