`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:28:08 08/26/2021
// Design Name:   RCA_32bit
// Module Name:   D:/COAA/assignment1_testing/RCA_32bit_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RCA_32bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RCA_32bit_Test;

	// Inputs
	reg [31:0] A_in;
	reg [31:0] B_in;
	reg C_in;

	// Outputs
	wire [31:0] sum;
	wire C_out;

	// Instantiate the Unit Under Test (UUT)
	RCA_32bit uut (
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
		#5 A_in = 32'd0; B_in = 32'd0; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000000000000000000000
		#5 A_in = 32'd20; B_in = 32'd9; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000000000000000011101
		#5 A_in = 32'd3; B_in = 32'd4; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000000000000000000111
		#5 A_in = 32'd999999; B_in = 32'd1999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000000100101000001110
		#5 A_in = 32'd999999; B_in = 32'd29999999; C_in = 1'b0; // C_OUT= 0, SUM= 00000001110110010000010110111110
		#5 A_in = 32'd999999; B_in = 32'd3999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000011110101000111011110
		#5 A_in = 32'd9999; B_in = 32'd4999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000000011101010010110
		#5 A_in = 32'd99999; B_in = 32'd5999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000011001111000001110
		#5 A_in = 32'd999999; B_in = 32'd6999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000011110101110110010110
		#5 A_in = 32'd999999; B_in = 32'd7999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000011110110000101111110
		#5 A_in = 32'd9999; B_in = 32'd8999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000000100101000110110
		#5 A_in = 32'd999999; B_in = 32'd99; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000011110100001010100010
		#5 A_in = 32'd999999; B_in = 32'd9; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000011110100001001001000
		#5 A_in = 32'd999999; B_in = 32'd99999; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000100001100100011011110
		#5 A_in = 32'd99999; B_in = 32'd200; C_in = 1'b0; // C_OUT= 0, SUM= 00000000000000011000011101100111

	end
      
endmodule

