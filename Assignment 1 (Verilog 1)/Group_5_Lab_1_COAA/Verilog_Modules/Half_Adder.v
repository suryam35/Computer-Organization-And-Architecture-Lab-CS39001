`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:34 08/26/2021 
// Design Name: 
// Module Name:    Half_Adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HalfAdder(s , c, a , b);
	input a , b;
	output s , c;
	// Sum = a^b
	// Carry-out = a&b
	xor g1(s , a , b);
	and g2(c , a , b);

endmodule