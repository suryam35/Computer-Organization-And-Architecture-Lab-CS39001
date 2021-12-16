`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:25:26 11/12/2021
// Design Name:   bin_fact
// Module Name:   D:/COAA/classtest2/bin_fact_tb.v
// Project Name:  classtest2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bin_fact
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Name : Suryam Arnav Kalra
// Roll No.: 19CS30050

module bin_fact_tb;

	// Inputs
	reg clk;
	reg start;
	reg [6:0] a;
	reg [6:0] b;

	// Outputs
	wire done;
	wire [12:0] product;
	//wire [13:0] p_;

	// Instantiate the Unit Under Test (UUT)
	bin_fact uut (
		.clk(clk), 
		.start(start), 
		.a(a), 
		.b(b), 
		.done(done), 
		.product(product)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		start = 1;
		
		// since the numbers have to be 6-bit only, let the rightmost bit of the numbers remain 0 (7th bit)
		
		a = 7'b1100100;   // a = 0.1100100 = 0.78125
		b = 7'b1101010;   // b = 0.1101010 = 0.828125
		// product = a*b = 0.1010010110100 = 0.64697265625
		$monitor ($time, " clk =%b,  done = %b , product = %b \n", clk, done, product);
		// Wait 100 ns for global reset to finish
		#2 start = 0;
		#80 $finish;
		// Add stimulus here

	end
	always #5 clk = ~clk;
      
endmodule

