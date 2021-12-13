`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:28:50 08/26/2021
// Design Name:   RCA_64bit
// Module Name:   D:/COAA/assignment1_testing/RCA_64bit_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RCA_64bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RCA_64bit_Test;

	// Inputs
	reg [63:0] A_in;
	reg [63:0] B_in;
	reg C_in;

	// Outputs
	wire [63:0] sum;
	wire C_out;

	// Instantiate the Unit Under Test (UUT)
	RCA_64bit uut (
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
		#5 A_in = 64'd0; B_in = 64'd0; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000000000000000000
		#5 A_in = 64'd20; B_in = 64'd9; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000000000000011101
		#5 A_in = 64'd3; B_in = 64'd4; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000000000000000111
		#5 A_in = 64'd999999; B_in = 64'd1999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000011110100101000001110
		#5 A_in = 64'd999999; B_in = 64'd29999999999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000011011111100001100101110111000111110
		#5 A_in = 64'd999999; B_in = 64'd3999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000011110101000111011110
		#5 A_in = 64'd9999; B_in = 64'd4999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000011101010010110
		#5 A_in = 64'd99999; B_in = 64'd5999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000011001111000001110
		#5 A_in = 64'd999999; B_in = 64'd6999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000011110101110110010110
		#5 A_in = 64'd999999; B_in = 64'd7999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000011110110000101111110
		#5 A_in = 64'd9999; B_in = 64'd8999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000100101000110110
		#5 A_in = 64'd999999; B_in = 64'd99; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000100001010100010
		#5 A_in = 64'd999999; B_in = 64'd9; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000000100001001001000
		#5 A_in = 64'd999999; B_in = 64'd999999999999; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000001110100011010100101101000101001000111110
		#5 A_in = 64'd99999; B_in = 64'd200; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000000000000000000000000000000000001000011101100111


	end
      
endmodule

