`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:46:03 10/09/2021
// Design Name:   booth
// Module Name:   D:/COAA/assignment_6/booth_tb.v
// Project Name:  assignment_6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: booth
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 6
// Problem number - 3 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module booth_tb;

	// Inputs
	reg [7:0] M;
	reg [7:0] Q;
	reg clk;
	reg rst;
	reg input_signal;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	booth uut (
		.M(M), 
		.Q(Q), 
		.out(out), 
		.clk(clk), 
		.rst(rst), 
		.input_signal(input_signal)
	);

	initial begin
		// Initialize Inputs
		M = 8'b01111111; // Multiplicand (2's complent form)
		Q = 8'b11111010; // Multiplier (2's complent form)
		// The correct output 1111110100000110 (2's complent form)
		clk = 1;
		rst = 1;
		input_signal = 1;

		// Wait 100 ns for global reset to finish
		#1 rst = 0; input_signal = 0;
		
		$monitor($time, "  M = %b , Q = %b, Output = %b\n", M, Q, out);
		#80 $finish;
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

