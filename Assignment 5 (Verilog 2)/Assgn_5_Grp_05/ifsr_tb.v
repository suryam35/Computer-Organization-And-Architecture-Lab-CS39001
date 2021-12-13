`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:19:18 09/27/2021
// Design Name:   lfsr
// Module Name:   D:/COAA/assignment_5_coaa_lab/ifsr_tb.v
// Project Name:  assignment_5_coaa_lab
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lfsr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 5
// Problem number - 1 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module lfsr_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] seed;
	reg sel;

	// Outputs
	wire [3:0] w;

	// Instantiate the Unit Under Test (UUT)
	lfsr uut (
		.clk(clk), 
		.rst(rst), 
		.seed(seed), 
		.sel(sel), 
		.w(w)
	);

	initial begin
		// Initialize Inputs
		// starting with clock = 0
		// Initializing the seed as 1111
		clk = 0;
		rst = 1;
		seed = 4'b1111;
		sel = 1;
		
		#1 rst = 0;
		#1 sel = 0;
		// this is to monitor the output after every shift
		$monitor($time, "  w = %b\n",w);
      // finish monitoring output after 150 seconds
		#150 $finish;

	end
	// changing the clock every 5 second
	always #5 clk = ~clk;
      
endmodule

