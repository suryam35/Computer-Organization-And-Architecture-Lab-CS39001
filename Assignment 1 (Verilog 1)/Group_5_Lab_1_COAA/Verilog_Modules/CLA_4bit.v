`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:12 08/26/2021 
// Design Name: 
// Module Name:    CLA_4bit 
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
module CLA_4bit(sum , C_out , A , B , C0);
	output [3:0] sum;
	output C_out;
	input [3:0] A , B;
	input C0;
	
	wire P0 , P1 , P2 , P3 , G0 , G1 , G2 , G3 , C1 , C2 , C3;

	xor p0(P0 , A[0] , B[0]); // p0 = A0^B0
	xor p1(P1 , A[1] , B[1]); // p1 = A1^B1
	xor p2(P2 , A[2] , B[2]); // p2 = A2^B2
	xor p3(P3 , A[3] , B[3]); // p3 = A3^B3
	
	and g0(G0 , A[0] , B[0]); // g0 = A0&B0
	and g1(G1 , A[1] , B[1]); // g1 = A1&B1
	and g2(G2 , A[2] , B[2]); // g2 = A2&B2
	and g3(G3 , A[3] , B[3]); // g3 = A3&B3
	
	// calculation of C1 = G0 + P0C0
	wire f1;
	and t1(f1 , P0 , C0); // f1 = P0C0
	or t2(C1 , G0 , f1); // C1 = G0 + P0C0
	
	// calculation of C2 = G1 + P1G0 + P1P0C0
	wire f2 , f3 , f4 , f5;
	and t3(f2 , P1 , G0);   // f2 = P1G0
	and t4(f3 , P1 , P0);   // f3 = P1P0
	and t5(f4 , f3 , C0);  // f4 = P1P0C0
	or t6(f5 , f2 , f4);   // f5 = P1G0 + P1P0C0
	or t7(C2 , G1 , f5); // C2 = G1 + P1G0 + P1P0C0
	
	// calculation of C3 = G2 + P2G1 + P2P1G0 + P2P1P0C0
	wire f6, f7, f8, f9, f10, f11, f12;
	and t8(f6 , P2 , G1);  // f6 = P2G1
	and t9(f7 , P2 , P1); // f7 = P2P1
	and t10(f8 , f7 , G0); // f8 = P2P1G0
	and t11(f9 , P0 , C0); // f9 = P0C0
	and t12(f10 , f7 , f9); // f10 = P2P1P0C0;
	or t13(f11 , G2 , f6); // f11 = P2G1 + G2
	or t14(f12 , f11 , f8); // f12 = P2G1 + G2 + P2P1G0
	or t15(C3 , f12 , f10); // C3 = G2 + P2G1 + P2P1G0 + P2P1P0C0
	
	// calculation of C4 , ie , C_out = G3 + P3G2 + P3P2G1+ P3P2P1G0 + P3P2P1P0C0
	wire f13 , f14 , f15 , f16 , f17 , f18 , f19 , f20 , f21 , f22;
	and t16(f13 , P3 , G2); // f13 = P3G2
	and t17(f14 , P3 , P2); // f14 = P3P2
	and t18(f15 , f14 , G1); // f15 = P3P2G1
	and t19(f16 , f14 , P1); // f16 = P3P2P1
	and t20(f17 , f16 , G0); // f17 = P3P2P1G0
	and t21(f18 , P0 , C0); // f18 = P0C0
	and t22(f19 , f18 , f16); // f19 = P3P2P1P0C0
	or t23(f20 , G3 , f13); // f20 = P3G2 + G3
	or t24(f21 , f20 , f15); // f21 = P3P2G1 + P3G2 + G3
	or t25(f22 , f21 , f17); // f22 = P3P2G1 + P3G2 + G3 + P3P2P1G0
	or t26(C_out , f22 , f19); // C_out = G3 + P3G2 + P3P2G1+ P3P2P1G0 + P3P2P1P0C0
	
	
	// sum[0] = P0^C0
	xor t27(sum[0] , P0 , C0);
	
	// sum[1] = P1^C1
	xor t28(sum[1] , P1 , C1);
	
	// sum[2] = P2^C2
	xor t29(sum[2] , P2 , C2);
	
	// sum[3] = P3^C3
	xor t30(sum[3] , P3 , C3);
	
endmodule