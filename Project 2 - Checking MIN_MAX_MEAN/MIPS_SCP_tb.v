//MIPS_SCP_tb.v file

`timescale 1ns/1ps    

`define RF_PATH   uut.datapathcomp.RF.register
`define S0_PATH   `RF_PATH[16]  
`define S1_PATH   `RF_PATH[17]   
`define S2_PATH   `RF_PATH[18]  
`define V0_PATH   `RF_PATH[2]  
`define T0_PATH   `RF_PATH[ 8]   
`define T1_PATH   `RF_PATH[ 9]   
`define T2_PATH   `RF_PATH[10]   


module MIPS_SCP_tb;

    reg clk   = 0;
    reg reset = 1;

    always #5 clk = ~clk;

    MIPS_SCP uut ( .clk(clk), .reset(reset) );

    
    wire [31:0] s0_tb = `S0_PATH;
    wire [31:0] s1_tb = `S1_PATH;
    wire [31:0] s2_tb = `S2_PATH;
    wire [31:0] v0_tb = `V0_PATH;

    wire [31:0] t0_tb = `T0_PATH;
    wire [31:0] t1_tb = `T1_PATH;
    wire [31:0] t2_tb = `T2_PATH;
   

    integer i;
    localparam RUN_TIME = 800; 

    initial begin
        $readmemb("memfile.txt", uut.imem.Imem);
        #10 reset = 0;
        #(RUN_TIME);

        $display("$t0 (num1)  = %0d", t0_tb);
        $display("$t1 (num2)  = %0d", t1_tb);
        $display("$t2 (num3)  = %0d", t2_tb);
        $display("$s0 (minimum) = %0d", s0_tb);
        $display("$s1 (maximum) = %0d", s1_tb);
        $display("$s2 (sum) = %0d", s2_tb);
        $display("$v0 (average) = %0d", v0_tb);
    end
`ifdef VCD
    initial begin
        $dumpfile("mips_scptest.vcd");
        $dumpvars(0, MIPS_SCP_tb);
    end
`endif
endmodule
