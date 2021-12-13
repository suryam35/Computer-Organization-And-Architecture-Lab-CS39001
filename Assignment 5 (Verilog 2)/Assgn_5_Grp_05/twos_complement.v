`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:16 09/27/2021 
// Design Name: 
// Module Name:    twos_complement 
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
// Problem number - 2 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module twos_complement(x, clk, rst, z);
	input x, clk, rst;
	output reg z;
	parameter S0 = 0, S1 = 1;
	reg PS, NS;
	always @(posedge clk or posedge rst) begin
	// this is to make present state = S0 if reset else present state = next computed state 
		if(rst)
			PS <= S0;
		else
			PS <= NS;
	end
	
	// output logic
	always @(*) begin
		case (PS)
			S0: begin
			// at state S0 whatever we see as input we give as ouput
				z = x;
			end
			S1: begin
			// at state S1 the output is just opposite of what we have in input
				z = (x) ? 0 : 1;
			end
		endcase
	end
	
	// next state logic
	
	always @(*) begin
		case (PS)
			S0: begin
			// if the present state is S0 then the next state is based on input
				NS = (x) ? S1: S0;
				
			end
			S1: begin
			// if the present state is S1 then the next state is always S1 no matter what the input we get afterwards
				NS = S1;
				
			end
		endcase
	end
endmodule
