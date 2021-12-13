`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:25:57 08/26/2021
// Design Name:   RCA_8bit
// Module Name:   D:/COAA/assignment1_testing/RCA_8bit_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RCA_8bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RCA_8bit_Test;

	// Inputs
	reg [7:0] A_in;
	reg [7:0] B_in;
	reg C_in;

	// Outputs
	wire [7:0] sum;
	wire C_out;

	// Instantiate the Unit Under Test (UUT)
	RCA_8bit uut (
		.sum(sum), 
		.C_out(C_out), 
		.A_in(A_in), 
		.B_in(B_in), 
		.C_in(C_in)
	);

	initial begin
		// Initialize Inputs
		//A_in = 0;
		//B_in = 0;
		//C_in = 0;

		// Wait 100 ns for global reset to finish
		// #100;
        
		// Add stimulus here
		$monitor($time," A= %b, B=%b, C_IN= %b, --- C_OUT= %b, SUM= %b\n",A_in, B_in, C_in, C_out, sum);
		#5 A_in = 8'd0; B_in = 8'd0; C_in = 1'b0; // C_OUT= 0, SUM= 00000000
		#5 A_in = 8'd7; B_in = 8'd9; C_in = 1'b0; // C_OUT= 1, SUM= 00000000
		#5 A_in = 8'd3; B_in = 8'd4; C_in = 1'b0; // C_OUT= 0, SUM= 00000111
		#5 A_in = 8'd6; B_in = 8'd9; C_in = 1'b0; // C_OUT= 0, SUM= 00001111
		#5 A_in = 8'd5; B_in = 8'd5; C_in = 1'b0; // C_OUT= 0, SUM= 00001010
		#5 A_in = 8'd6; B_in = 8'd1; C_in = 1'b0; // C_OUT= 0, SUM= 00000111
		#5 A_in = 8'd6; B_in = 8'd2; C_in = 1'b0; // C_OUT= 0, SUM= 00001000
		#5 A_in = 8'd6; B_in = 8'd3; C_in = 1'b0; // C_OUT= 0, SUM= 00001001
		#5 A_in = 8'd6; B_in = 8'd4; C_in = 1'b0; // C_OUT= 0, SUM= 00001010
		#5 A_in = 8'd6; B_in = 8'd5; C_in = 1'b0; // C_OUT= 0, SUM= 00001011
		#5 A_in = 8'd6; B_in = 8'd6; C_in = 1'b0; // C_OUT= 0, SUM= 00001100
		#5 A_in = 8'd6; B_in = 8'd7; C_in = 1'b0; // C_OUT= 0, SUM= 00001101
		#5 A_in = 8'd6; B_in = 8'd8; C_in = 1'b0; // C_OUT= 0, SUM= 00001110
		#5 A_in = 8'd6; B_in = 8'd10; C_in = 1'b0; // C_OUT= 1, SUM= 00000000
		#5 A_in = 8'd3; B_in = 8'd3; C_in = 1'b0; // C_OUT= 0, SUM= 00000110
		#5 $finish;

	end
      
endmodule

