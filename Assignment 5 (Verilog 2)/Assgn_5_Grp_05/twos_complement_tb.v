`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:14:29 09/27/2021
// Design Name:   twos_complement
// Module Name:   D:/COAA/assignment_5_coaa_lab/twos_complement_tb.v
// Project Name:  assignment_5_coaa_lab
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: twos_complement
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 5
// Problem number - 2 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module twos_complement_tb;

	// Inputs
	reg x;
	reg clk;
	reg rst;

	// Outputs
	wire z;
	
	

	// Instantiate the Unit Under Test (UUT)
	twos_complement uut (
		.x(x), 
		.clk(clk), 
		.rst(rst), 
		.z(z)
	);
	
	

	initial begin
		// this is to monitor the output after every bit input
		$monitor($time, "  x= %b --- z= %b\n",x, z);
		// starting the clock from 0
		clk = 0;
		rst = 1;
		//x = 0;
		#1 rst = 0;
		// input of number starts here
		// we first give the input after 3 secs and then after each 10 secs this will create a slight delay in input with the posedge
		// this will avoid the race condition and outputs will be correct according to the input
		#2 x = 0;
		#10 x = 0;
		#10 x = 0;
		#10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 $finish;
		
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

