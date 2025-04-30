//MIPS_SCP_tb.v
`timescale 1ns/1ns

`define V0_PATH uut.datapathcomp.RF.register[2]
`define A0_PATH uut.datapathcomp.RF.register[4]
`define A1_PATH uut.datapathcomp.RF.register[5]

module MIPS_SCP_tb;
    // clock & reset
    reg clk   = 0;
    reg reset = 1;             

    always #5 clk = ~clk;

    // DUT
    MIPS_SCP uut ( .clk(clk), .reset(reset) );

    
    wire [31:0] v0_tb = `V0_PATH;
    wire [31:0] a0_tb = `A0_PATH;
    wire [31:0] a1_tb = `A1_PATH;

    initial begin
        $readmemb("memfile.txt", uut.imem.Imem);
        #10; 
        reset = 0;
        #100;
        $display("$a0 = %0d (0x%08h), position -> 4", a0_tb, a0_tb);
        $display("$a1 = %0d (0x%08h), position -> 5", a1_tb, a1_tb);
        $display("$v0 = %0d (0x%08h), position -> 2", v0_tb, v0_tb);
    end
endmodule
