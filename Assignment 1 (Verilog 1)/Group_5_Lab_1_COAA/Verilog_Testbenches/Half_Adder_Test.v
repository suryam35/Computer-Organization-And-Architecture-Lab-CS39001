`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:23:17 08/26/2021
// Design Name:   HalfAdder
// Module Name:   D:/COAA/assignment1_testing/Half_Adder_Test.v
// Project Name:  assignment1_testing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HalfAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Half_Adder_Test;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire s;
	wire c;

	// Instantiate the Unit Under Test (UUT)
	HalfAdder uut (
		.s(s), 
		.c(c), 
		.a(a), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("a=%d b=%d,s=%d,c=%d \n",a,b,s,c);
		#1 a = 0; b = 0; // s=0,c=0 
		#1 a = 1; b = 0; // s=1,c=0 
		#1 a = 1; b = 1; // s=0,c=1 
		#1 a = 0; b = 1; // s=1,c=0 
		#1 $finish;

	end
      
endmodule

