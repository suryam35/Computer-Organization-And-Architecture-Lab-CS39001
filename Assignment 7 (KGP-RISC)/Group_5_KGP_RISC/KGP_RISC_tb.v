`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:08:20 10/31/2021
// Design Name:   KGP_RISC
// Module Name:   D:/COAA/KGP_RISC/KGP_RISC_tb.v
// Project Name:  KGP_RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: KGP_RISC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module KGP_RISC_tb;

	// Inputs
	reg clk;
	reg rst;

	wire [31:0] instruction , aluresult, pc, new_pc;

	// Instantiate the Unit Under Test (UUT)
	KGP_RISC uut (
		.new_pc(new_pc),
		.pc(pc),
		.clk(clk), 
		.rst(rst), 
		.instruction(instruction), 
		.aluresult(aluresult)
	);
	initial begin
		// Initialize Inputs
		clk = 1;
		rst = 1;

		$monitor($time, "  instruction = %b aluresult = %b new_pc = %b pc = %b" , instruction, aluresult, new_pc, pc); 
		// Wait 100 ns for global reset to finish
		#10; rst = 0;
        
		// Add stimulus her
		#50000 $finish;
	end
	
	always #40 clk = ~clk;
      
endmodule

