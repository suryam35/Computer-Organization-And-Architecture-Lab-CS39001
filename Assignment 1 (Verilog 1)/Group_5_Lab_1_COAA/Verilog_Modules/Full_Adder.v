`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:12:27 08/26/2021 
// Design Name: 
// Module Name:    Full_Adder 
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
module FullAdder(s , c ,a , b , c0);
	input a , b , c0;
	output s , c;
	wire f1 , f2 , f3;
	and g1(f1 , a , b);
	xor g2(f2 , a , b);
	and g3(f3 , f2 , c0);
	or g4(c , f1 , f3);
	xor g5(s , f2 , c0);
endmodule

