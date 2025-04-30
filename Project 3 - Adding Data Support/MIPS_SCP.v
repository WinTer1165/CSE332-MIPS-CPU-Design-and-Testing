// file: MIPS_SCP.v
`include "datapath.v"
`include "ram.v"
`include "rom.v"
`include "control.v"

`timescale 1ns/1ns
module MIPS_SCP(
    input clk,
    input reset
);

    wire [31:0] PC, Instr, ReadData, WriteData, ALUResult;
    wire RegDst, RegWrite, ALUSrc, Jump, Jal, Jr, MemtoReg, PCSrc, Zero, MemWrite;
    wire [3:0] ALUControl;

    // Instantiate datapath with new Jal and Jr signals
    Datapath datapathcomp(
        clk, reset,
        RegDst, RegWrite, ALUSrc, Jump, Jal, Jr, MemtoReg, PCSrc,
        ALUControl,
        ReadData, Instr,
        PC, Zero,
        WriteData, ALUResult
    );

    // Instantiate control unit with new Jal and Jr outputs
    Controlunit controller(
        Instr[31:26], Instr[5:0], Zero,
        MemtoReg, MemWrite, ALUSrc, RegDst,
        RegWrite, Jump, Jal, Jr, PCSrc, ALUControl
    );

    // Data memory
    ram dmem(clk, MemWrite, ALUResult, WriteData, ReadData);

    // Instruction memory (ROM)
    rom imem(PC, Instr);

endmodule
