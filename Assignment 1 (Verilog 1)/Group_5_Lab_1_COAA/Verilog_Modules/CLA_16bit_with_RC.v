`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:29 08/26/2021 
// Design Name: 
// Module Name:    CLA_16bit_with_RC 
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
module CLA_16bit_with_RC(sum , C_out , A , B, C0);
	input [15:0] A, B;
	input C0;
	output [15:0] sum;
	output C_out;
	
	wire C1, C2, C3;
	// Used 4 ClA_4bit to add a 16 bit number
	CLA_4bit cla1(.sum(sum[3:0]) , .C_out(C1) , .A(A[3:0]) , .B(B[3:0]) , .C0(C0)); // this will add first 4 bits of the numbers
	CLA_4bit cla2(.sum(sum[7:4]) , .C_out(C2) , .A(A[7:4]) , .B(B[7:4]) , .C0(C1)); // this will add next 4 bits of the numbers
	CLA_4bit cla3(.sum(sum[11:8]) , .C_out(C3) , .A(A[11:8]) , .B(B[11:8]) , .C0(C2)); // this will add next 4 bits of the numbers
	CLA_4bit cla4(.sum(sum[15:12]) , .C_out(C_out) , .A(A[15:12]) , .B(B[15:12]) , .C0(C3)); // this will add final 4 bits of the numbers


endmodule
