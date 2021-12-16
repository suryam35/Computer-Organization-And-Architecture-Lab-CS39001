`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:26 10/30/2021 
// Design Name: 
// Module Name:    SignExtension 
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
module SignExtension(imm16, imm32);
	input [15:0] imm16;
	output [31:0] imm32;
	// sign extension of 16 bit constant to 32 bit
	assign imm32[31:0] = { {16{imm16[15]}},imm16[15:0] };


endmodule
