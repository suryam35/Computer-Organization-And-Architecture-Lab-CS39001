`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:24:30 08/26/2021
// Design Name:   FullAdder
// Module Name:   D:/COAA/assignment1_testing/Full_Adder_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FullAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Full_Adder_Test;

	// Inputs
	reg a;
	reg b;
	reg c0;

	// Outputs
	wire s;
	wire c;

	// Instantiate the Unit Under Test (UUT)
	FullAdder uut (
		.s(s), 
		.c(c), 
		.a(a), 
		.b(b), 
		.c0(c0)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		c0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("a=%d b=%d,c0=%d,s=%d,c=%d \n",a,b,c0,s,c);
		#1 a = 0; b = 0; c0 = 0; // s=0,c=0 
		#1 a = 1; b = 0; c0 = 0; // s=1,c=0 
		#1 a = 1; b = 1; c0 = 0; // s=0,c=1 
		#1 a = 0; b = 1; c0 = 0; // s=1,c=0 
		#1 a = 0; b = 0; c0 = 1; // s=1,c=0 
		#1 a = 1; b = 0; c0 = 1; // s=0,c=1 
		#1 a = 1; b = 1; c0 = 1; // s=1,c=1 
		#1 a = 0; b = 1; c0 = 1; // s=0,c=1 
		#1 $finish;

	end
      
endmodule

