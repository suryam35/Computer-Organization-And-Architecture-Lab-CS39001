`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:56 09/27/2021 
// Design Name: 
// Module Name:    comparator 
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
// Problem number - 4 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module comparator(clk, rst, A, B, L, E, G, input_signal, OP);
	input clk, rst, input_signal; // These are the inputs
	input [31:0] A, B;  				// These are the 32 bit numeric input
	output reg L = 0, E = 0, G = 0; // These are the register that will tell whether A < B (L = 1) or A > B (G = 1) or A == B (E = 1)
 	output reg OP = 0;				// This register in output will be 1 if the process is complete and else 0
	reg a, b;
	reg [7:0] count; 					// This is used to count how many bits are compared till now
	parameter S0 = 0, S1 = 1, S2 = 2; // Defining the states
	reg [1:0] PS, NS;   				// These are present state and next state
	reg [31:0] A_ , B_; 				// This is used to convert input wire signal to register to do operations on it
	
	
	always @(negedge clk) begin
		if(input_signal) begin
			A_ = A;
			B_ = B;
			a = A_[31]; b = B_[31];
			A_ = A_ << 1;
			B_ = B_ << 1;
			A_[0] = 0;
			B_[0] = 0;
		end
		else begin
			a = A_[31]; b = B_[31];
			A_ = A_ << 1;
			B_ = B_ << 1;
			A_[0] = 0;
			B_[0] = 0;
		end
	end
	
	always @(posedge clk or posedge rst) begin
		// this is just to make present state = S0, and making count = 0
		if(rst) begin
			PS <= S0;
			count <= 0;
		end
		
		else begin
		// changing the present state to the calculated next state
			PS <= NS;
		// incrementing the count
			count <= count + 8'b00000001;
		end
	end
	
	// The below always block is for next state logic
	
	always @(*) begin
		case (PS)
			S0: begin
			// At S0 if both the bits of a and b are equal (00 or 11) then the next state will be S0 only
				if(a == b) begin
					NS = S0;
				end
			// At S0 if bit of a is 1 and bit of b is 0 then the next state is S1
				else if(a > b) begin
					NS = S1;
				end
				else begin
					NS = S2;
				end
			end
			// Once we reach S1 , whatever the bits are after that seen we will stay at S1 and give the output greater equal at the end
			S1: begin
				NS = S1;
			end
			// Once we reach S2 , whatever the bits are after that seen we will stay at S1 and give the output lesser equal at the end
			S2: begin
				NS = S2;
			end
			// Otherwise we go back to S0 and give the output equal at the end
			default: begin
				NS = S0;
			end
		endcase
	end
	
	always @(*) begin
	// This is to check if we have seen all the 32 bits since we have to give outputs then only
		if(count >= 32) begin
			// after 32 bits we can make OP = 1 , that shows process is finished 
			OP <= 1;
			// This is setting the output based on the last state we were in when process completed
			L <= (PS == S2);
			E <= (PS == S0);
			G <= (PS == S1);
		end
		else begin
			// if the process is not yet complete we set the outputs to be zero
			OP <= 0;
			L <= 0;
			E <= 0;
			G <= 0;
		end
	end
endmodule
