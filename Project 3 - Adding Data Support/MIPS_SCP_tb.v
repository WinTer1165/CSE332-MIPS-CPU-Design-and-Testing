`timescale 1ns/1ps                     

`define IM_ARRAY_PATH   uut.imem.Imem          
`define DM_ARRAY_PATH   uut.dmem.Dmem         
`define RF_PATH         uut.datapathcomp.RF.register 

module MIPS_SCP_tb;

    reg clk   = 0;
    reg reset = 1;

    always #5 clk = ~clk;

    MIPS_SCP uut ( .clk(clk), .reset(reset) );

    reg  [31:0] prev_v0 = 0;           
    reg  [31:0] v0, a0;               

    initial begin
        $readmemb("memfile.txt", `IM_ARRAY_PATH); // instructions
        $readmemb("data.txt",    `DM_ARRAY_PATH); // data segment
        #12 reset = 0;                         
    end

    
    always @(negedge clk) begin
        v0 = `RF_PATH[2];             // $v0
        a0 = `RF_PATH[4];             // $a0

        if (v0 !== prev_v0) begin     
            case (v0)
                4  : begin
                        $display("\nSyscall 4 – print string:");
                        print_string(a0);
                     end
                10 : begin
                        $finish;
                     end
            endcase
        end
        prev_v0 <= v0;                //for next edge
    end

task automatic print_string (input [31:0] byte_addr_start);
    reg [31:0] word;
    reg [7:0]  char;
    reg [31:0] byte_addr;
    integer    idx;
    begin
        idx = 0;
        forever begin
            byte_addr = byte_addr_start + idx;
            word      = `DM_ARRAY_PATH[byte_addr[31:2]];

            case (byte_addr[1:0])                 // big endian
                2'b00: char = word[31:24];
                2'b01: char = word[23:16];
                2'b10: char = word[15:8];
                2'b11: char = word[7:0];
            endcase

            if (char == 8'h00) begin 
                $display("");
                disable print_string;
            end
            else begin
                $write("%c", char);
                idx = idx + 1;
            end
        end
    end
endtask
endmodule
