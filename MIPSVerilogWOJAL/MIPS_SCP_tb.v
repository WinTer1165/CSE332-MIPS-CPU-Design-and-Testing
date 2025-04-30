// file: MIPS_SCP_tb.v
`timescale 1ns/1ns
module MIPS_SCP_tb;

    // Inputs
    reg clk;
    reg reset;

    // Instantiate the CPU
    MIPS_SCP uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        $readmemb("memfile.txt", uut.imem.Imem);

        // Wait one cycle with reset high
        #10;
        reset = 0;
        #100;  // 10 cycles (10ns per cycle)
    end

endmodule
