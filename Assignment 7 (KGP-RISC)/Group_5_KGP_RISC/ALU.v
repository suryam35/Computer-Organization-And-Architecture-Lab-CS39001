`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:42 10/30/2021 
// Design Name: 
// Module Name:    ALU 
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
module ALU(ALUop, operand1, operand2, carry, lessthanzero, zero, ALUresult);
	//input clk;
	input [5:0] ALUop; // 6 bit ALUop , all the operations are done based on this ALUop only
	input [31:0] operand1, operand2; // two operands given input to the ALU
	output reg [31:0] ALUresult; // the 32 bit result that ALU gives after the computations 
	output reg carry, lessthanzero, zero; // these are the flags that ALU gives based on which braching logic is decided
	
	always @(ALUop, operand1, operand2) begin
		case (ALUop) 
			// if the ALUop is 000000 the operation is addition
			6'b000000: begin   // add instruction
				{carry, ALUresult} = operand1 + operand2;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
			end
			// if the ALUop is 000001 the operation is compliment instruction
			6'b000001: begin   // comp instruction
				{carry, ALUresult} = ~operand2 + 1;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
			end
			// if the ALUop is 000010 the operation is and
			6'b000010: begin   // and instruction
				{ALUresult} = operand1 & operand2;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
				carry = 0;
			end
			// if the ALUop is 000011 the operation is xor
			6'b000011: begin   // xor instruction
				{ALUresult} = operand1 ^ operand2;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
				carry = 0;
			end
			// if the ALUop is 000100 the operation is left shift
			6'b000100: begin   // left shift instruction
				ALUresult = operand1 << operand2;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
				carry = 0;
			end
			// if the ALUop is 000101 the operation is right shift
			6'b000101: begin   // right shift instruction
				ALUresult = operand1 >> operand2;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
				carry = 0;
			end
			// if the ALUop is 000110 the operation is arithmetic right shift
			6'b000110: begin   // arithmetic right shift instruction
				ALUresult = operand1 >>> operand2;
				zero = (ALUresult == 0) ? 1: 0;
				lessthanzero = (ALUresult < 0) ? 1 : 0;
				carry = 0;
			end
			// if the ALUop is 000111 the operation is check for zero
			6'b000111: begin   // check for zero
				ALUresult = 0;
				zero = (operand1 == 0) ? 1: 0;
				lessthanzero = 0;
				carry = 0;
			end
			// if the ALUop is 001000 the operation is check for less than zero
			6'b001000: begin   // check for less than zero
				ALUresult = 0;
				zero = 0;
				lessthanzero = ($signed(operand1) < 0) ? 1: 0;
				carry = 0;
			end
			default : begin
				ALUresult = 0;
				zero = 0;
				lessthanzero = 0;
				carry = 0;
			end
			
		endcase
	end

endmodule
