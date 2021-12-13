`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:07 09/27/2021 
// Design Name: 
// Module Name:    modulo_3 
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
// Problem number - 3 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module modulo_3(x, clk, rst, z);
	input x, clk, rst;
	output reg z;
	parameter S0 = 0, S1 = 1, S2 = 2;
	reg[1:0] PS, NS;
	
	always @(posedge clk or posedge rst) begin
	// this is to make present state = S0 if reset else present state = next computed state at the positive edge of clock
		if(rst) begin
			PS <= S0;
		end
		else begin
			PS <= NS;
		end
	end
	// output logic
	always @(negedge clk) begin
		case (PS)
			S0: begin
			// at state S0 the output is just opposite of what we have in input
				z = (x) ? 0 : 1;
			end
			S1: begin
			// at state S1 whatever we see as input we give as ouput
				z = x;
			end
			S2: begin
			// at state S2 the output is always 0
				z = 0;
			end
			default: begin
				z = 0;
			end
		endcase
	end
	
	// next state logic
	always @(negedge clk) begin
		case (PS)
			S0: begin
			// if PS = S0, NS = S1 (if x = 1) and NS = S0 (if x = 0) 
				NS = (x) ? S1 : S0;
			end
			S1: begin
			// if PS = S1, NS = S0 (if x = 1) and NS = S2 (if x = 0) 
				NS = (x) ? S0 : S2;
			end
			S2: begin
			// if PS = S2, NS = S2 (if x = 1) and NS = S1 (if x = 0) 
				NS = (x) ? S2 : S1;
			end
			default: begin
				NS = S0;
			end
		endcase
	end

endmodule
