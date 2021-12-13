`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:19:56 08/26/2021 
// Design Name: 
// Module Name:    RCA_64bit 
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
module RCA_64bit(sum , C_out, A_in , B_in , C_in);
	output [63:0] sum;
	output C_out;
	input [63:0] A_in , B_in;
	input C_in;
	wire c1;
	// Used two RCA_32bit to add a 64 bit number
	RCA_32bit ra0(.sum(sum[31:0]), .C_out(c1), .A_in(A_in[31:0]), .B_in(B_in[31:0]), .C_in(C_in)); // this will first 8 bits of the nunbers
	RCA_32bit ra1(.sum(sum[63:32]), .C_out(C_out), .A_in(A_in[63:32]), .B_in(B_in[63:32]), .C_in(c1)); // this will add next 8 bits of the number

endmodule
