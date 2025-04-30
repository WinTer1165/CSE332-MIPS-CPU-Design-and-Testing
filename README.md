# CSE332-MIPS-CPU-Design-and-Testing

This project implements a MIPS CPU design in Verilog and includes testing across four progressive project phases.

## Project Overview

- **Project 0:** Verify ModelSim and WSL setup
- **Project 1:** Test JAL and JR instruction functionality
- **Project 2:** Implement and verify MIN, MAX, MEAN operations
- **Project 3:** Add support for .data section handling

## Prerequisites

1. ModelSim (Intel FPGA Starter Edition 2020.1)
2. Ubuntu WSL (Ubuntu 22.04.5 LTS)
3. MipsAssembler (for generating binary files)
4. MIPSVerilogWOJAL (base Verilog codebase)
5. UpgradedMIPS32Assembler (for .data section support)

## Project 0: Environment Setup

### Setting Up WSL

1. Open Ubuntu WSL
2. Mount your Windows drive:
```bash
cd /mnt/your_location
```
3. Install required gcc and g++ compilers:
```bash
sudo apt install gcc --fix-missing
sudo apt install g++ --fix-missing
```
4. Compile the MIPS assembler:
```bash
g++ finalassembler.cpp -o myassemblername
```
5. Create a binary file from assembly for our .s file:
```bash
./myassemblername inttest2.s test.bin
```
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/0%20Pic/wsl.png" width="600" alt="Description of image">  
6. View the binary file from assembly or use any text editor:  

```bash
 nano test.bin
```
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/0%20Pic/nano.png" width="500" alt="Description of image">  
7. Transfer content from test.bin to memfile.txt (remove all spaces and hex addresses)

<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/0%20Pic/mem.png" width="500" alt="Description of image">  

### Setting Up ModelSim

1. Create a new project
2. Add all .v files from MIPSVerilogWOJAL (copy files to the project rather than referencing)
3. Add memfile.txt to the project (copy files to the project rather than referencing)
4. Compile all files (right-click on any file and select "Compile All")
5. Start simulation (Simulate Menu → Start Simulation)
6. In the start dialog, select `work`, then your testbench (`MIPS_SCP_tb.v`), and click OK
7. Right-click on `MIPS_SCP_tb` in the Instance panel and add wave
8. Start simulation by selecting "Run All" from the toolbar
9. Stop the simulation after a few seconds
10. Locate the Memory List panel above the terminal
11. Select the memory addresses you want to inspect
12. Right-click on memory data and go to Properties to change display format to decimal for easier interpretation
   
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/0%20Pic/ms1.png" width="600" alt="Description of image">  
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/0%20Pic/ms2.png" width="600" alt="Description of image">  

## Project 1: Test JAL and JR instruction functionality
Here we implemented JAL and JR in control.v and datapath.v verilog file. We also write a new testbench for MIPS_SCP_tb.v to show the output. Here is our jaljrtest.s and MIPS_SCP_tb.v file:  

```bash
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
```

<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/1%20Pic/scode.png" width="400" alt="Description of image">  
1. Create a binary file from assembly for our .s file:
```bash
./myassembler jaljrtest.s jaljrtest.bin
```
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/1%20Pic/wsl.png" width="500" alt="Description of image">  
2. View the binary file from assembly or use any text editor:  

```bash
nano jaljrtest.bin
```
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/1%20Pic/bin.png" width="500" alt="Description of image">  
3. Transfer content from jaljrtest.bin to memfile.txt (remove all spaces and hex addresses)

<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/1%20Pic/mem.png" width="600" alt="Description of image"> 

4. Simulate the new project using the same methods as Project 0.

<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/1%20Pic/ms1.png" width="400" alt="Description of image">  
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/1%20Pic/ms2.png" width="600" alt="Description of image">  

## Project 2: Implement and verify MIN, MAX, MEAN operations
Here we have written a .s code to find the minimum, maximum and mean(average) among some numbers. We also write a new testbench for MIPS_SCP_tb.v to show the output. Our mmm.s code:

```
# MIPS program to find min, max, sum, and average of 2, 1, 3
# Results:
#   $s0 = min
#   $s1 = max
#   $s2 = sum
#   $v0 = average

.text
main:
    li $t0, 2       # num1
    li $t1, 1       # num2
    li $t2, 3       # num3

    # Min
    move $s0, $t0       
    slt  $t3, $t1, $s0 
    beq  $t3, $zero, check_t2_min
    move $s0, $t1     

check_t2_min:
    slt  $t3, $t2, $s0  
    beq  $t3, $zero, done_min
    move $s0, $t2      

done_min:

    # Max
    move $s1, $t0       
    slt  $t3, $s1, $t1  
    beq  $t3, $zero, check_t2_max
    move $s1, $t1      

check_t2_max:
    li $t0, 2       # num1
    li $t1, 1       # num2
    li $t2, 3       # num3
    slt  $t3, $s1, $t2  
    beq  $t3, $zero, done_max
    move $s1, $t2      

done_max:
    li $t0, 2       # num1
    li $t1, 1       # num2
    li $t2, 3       # num3
    # Sum
    add	 $s2, $t0, $t1
    add	 $s2, $s2, $t2

    move $a0, $s2  
    li $a1, 3 
    jal divide       

    li $v0, 10
    syscall

divide:
    move $v1, $a0    
    li   $v0, 0      

div_loop:
    sub $v1, $v1, $a1      
    slt $a2, $v1, $zero    
    bne $a2, $zero, end_div 
    addi $v0, $v0, 1       
    j div_loop

end_div:
    jr $ra
```

Our MIPS_SCP_tb.v code:
```bash
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
```

1. Create a binary file from the assembly for our .s file:
```bash
./myassembler mmm.s mmm.bin
```
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/2%20Pic/wsl.png" width="600" alt="Description of image">  
2. View the binary file from assembly or use any text editor:  

```bash
nano mmm.bin
```
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/2%20Pic/bin.png" width="500" alt="Description of image">  
3. Transfer content from mmm.bin to memfile.txt (remove all spaces and hex addresses)

<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/2%20Pic/mem.png" width="500" alt="Description of image"> 

4. Simulate the new project using the same methods as Project 0.

<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/2%20Pic/ms1.png" width="400" alt="Description of image">  
<img src="https://github.com/WinTer1165/CSE332-MIPS-CPU-Design-and-Testing/blob/main/images/2%20Pic/ms2.png" width="600" alt="Description of image">  
