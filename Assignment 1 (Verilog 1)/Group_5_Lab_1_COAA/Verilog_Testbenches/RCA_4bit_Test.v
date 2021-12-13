`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:31:18 08/26/2021
// Design Name:   RCA_4bit
// Module Name:   D:/COAA/assignment1_testing/RCA_4bit_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RCA_4bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RCA_4bit_Test;

	// Inputs
	reg [3:0] A_in;
	reg [3:0] B_in;
	reg C_in;

	// Outputs
	wire [3:0] sum;
	wire C_out;

	// Instantiate the Unit Under Test (UUT)
	RCA_4bit uut (
		.sum(sum), 
		.C_out(C_out), 
		.A_in(A_in), 
		.B_in(B_in), 
		.C_in(C_in)
	);

	initial begin
		// Initialize Inputs
		A_in = 0;
		B_in = 0;
		C_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor($time," A= %b, B=%b, C_IN= %b, --- C_OUT= %b, SUM= %b\n",A_in, B_in, C_in, C_out, sum);
		#5 A_in = 4'd0; B_in = 4'd0; C_in = 1'b0; // C_OUT= 0, SUM= 0000
		#5 A_in = 4'd7; B_in = 4'd9; C_in = 1'b0; // C_OUT= 1, SUM= 0000
		#5 A_in = 4'd3; B_in = 4'd4; C_in = 1'b0; // C_OUT= 0, SUM= 0111
		#5 A_in = 4'd6; B_in = 4'd9; C_in = 1'b0; // C_OUT= 0, SUM= 1111
		#5 A_in = 4'd5; B_in = 4'd5; C_in = 1'b0; // C_OUT= 0, SUM= 1010
		#5 A_in = 4'd6; B_in = 4'd1; C_in = 1'b0; // C_OUT= 0, SUM= 0111
		#5 A_in = 4'd6; B_in = 4'd2; C_in = 1'b0; // C_OUT= 0, SUM= 1000
		#5 A_in = 4'd6; B_in = 4'd3; C_in = 1'b0; // C_OUT= 0, SUM= 1001
		#5 A_in = 4'd6; B_in = 4'd4; C_in = 1'b0; // C_OUT= 0, SUM= 1010
		#5 A_in = 4'd6; B_in = 4'd5; C_in = 1'b0; // C_OUT= 0, SUM= 1011
		#5 A_in = 4'd6; B_in = 4'd6; C_in = 1'b0; // C_OUT= 0, SUM= 1100
		#5 A_in = 4'd6; B_in = 4'd7; C_in = 1'b0; // C_OUT= 0, SUM= 1101
		#5 A_in = 4'd6; B_in = 4'd8; C_in = 1'b0; // C_OUT= 0, SUM= 1110
		#5 A_in = 4'd6; B_in = 4'd10; C_in = 1'b0; // C_OUT= 1, SUM= 0000
		#5 A_in = 4'd3; B_in = 4'd3; C_in = 1'b0; // C_OUT= 0, SUM= 0110
		#5 $finish;

	end
      
endmodule

