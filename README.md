# CSE332-MIPS-CPU-Design-and-Testing

This project implements a MIPS CPU design in Verilog and includes testing across four progressive project phases.

## Project Overview

- **Project 0:** Verify ModelSim and WSL setup
- **Project 1:** Test JAL and JR instruction functionality
- **Project 2:** Implement and verify MIN, MAX, MEAN operations
- **Project 3:** Add support for .data section handling

## Prerequisites

1. ModelSim
2. Ubuntu WSL
3. MipsAssembler (for generating binary files)
4. MIPSVerilogWOJAL (Verilog codebase)
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
<img src="https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_16x9.jpg?w=1200" width="600" alt="Description of image">  
6. View the binary file from assembly or use any text editor:  

```bash
 nano test.bin
```
<img src="https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_16x9.jpg?w=1200" width="600" alt="Description of image">  
7. Transfer content from test.bin to memfile.txt (remove all spaces and hex addresses)

<img src="https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_16x9.jpg?w=1200" width="600" alt="Description of image">  

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
   
<img src="https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_16x9.jpg?w=1200" width="600" alt="Description of image">  
<img src="https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_16x9.jpg?w=1200" width="600" alt="Description of image">  

## Additional Project Phases

Detailed instructions for Projects 1-3 will be included in their respective sections.
