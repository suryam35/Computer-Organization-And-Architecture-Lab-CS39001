`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:26 10/09/2021 
// Design Name: 
// Module Name:    barrel_shifter 
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

// Assignment number - 6
// Problem number - 1 (source file)
// Semester - 5 (Aut 2021)
// Group number - 5
// Group Member 1 - Suryam Arnav Kalra (19CS30050)
// Group Member 2 - Kunal Singh (19CS30025)

// The below module is 2:1 mux
module mux(a, b, sel, z);
	input a,b, sel;
	output z;
	assign z = sel ? a : b;
endmodule

module barrel_shifter(in, shamt, dir, out);
	input [7:0] in; // This is the input 8 bit number
	input [2:0] shamt; // This the given shift amount
	input dir; // This is the direction provided for shifting (1 -> left shift, 0 -> right shift)
	output [7:0] out; // output is stored in this
	
	// These are the wires used to build the design
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, w32;
	
	// The 8 muxes used below are used to pass the bits accroding to the direction given in input in which we want to shift the bits
	// We perform right shift only but pass the bits in the input accordingly if we want to perform left shift operation
	
	mux m1(in[0] , in[7] , dir, w1);
	mux m2(in[1] , in[6] , dir, w2);
	mux m3(in[2] , in[5] , dir, w3);
	mux m4(in[3] , in[4] , dir, w4);
	mux m5(in[4] , in[3] , dir, w5);
	mux m6(in[5] , in[2] , dir, w6);
	mux m7(in[6] , in[1] , dir, w7);
	mux m8(in[7] , in[0] , dir, w8);
	
	// The below 8 muxes are used to perform 4 bit right shifting
	mux m9(0 , w1 , shamt[2], w9);
	mux m10(0 , w2 , shamt[2], w10);
	mux m11(0 , w3 , shamt[2], w11);
	mux m12(0 , w4 , shamt[2], w12);
	mux m13(w1 , w5 , shamt[2], w13);
	mux m14(w2 , w6 , shamt[2], w14);
	mux m15(w3 , w7 , shamt[2], w15);
	mux m16(w4 , w8 , shamt[2], w16);
	
	// The below 8 muxes are used to perform 2 bit right shifting
	mux m17(0 , w9 , shamt[1], w17);
	mux m18(0 , w10 , shamt[1], w18);
	mux m19(w9 , w11 , shamt[1], w19);
	mux m20(w10 , w12 , shamt[1], w20);
	mux m21(w11 , w13 , shamt[1], w21);
	mux m22(w12 , w14 , shamt[1], w22);
	mux m23(w13 , w15 , shamt[1], w23);
	mux m24(w14 , w16 , shamt[1], w24);
	
	// The below 8 muxes are used to perform 1 bit right shifting
	mux m25(0 , w17 , shamt[0], w25);
	mux m26(w17 , w18 , shamt[0], w26);
	mux m27(w18 , w19 , shamt[0], w27);
	mux m28(w19 , w20 , shamt[0], w28);
	mux m29(w20 , w21 , shamt[0], w29);
	mux m30(w21 , w22 , shamt[0], w30);
	mux m31(w22 , w23 , shamt[0], w31);
	mux m32(w23 , w24 , shamt[0], w32);
	
	// The below 8 muxes are used to give output according to the direction of shift required 
	// If right shift was required we just give the ouput as same provided after the shift operation
	// If left shift was required we do some operation and place the bits accordingly to give correct ouput
	mux m33(w32 , w25 , dir, out[7]);
	mux m34(w31 , w26 , dir, out[6]);
	mux m35(w30 , w27 , dir, out[5]);
	mux m36(w29 , w28 , dir, out[4]);
	mux m37(w28 , w29 , dir, out[3]);
	mux m38(w27 , w30 , dir, out[2]);
	mux m39(w26 , w31 , dir, out[1]);
	mux m40(w25 , w32 , dir, out[0]);
endmodule

