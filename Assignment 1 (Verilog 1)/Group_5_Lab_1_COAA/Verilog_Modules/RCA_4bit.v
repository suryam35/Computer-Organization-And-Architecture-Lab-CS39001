`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:24 08/26/2021 
// Design Name: 
// Module Name:    RCA_4bit 
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
module RCA_4bit(sum , C_out, A_in , B_in , C_in);
	output [3:0] sum;
	output C_out;
	input [3:0] A_in , B_in;
	input C_in;
	wire c1 , c2 , c3;
	// Used 4 FullAdder to add two 4 bit numnbers
	FullAdder fa0(.s(sum[0]) , .c(c1) , .a(A_in[0]) , .b(B_in[0]) , .c0(C_in)); // this will add the Least Significant bits of the two numbers
	FullAdder fa1(.s(sum[1]) , .c(c2) , .a(A_in[1]) , .b(B_in[1]) , .c0(c1)); // this will add the next 1 bits of the two numbers
	FullAdder fa2(.s(sum[2]) , .c(c3) , .a(A_in[2]) , .b(B_in[2]) , .c0(c2)); // this will add the next 1 bits of the two numbers
	FullAdder fa3(.s(sum[3]) , .c(C_out) , .a(A_in[3]) , .b(B_in[3]) , .c0(c3)); // this will add the Most Significant bits of the two numbers

endmodule

