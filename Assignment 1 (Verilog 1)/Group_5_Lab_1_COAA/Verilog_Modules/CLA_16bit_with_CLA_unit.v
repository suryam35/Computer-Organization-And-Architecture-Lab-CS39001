`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:37:55 08/26/2021 
// Design Name: 
// Module Name:    CLA_16bit_with_CLA_unit 
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
module CLA_16bit_with_CLA_unit(sum , C_out , P3_0, G3_0 , A , B, C0);
	input [15:0] A, B;
	input C0;
	output [15:0] sum;
	output C_out, P3_0, G3_0;
	
	wire C1, C2, C3, P0, G0, P1, G1, P2, G2, P3, G3;
	
	CLA_4bit_PG cla1(.sum(sum[3:0]) , .P(P0) , .G(G0) , .A(A[3:0]) , .B(B[3:0]) , .C0(C0));
	// C1 = G0 + P0C0
	wire f1;
	and t1(f1, P0, C0); // f1 = P0C0
	or t2(C1, f1, G0); // C1 = G0 + P0C0
	
	CLA_4bit_PG cla2(.sum(sum[7:4]) , .P(P1) , .G(G1) , .A(A[7:4]) , .B(B[7:4]) , .C0(C1));
	// C2 = G1 + P1G0 + P1P0C0
	wire f2, f3, f4, f5;
	and t3(f2, P0, C0); // f2 = P0C0
	and t4(f3, f2, P1); // f3 = P1P0C0
	and t5(f4, P1, G0); // f4 = P1G0
	or t6(f5, f4, f3);  // f5 = P1G0 + P1P0C0
	or t7(C2, f5, G1); // C2 = G1 + P1G0 + P1P0C0

	
	CLA_4bit_PG cla3(.sum(sum[11:8]) , .P(P2) , .G(G2) , .A(A[11:8]) , .B(B[11:8]) , .C0(C2));
	// C3 = G2 + P2G1 + P2P1G0 + P2P1P0C0
	wire f6, f7, f8, f9, f10;
	and t8(f6, f3, P2); // f6 = P2P1P0C0
	and t9(f7, P2, f4); // f7 = P2P1G0
	and t10(f8, P2, G1); //f8 = P2G1
	or t11(f9, f6, f7); // f9 = P2P1P0C0 + P2P1G0
	or t12(f10, f9, f8); // f10 = P2P1P0C0 + P2P1G0 + P2G1
	or t13(C3, f10, G2); // C3 = G2 + P2G1 + P2P1G0 + P2P1P0C0
	
	
	CLA_4bit_PG cla4(.sum(sum[15:12]) , .P(P3) , .G(G3) , .A(A[15:12]) , .B(B[15:12]) , .C0(C3));
	// C_out = G3 + P3G2 + P3P2G1+ P3P2P1G0 + P3P2P1P0C0
	wire f11, f12, f13, f14, f15, f16, f17;
	
	and t14(f11, f6, P3); // f11 = P3P2P1P0C0
	and t15(f12, f7, P3); // f12 = P3P2P1G0
	and t16(f13, f8, P3); // f13 = P3P2G1
	and t17(f14, P3, G2); // f14 = P3G2
	or t18(f15, f11, f12); // f15 = P3P2P1P0C0 + P3P2P1G0
	or t19(f16, f15, f13); // f16 = P3P2P1P0C0 + P3P2P1G0 + P3P2G1 
	or t20(f17, f16, f14); // f17 = P3P2P1P0C0 + P3P2P1G0 + P3P2G1 + P3G2
	or t21(C_out, f17, G3); // C_out = G3 + P3G2 + P3P2G1+ P3P2P1G0 + P3P2P1P0C0
	
	wire f18, f19, f20;
	
	and t22(f18, P0, P1); // f18 = P0P1
	and t23(f19, f18, P2); // f19 = P0P1P2
	and t24(P3_0, f19, P3); // P3_0 = P0P1P2P3
	
	// G3_0 = G3 + P3G2 + P3P2G1 + P3P2P1G0
	wire f21, f22, f23;
	
	or t25(f21, f12, f13); // f21 = P3P2P1G0 + P3P2G1
	or t26(f22, f21, f14); // f22 = P3P2P1G0 + P3P2G1 + P3G2
	or t27(G3_0, f22, G3); // G3_0 = P3P2P1G0 + P3P2G1 + P3G2 + G3
	

endmodule
