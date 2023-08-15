///////////////////////////////////////////////////////////////////////////////////
// Testbench for Component: DM (CLK=200)
// Package: FIUSCIS-CDA
// Course: CDA3102 (Computer Architecture), Florida International University
// Developer: Trevor Cickovski
// License: MIT, (C) 2020 All Rights Reserved
///////////////////////////////////////////////////////////////////////////////////

module testbench();
`include "../Test/Test.v"

//////////////////////////////////////////////////////////////////////////////////
// Tests both synchronous and asynchronous memory
/////////////////////////////////////////////////////////////
// Inputs: addr, writedata (32-bit), we (1-bit)
//         clk (1-bit, synchronous only)
reg[31:0] addr;
reg[31:0] writedata;
reg we;
reg clk; // Clock it at 200
/////////////////////////////////////////////////////////////
// Outputs: readdataSynch (32-bit, synchronous only)
//          readdataAsynch (32-bit, asynchronous only)
wire[31:0] readdataSynch;
wire[31:0] readdataAsynch;
/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

DM_synch DMemorySynch(
	.clk(clk),
	.a(addr),
	.rd(readdataSynch),
        .wd(writedata),
        .we(we));

DM_asynch DMemoryAsynch(
.a(addr), 
.rd(readdataAsynch), 
.wd(writedata), 
.we(we));


initial begin
/////////////////////////////////////////////////////////////////////////////
// Populate both memories with the same data
$readmemh("datamem.dat",DMemorySynch.memory);
$readmemh("datamem.dat",DMemoryAsynch.memory);
/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
// For both memories, address 8 has the value 2 initially
////////////////////////////////////////////////////////////////////////////
// Test: addr=8, writedata=42, we=0 (readdata should still be 2)
addr=8; we=0; writedata=42; #100;
$display("[SYNCH] Testing addr=8 with writedata=42 and we=0: DM[8]=2"); 
verifyEqual32(readdataSynch, 2);
$display("[ASYNCH] Testing addr=8 with writedata=42 and we=0: DM[8]=2"); 
verifyEqual32(readdataAsynch, 2);
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// Test: addr=8, writedata=42, we=1 before rising edge
// (readdata should only update in asynch)
we=1;  #100;
$display("[SYNCH] Testing addr=8 with writedata=42 and we=1 (falling edge): DM[8]=2"); 
verifyEqual32(readdataSynch, 2);
$display("[ASYNCH] Testing addr=8 with writedata=42 and we=1 (falling edge): DM[8]=42"); 
verifyEqual32(readdataAsynch, 42);
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// Test: addr=8, writedata=42, we=1 after rising edge
// (Read data should update in both)
#100;
$display("[SYNCH] Testing addr=8 with writedata=42 and we=1 (falling edge): DM[8]=2"); 
verifyEqual32(readdataSynch, 42);
$display("[ASYNCH] Testing addr=8 with writedata=42 and we=1 (falling edge): DM[8]=42"); 
verifyEqual32(readdataAsynch, 42);
$display("All tests passed.");
end
///////////////////////////////////////////////////////////////////////////

endmodule