`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:43:41 09/27/2021
// Design Name:   modulo_3
// Module Name:   D:/COAA/assignment_5_coaa_lab/modulo_3_tb.v
// Project Name:  assignment_5_coaa_lab
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: modulo_3
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 5
// Problem number - 3 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module modulo_3_tb;

	// Inputs
	reg x;
	reg clk;
	reg rst;

	// Outputs
	wire z;
	
	

	// Instantiate the Unit Under Test (UUT)
	modulo_3 uut (
		.x(x), 
		.clk(clk), 
		.rst(rst), 
		.z(z)
	);
	

	initial begin
		// this is to monitor the output after every bit input
		$monitor($time, "  x= %b --- z= %b\n",x, z);
		// starting the clock from 1 
		clk = 1;
		rst = 1;
		//x = 0;
		#1 rst = 0;
		// input of number starts here
		// we first give the input after 5 secs and then after each 10 secs
		// this will avoid the race condition and outputs will be correct according to the input
		#4 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 x = 1;
		#10 x = 1;
		#10 $finish;
	
		// Add stimulus here
		
	end
	// changing the clock every 5 second
	always #5 clk = ~clk;
      
endmodule

