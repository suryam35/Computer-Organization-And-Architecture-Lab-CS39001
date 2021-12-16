`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:06 10/30/2021 
// Design Name: 
// Module Name:    PC 
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
module PC(clk, rst, new_pc, pc);
	input clk, rst; // clock and reset signal in input
	input [31:0] new_pc; // 32 bit new value of the program counter 
	output reg[31:0] pc; // 32 bit old program counter
	
	always@(posedge clk) begin
		if(rst) begin
		// at reset signal, set the program counter to 0
			pc = 0;
		end
		else begin
		// else we just set the program counter to the new program counter
			pc = new_pc;
		end
	end
	
			

endmodule
