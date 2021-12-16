`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:39 10/30/2021 
// Design Name: 
// Module Name:    Control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Control(opcode, functcode, MemRead, MemWrite, MemtoReg, ALUSrc, ALUop, Branchop, isShift, isLoadStore, isJAL, TakeAddressfromReg, regWrite);
	//input clk;
	input [5:0] opcode, functcode; // 6 bit functcode and opcode, every instruction has a unique functcode + opcode combination
	output reg [5:0] ALUop, Branchop; // according to the functcode and opcode we assign ALUop or Branchop to a instruction
	output reg MemRead, MemWrite, MemtoReg, ALUSrc, isShift, isLoadStore, isJAL, TakeAddressfromReg, regWrite; // these are the control lines that are ouputed from the control unit
	
	always @(opcode, functcode) begin
		case(opcode) 
		// all the R type instructions have same opcode 000000
			6'b000000: begin
				case(functcode)
					// if the function code is 000000 the instruction is addition
					6'b000000: begin   // add rs, rt
						ALUop = 6'b000000; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000001 the instruction is compliment
					6'b000001: begin   // comp rs, rt
						ALUop = 6'b000001; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000010 the instruction is and
					6'b000010: begin   // and rs, rt
						ALUop = 6'b000010; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000011 the instruction is xor
					6'b000011: begin   // xor rs, rt
						ALUop = 6'b000011; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000100 the instruction is shift left
					6'b000100: begin   // shll rs, sh
						ALUop = 6'b000100; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 1; isShift = 1; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000101 the instruction is shift right
					6'b000101: begin   // shrl rs, sh
						ALUop = 6'b000101; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 1; isShift = 1; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 001000 the instruction is shift left with register value
					6'b000110: begin  // shllv rs, rt
						ALUop = 6'b000100; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000101 the instruction is shift right with register value
					6'b000111: begin  // shrlv rs, rt
						ALUop = 6'b000101; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000110 the instruction is arithmetic shift right 
					6'b001000: begin  // shra rs, sh
						ALUop = 6'b000110; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 1; isShift = 1; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
					// if the function code is 000110 the instruction is arithmetic shift right with register value
					6'b001001: begin   // shrav rs, rt
						ALUop = 6'b000110; Branchop = 6'b001000;
						regWrite = 1;
						MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
					end
				endcase
			end
			// if the opcode is 000001 the instruction is addition immediate
			6'b000001: begin   // addi
					ALUop = 6'b000000; Branchop = 6'b001000;
					regWrite = 1;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 1; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 000010 the instruction is compliemnt immediate
			6'b000010: begin   // compi
					ALUop = 6'b000001; Branchop = 6'b001000;
					regWrite = 1;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 1; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 000011 the instruction is load word
			6'b000011: begin   // lw
					ALUop = 6'b000000; Branchop = 6'b001000;
					regWrite = 1;
					MemRead = 1; MemWrite = 0; MemtoReg = 1; ALUSrc = 1; isShift = 0; isLoadStore = 1; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 000100 the instruction is store word
			6'b000100: begin   // sw
					ALUop = 6'b000000; Branchop = 6'b001000;
					regWrite = 1;
					MemRead = 0; MemWrite = 1; MemtoReg = 0; ALUSrc = 1; isShift = 0; isLoadStore = 1; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 000101 the instruction is unconditional branch
			6'b000101: begin   // b L
					ALUop = 6'b001001; Branchop = 6'b000110;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 000110 the instruction is branch at register value
			6'b000110: begin   // br rs
					ALUop = 6'b001001; Branchop = 6'b000110;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=1;
			end
			// if the opcode is 000111 the instruction is branch less than zero
			6'b000111: begin   // bltz rs L
					ALUop = 6'b001000; Branchop = 6'b000101;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 001000 the instruction is branch equal to zero
			6'b001000: begin   // bz rs L
					ALUop = 6'b000111; Branchop = 6'b000011;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 001001 the instruction is branch not equal to zero
			6'b001001: begin   // bnz rs L
					ALUop = 6'b000111; Branchop = 6'b000100;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 001010 the instruction is branch and link
			6'b001010: begin   // bl L
					ALUop = 6'b001001; Branchop = 6'b000110;
					regWrite = 1;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 1; TakeAddressfromReg=0;
			end
			// if the opcode is 001011 the instruction is branch at carry
			6'b001011: begin   // bcy L
					ALUop = 6'b001001; Branchop = 6'b000001;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
			// if the opcode is 001100 the instruction is branch at not carry
			6'b001100: begin   // bncy L
					ALUop = 6'b001001; Branchop = 6'b000010;
					regWrite = 0;
					MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; isShift = 0; isLoadStore = 0; isJAL = 0; TakeAddressfromReg=0;
			end
		endcase
	end


endmodule
