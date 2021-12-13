`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:53:34 10/09/2021
// Design Name:   barrel_shifter
// Module Name:   D:/COAA/assignment_6/barrel_shifter_tb.v
// Project Name:  assignment_6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: barrel_shifter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Assignment number - 6
// Problem number - 1 (test bench file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

module barrel_shifter_tb;

	// Inputs
	reg [7:0] in;
	reg [2:0] shamt;
	reg dir;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	barrel_shifter uut (
		.in(in), 
		.shamt(shamt), 
		.dir(dir), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		shamt = 0;
		dir = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("Input : %b , Output : %b , Dir (0 = right shift , 1 = left shift) : %b, Shift amount : %b\n" , in, out, dir, shamt);
		// These are the inputs (provided after every 5 secs) and the respective correct outputs 
		in = 8'b00101011; dir = 0; shamt = 3'b010; // Output : 00001010
		#5; in = 8'b00101011; dir = 1; shamt = 3'b010; // Output : 10101100
		#5; in = 8'b10111011; dir = 0; shamt = 3'b110; // Output : 00000010
		#5; in = 8'b01001011; dir = 1; shamt = 3'b011; // Output : 01011000
		#5; in = 8'b10111011; dir = 0; shamt = 3'b111; // Output : 00000001
		#5; in = 8'b00111111; dir = 1; shamt = 3'b000; // Output : 00111111
		#5; in = 8'b01111011; dir = 0; shamt = 3'b011; // Output : 00001111 
		#5; in = 8'b11111111; dir = 1; shamt = 3'b010; // Output : 11111100

	end
      
endmodule

