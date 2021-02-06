//Set clock period to 200
module testbench();

reg clk;
reg[31:0] addr;
wire[31:0] readdataSynch;
wire[31:0] readdataAsynch;
reg[31:0] writedata;
reg we;

DM_synch DMemorySynch(clk, addr, readdataSynch, writedata, we);
DM_asynch DMemoryAsynch(addr, readdataAsynch, writedata, we);


localparam CLK_PERIOD=100;

always @*
begin
   clk <= 1;  # (CLK_PERIOD/2);
   clk <= 0;  # (CLK_PERIOD/2);
end

initial begin
$readmemh("datamem.dat",DMemorySynch.memory);
$readmemh("datamem.dat",DMemoryAsynch.memory);
addr=8; we=0; writedata=42; #100; 
if (readdataSynch !== 2) begin
           $display("[SYNCH] Error: Incorrect data read at address 8: Expected 2 got %d", readdataSynch); $stop;
end
if (readdataAsynch !== 2) begin
           $display("[ASYNCH] Error: Incorrect data read at address 8: Expected 2 got %d", readdataAsynch); $stop;
end
we=1;  #100;
if (readdataSynch !== 2) begin
    $display("[SYNCH] Error: Incorrect data read at address 8: Expected 2 got %d", readdataSynch); $stop;
end
if (readdataAsynch !== 42) begin
    $display("[ASYNCH] Error: Incorrect data read at address 8: Expected 42 got %d", readdataAsynch); $stop;
end
#100;
if (readdataSynch !== 42) begin
    $display("[SYNCH] Error: Incorrect data read at address 8: Expected 42 got %d", readdataSynch); $stop;
end
if (readdataAsynch !== 42) begin
    $display("[ASYNCH] Error: Incorrect data read at address 8: Expected 42 got %d", readdataAsynch); $stop;
end
$display("All tests passed.");
end

endmodule