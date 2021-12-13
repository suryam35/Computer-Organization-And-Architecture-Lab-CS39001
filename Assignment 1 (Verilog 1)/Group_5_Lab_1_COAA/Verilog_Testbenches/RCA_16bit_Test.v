`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:27:16 08/26/2021
// Design Name:   RCA_16bit
// Module Name:   D:/COAA/assignment1_testing/RCA_16bit_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RCA_16bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RCA_16bit_Test;

	// Inputs
	reg [15:0] A_in;
	reg [15:0] B_in;
	reg C_in;

	// Outputs
	wire [15:0] sum;
	wire C_out;

	// Instantiate the Unit Under Test (UUT)
	RCA_16bit uut (
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
		#5 A_in = 16'd0; B_in = 16'd0; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000000
		#5 A_in = 16'd20; B_in = 16'd9; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000011101
		#5 A_in = 16'd3; B_in = 16'd4; C_in = 1'b0; // C_OUT= 0, SUM= 0000000000000111
		#5 A_in = 16'd9999; B_in = 16'd1999; C_in = 1'b0; // C_OUT= 0, SUM= 0010111011011110
		#5 A_in = 16'd9999; B_in = 16'd2999; C_in = 1'b0; // C_OUT= 0, SUM= 0011001011000110
		#5 A_in = 16'd9999; B_in = 16'd3999; C_in = 1'b0; // C_OUT= 0, SUM= 0011011010101110
		#5 A_in = 16'd9999; B_in = 16'd4999; C_in = 1'b0; // C_OUT= 0, SUM= 0011101010010110
		#5 A_in = 16'd9999; B_in = 16'd5999; C_in = 1'b0; // C_OUT= 0, SUM= 0011111001111110
		#5 A_in = 16'd9999; B_in = 16'd6999; C_in = 1'b0; // C_OUT= 0, SUM= 0100001001100110
		#5 A_in = 16'd9999; B_in = 16'd7999; C_in = 1'b0; // C_OUT= 0, SUM= 0100011001001110
		#5 A_in = 16'd9999; B_in = 16'd8999; C_in = 1'b0; // C_OUT= 0, SUM= 0100101000110110
		#5 A_in = 16'd9999; B_in = 16'd99; C_in = 1'b0; // C_OUT= 0, SUM= 0010011101110010
		#5 A_in = 16'd9999; B_in = 16'd9; C_in = 1'b0; // C_OUT= 0, SUM= 0010011100011000
		#5 A_in = 16'd9999; B_in = 16'd99999; C_in = 1'b0; // C_OUT= 0, SUM= 1010110110101110
		#5 A_in = 16'd9999; B_in = 16'd200; C_in = 1'b0; // C_OUT= 0, SUM= 0010011111010111
	end
      
endmodule

