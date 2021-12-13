`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:33 10/09/2021 
// Design Name: 
// Module Name:    booth 
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

// Assignment number - 6
// Problem number - 3 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module booth(M, Q, out, clk, rst, input_signal);
	input [7:0] M, Q; // Input multiplicand and mutiplier 8 bit
	output reg [15:0] out; // output product 16 bit
	input clk, rst, input_signal; // other inputs
	reg[0:0] Q_1; // temporary used in multiplication process
	reg[0:0] Q_0, C_temp; // temporary used in multiplication process
	reg [7:0] A; // temporary used in multiplication process
	reg[7:0] M_, Q_; // temporary used in multiplication process
	
	
	always @(posedge clk) begin
		// At positive edge of clock with reset we reset the A and Q_1 to 0
		if(rst) begin
			Q_1 = 0;
			A = 8'b0;
		end
		// At positive edge of clock with input signal we set out temporaries M_ , Q_ to M and Q
		if(input_signal) begin
			M_ = M;
			Q_ = Q;
		end
		// else we do all the operations
		else begin
			Q_0 = Q_[0];
		// Check the most significant bit of Q with Q_1, if it is 01 then do A = A + M else if it is 10 do A = A - M
			if(Q_0 == 0 & Q_1 == 1) begin
				{A} = A + M_;
			end
			else if(Q_0 == 1 & Q_1 == 0) begin
				{A} = A - M_;
			end
		// set Q_1 as the least significant bit of Q
			Q_1 = Q_[0];
		// Right shift Q
			Q_ = Q_ >> 1;
			Q_0 = Q_[0];
		// make MSB of Q to LSB of A
			Q_[7] = A[0];
		// do arithmetic right shift on A
			A = $signed(A) >>> 1;
		// set lower 8 bits of output to Q and upper to A, together they make the product
			out[7:0] = Q_;
			out[15:8] = A;
		end
	end
	

endmodule

