`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:03 08/26/2021 
// Design Name: 
// Module Name:    RCA_8bit 
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

module RCA_8bit(sum , C_out, A_in , B_in , C_in);
	output [7:0] sum;
	output C_out;
	input [7:0] A_in , B_in;
	input C_in;
	wire c1 , c2 , c3 , c4 , c5 , c6 , c7;
	// Used 8 FullAdders to add 8 bit numbers 
	FullAdder fa0(.s(sum[0]) , .c(c1) , .a(A_in[0]) , .b(B_in[0]) , .c0(C_in)); // this will add the Least significant bits of the numbers
	FullAdder fa1(.s(sum[1]) , .c(c2) , .a(A_in[1]) , .b(B_in[1]) , .c0(c1)); // this will add the next 1 bit of the numbers
	FullAdder fa2(.s(sum[2]) , .c(c3) , .a(A_in[2]) , .b(B_in[2]) , .c0(c2)); // this will add the next 1 bit of the numbers
	FullAdder fa3(.s(sum[3]) , .c(c4) , .a(A_in[3]) , .b(B_in[3]) , .c0(c3)); // this will add the next 1 bit of the numbers
	FullAdder fa4(.s(sum[4]) , .c(c5) , .a(A_in[4]) , .b(B_in[4]) , .c0(c4)); // this will add the next 1 bit of the numbers
	FullAdder fa5(.s(sum[5]) , .c(c6) , .a(A_in[5]) , .b(B_in[5]) , .c0(c5)); // this will add the next 1 bit of the numbers
	FullAdder fa6(.s(sum[6]) , .c(c7) , .a(A_in[6]) , .b(B_in[6]) , .c0(c6)); // this will add the next 1 bit of the numbers
	FullAdder fa7(.s(sum[7]) , .c(C_out) , .a(A_in[7]) , .b(B_in[7]) , .c0(c7)); // // this will add the Most significant bits of the numbers

endmodule
