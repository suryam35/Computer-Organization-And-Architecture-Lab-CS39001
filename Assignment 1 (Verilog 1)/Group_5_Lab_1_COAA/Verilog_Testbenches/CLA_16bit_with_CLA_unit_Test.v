`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:35:46 08/26/2021
// Design Name:   CLA_16bit_with_CLA_unit
// Module Name:   D:/COAA/assignment1_testing/CLA_16bit_with_CLA_unit_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLA_16bit_with_CLA_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CLA_16bit_with_CLA_unit_Test;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg C0;

	// Outputs
	wire [15:0] sum;
	wire C_out;
	wire P3_0;
	wire G3_0;

	// Instantiate the Unit Under Test (UUT)
	CLA_16bit_with_CLA_unit uut (
		.sum(sum), 
		.C_out(C_out), 
		.P3_0(P3_0), 
		.G3_0(G3_0), 
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
		$monitor($time," A= %b, B=%b, C_IN= %b, --- P3_0= %b, G3_0 = %b, C_out = %b, SUM= %b\n",A, B, C0, P3_0, G3_0, C_out, sum);
		#5 A = 16'd0; B = 16'd0; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0000000000000000
		#5 A = 16'd40000; B = 16'd900; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 1001111111000100
		#5 A = 16'd25937; B = 16'd50000; C0 = 1'b0; // P3_0= 0, G3_0 = 1, C_out = 1, SUM= 0010100010100001
		#5 A = 16'd7878; B = 16'd12345; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0100111011111111
		#5 A = 16'd65536; B = 16'd65536; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0000000000000000
		#5 A = 16'd9936; B = 16'd99; C0 = 1'b0; //  P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0010011100110011
		#5 A = 16'd996; B = 16'd999; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0000011111001011
		#5 A = 16'd1036; B = 16'd100; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0000010001110000
		#5 A = 16'd96; B = 16'd9900; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 0010011100001100
		#5 A = 16'd50000; B = 16'd2100; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 1100101110000100
		#5 A = 16'd2200; B = 16'd50000; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 1100101111101000
		#5 A = 16'd50000; B = 16'd2900; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 1100111010100100
		#5 A = 16'd2300; B = 16'd50000; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 1100110001001100
		#5 A = 16'd50000; B = 16'd2500; C0 = 1'b0; // P3_0= 0, G3_0 = 0, C_out = 0, SUM= 1100110100010100
		#5 A = 16'd25938; B = 16'd50000; C0 = 1'b0; // P3_0= 0, G3_0 = 1, C_out = 1, SUM= 0010100010100010
		#5 $finish;

	end
      
endmodule

