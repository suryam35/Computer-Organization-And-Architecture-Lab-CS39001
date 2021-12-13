`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:45 08/26/2021 
// Design Name: 
// Module Name:    RCA_16bit 
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
module RCA_16bit(sum , C_out, A_in , B_in , C_in);
	output [15:0] sum;
	output C_out;
	input [15:0] A_in , B_in;
	input C_in;
	wire c1;
	// Used two 8 RCA_8bit to add the 16 bits numbers
	RCA_8bit ra0(.sum(sum[7:0]), .C_out(c1), .A_in(A_in[7:0]), .B_in(B_in[7:0]), .C_in(C_in)); // this will add the first 8 bits of the numbers
	RCA_8bit ra1(.sum(sum[15:8]), .C_out(C_out), .A_in(A_in[15:8]), .B_in(B_in[15:8]), .C_in(c1)); // this will add the next 8 bits of the numbers

endmodule

