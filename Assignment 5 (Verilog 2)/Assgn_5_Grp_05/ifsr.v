`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:52 09/27/2021 
// Design Name: 
// Module Name:    ifsr 
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

// Assignment number - 5
// Problem number - 1 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module lfsr(clk, rst, seed, sel, w);
	input clk, rst, sel;
	input[3:0] seed;
	output reg[3:0] w;
	reg[0:0] w1, w2, w3, w4, w5;
	
	// at negative edge we are setting the output
	// according to input seed and our registers
	always @(negedge clk) begin
		w[3] = sel ? seed[3] : w1;
		w[2] = sel ? seed[2] : w2;
		w[1] = sel ? seed[1] : w3;
		w[0] = sel ? seed[0] : w4;
	end
	
	always @(posedge clk or posedge rst) begin
	// at reset making all the bits zero
		if(rst) begin
			w1 = 0;
			w2 = 0;
			w3 = 0;
			w4 = 0;
			w5 = 0;
		end
	// here we are shifting the bits
		else begin
			w2 = w[3];
			w3 = w[2];
			w4 = w[1];
			w5 = w[0];
			w1 = w4^w5;
		end
	end
	
endmodule
