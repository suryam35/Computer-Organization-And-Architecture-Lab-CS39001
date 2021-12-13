`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:19:18 08/26/2021 
// Design Name: 
// Module Name:    RCA_32bit 
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
module RCA_32bit(sum , C_out, A_in , B_in , C_in);
	output [31:0] sum;
	output C_out;
	input [31:0] A_in , B_in;
	input C_in;
	wire c1;
	// used two 16 bit numbers to add a 32 bit number
	RCA_16bit ra0(.sum(sum[15:0]), .C_out(c1), .A_in(A_in[15:0]), .B_in(B_in[15:0]), .C_in(C_in)); // this will add the first 16 bits of the numbers
	RCA_16bit ra1(.sum(sum[31:16]), .C_out(C_out), .A_in(A_in[31:16]), .B_in(B_in[31:16]), .C_in(c1)); // this will add the next 16 bits of the numbers

endmodule
