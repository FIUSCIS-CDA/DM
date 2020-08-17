`timescale 1ns / 1ps
module testbench();

reg[31:0] addr;
wire[31:0] readdata;
reg[31:0] writedata;
reg we;

DM DMemory(addr, readdata, writedata, we);



initial begin
$readmemh("datamem.dat",DMemory.memory);
addr=8; we=0; writedata=42; #10; 
if (readdata !== 2) begin
           $display("Error: Incorrect data read at address 8: Expected 2 got %d", readdata); $stop;
end
we=1;  #10;
if (readdata !== 42) begin
    $display("Error: Incorrect data read at address 8: Expected 42 got %d", readdata); $stop;
end
$display("All tests passed.");
end

endmodule