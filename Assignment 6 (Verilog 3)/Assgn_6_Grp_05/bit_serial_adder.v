`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:09 10/09/2021 
// Design Name: 
// Module Name:    bit_serial_adder 
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
// Problem number - 2 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module bit_serial_adder(A, B, Cin, S, C_, clk, input_signal, rst);
	input [7:0] A, B; // input numbers
	input Cin, clk, input_signal, rst; // other inputs 
	output reg [7:0] S; // output sum
	output reg C_; // output carry out
	reg C, S_; // These are some temporaries to hold the value
	reg [7:0] A_, B_; // These are some temporaries to hold the value
	
	always @(posedge clk) begin
	// At positive edge of the clock and with reset we set the temp carry out as carry in
		if(rst) begin
			C = Cin;
		end
	// At positive edge of the clock and without reset we set the temp carry out as carry out for next computation
		else begin
			C = C_;
		end
	end
	always @(posedge clk) begin
	// At positive edge of the clock and input signal  we set the temp A_, B_ out as input A, B and sum to 0
		if(input_signal) begin
			A_ = A;
			B_ = B;
			S = 8'b0;
		end
	// At positive edge of the clock without input signal  we do all the shifting operations to get the least aignificant bits of inputs for next computation
		else begin
			A_ = A_ >> 1;
			B_ = B_ >> 1;
			S = S >> 1;
			S[7] = S_;
		end
	end
	
	always @(negedge clk) begin
	// At the negative edge of the clock we do the computation of addition and getting the carry out and sum bit
	// This is just working as a full adder
		S_ <= A_[0] ^ B_[0] ^ C;
		C_ <= A_[0]&B_[0] | A_[0]&C | B_[0] & C;
	end

endmodule
