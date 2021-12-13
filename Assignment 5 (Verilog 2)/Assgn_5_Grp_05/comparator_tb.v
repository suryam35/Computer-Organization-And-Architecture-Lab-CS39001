`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:36:31 09/27/2021
// Design Name:   comparator
// Module Name:   D:/COAA/assignment_5_coaa_lab/comparator_tb.v
// Project Name:  assignment_5_coaa_lab
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 5
// Problem number - 4 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module comparator_tb;

	// Inputs
	reg clk;
	reg rst;
	reg input_signal;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire L;
	wire E;
	wire G;
	wire OP;

	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.clk(clk), 
		.rst(rst),
		.input_signal(input_signal),
		.A(A), 
		.B(B), 
		.L(L), 
		.E(E), 
		.G(G),
		.OP(OP)
	);

	initial begin
		// Initialize Inputs
		// Setting the clock = 0 at start
		clk = 0;
		rst = 1;
		input_signal = 1;
		// Giving the 32 bit numbers
		A = 32'b11001010100010001010100010001000;
		B = 32'b10101000100010101000100010001000;
		
		#1 rst = 0;
		#1 input_signal = 0;
		// This is to monitor the output whenever it will change so we will see the output only at the start and end of the process
		// L = 1 , E = 0, G = 0, denotes A < B
		// L = 0 , E = 1, G = 0, denotes A = B
		// L = 0 , E = 0, G = 1, denotes A > B
		$monitor($time, "  L= %b, E = %b , G = %b, OP = %b\n",L , E , G, OP);
		#330 $finish;

	end
	// changing the clock every 5 second
	always #5 clk = ~clk;
	
      
endmodule

