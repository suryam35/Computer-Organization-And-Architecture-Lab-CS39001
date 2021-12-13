`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:58:10 10/09/2021
// Design Name:   bit_serial_adder
// Module Name:   D:/COAA/assignment_6/bit_serial_adder_tb.v
// Project Name:  assignment_6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bit_serial_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 6
// Problem number - 2 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module bit_serial_adder_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg Cin;
	reg clk;
	reg input_signal;
	reg rst;

	// Outputs
	wire [7:0] S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	bit_serial_adder uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.S(S), 
		.C_(Cout),
		.clk(clk), 
		.input_signal(input_signal), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		A = 8'b00000110; // Input number 1
		B = 8'b00001110; // Input number 2
		Cin = 0; // Carry in
		// The expected output is Sum = 00010100, C_out = 0
		clk = 1;
		input_signal = 1;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#1 rst = 0; input_signal = 0;
		$monitor($time, "   A = %b , B = %b, C_in = %b, Sum = %b, C_out = %b\n" , A, B, Cin, S, Cout);
      #80 $finish;
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

