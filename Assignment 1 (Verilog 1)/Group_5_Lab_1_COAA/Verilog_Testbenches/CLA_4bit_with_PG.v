`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:33:27 08/26/2021
// Design Name:   CLA_4bit_PG
// Module Name:   D:/COAA/assignment1_testing/CLA_4bit_with_PG.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLA_4bit_PG
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CLA_4bit_with_PG;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg C0;

	// Outputs
	wire [3:0] sum;
	wire P;
	wire G;

	// Instantiate the Unit Under Test (UUT)
	CLA_4bit_PG uut (
		.sum(sum), 
		.P(P), 
		.G(G), 
		.A(A), 
		.B(B), 
		.C0(C0)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor($time," A= %b, B=%b, C_IN= %b, --- P= %b, G = %b, SUM= %b\n",A, B, C0, P, G, sum);
		#5 A = 4'd0; B = 4'd0; C0 = 1'b0; // P= 0, G = 0, SUM= 0000
		#5 A = 4'd7; B = 4'd9; C0 = 1'b0; // P= 0, G = 1, SUM= 0000 
		#5 A = 4'd3; B = 4'd4; C0 = 1'b0; // P= 0, G = 0, SUM= 0111
		#5 A = 4'd6; B = 4'd9; C0 = 1'b0; // P= 1, G = 0, SUM= 1111
		#5 A = 4'd5; B = 4'd5; C0 = 1'b0; // P= 0, G = 0, SUM= 1010
		#5 A = 4'd6; B = 4'd1; C0 = 1'b0; // P= 0, G = 0, SUM= 0111
		#5 A = 4'd6; B = 4'd2; C0 = 1'b0; // P= 0, G = 0, SUM= 1000
		#5 A = 4'd6; B = 4'd3; C0 = 1'b0; // P= 0, G = 0, SUM= 1001
		#5 A = 4'd6; B = 4'd4; C0 = 1'b0; // P= 0, G = 0, SUM= 1010
		#5 A = 4'd6; B = 4'd5; C0 = 1'b0; // P= 0, G = 0, SUM= 1011
		#5 A = 4'd6; B = 4'd6; C0 = 1'b0; // P= 0, G = 0, SUM= 1100
		#5 A = 4'd6; B = 4'd7; C0 = 1'b0; // P= 0, G = 0, SUM= 1101
		#5 A = 4'd6; B = 4'd8; C0 = 1'b0; // P= 0, G = 0, SUM= 1110
		#5 A = 4'd6; B = 4'd10; C0 = 1'b0; // P= 0, G = 1, SUM= 0000
		#5 A = 4'd3; B = 4'd3; C0 = 1'b0; // P= 0, G = 0, SUM= 0110
		#5 $finish;

	end
      
endmodule

