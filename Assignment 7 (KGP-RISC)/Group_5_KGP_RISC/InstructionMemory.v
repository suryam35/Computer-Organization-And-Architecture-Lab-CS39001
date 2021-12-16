`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:53 10/30/2021 
// Design Name: 
// Module Name:    InstructionMemory 
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
module InstructionMemory(clk, rst, pc, dout);
	input clk, rst; // clock and reset input signals
	input [31:0] pc; // 32 bit value of the program counter
	output reg[31:0] dout; // on the basis of the program counter, output instruction for computation
	
	reg[31:0] IMem[0:31]; // instruction memory can store 32 instruction of 32 bit size
	
	
	
	always @(posedge rst) begin
		if(rst) begin
			//IMem[0] = 32'b00001100000000010000000000000000;   // lw r1 = 15
			//IMem[1] = 32'b00001100000000100000000000000001;   // lw r2 = 10
			//IMem[2] = 32'b00001000011000000000000000001010;   // r3 = compi 10 = -10
			//IMem[3] = 32'b00000000001000110000000000000000;   // r1 = add r1 , r3 = 5
			//IMem[4] = 32'b00000000010000110000000000000000;   // r2 = add r2 , r3 = 0
			//IMem[5] = 32'b00010000000000010000000000000011;   // sw r1 DMem[3]
			
			IMem[0] =  32'b00001100000000000000000000000000;   // lw r0 = 0
			IMem[1] =  32'b00001100000000010000000000000001;  // lw r1 
			IMem[2] =  32'b00001100000000100000000000000010;   // lw r2
			IMem[3] =  32'b00100000001000000000000000010001;   // bz r1 exit1
			IMem[4] =  32'b00100000010000000000000000010011;   // bz r2 exit2
			IMem[5] =  32'b00000000011000100000000000000001;   // comp r3, r2
			IMem[6] =  32'b00001100000001000000000000000000;   // lw r4 = 0
			IMem[7] =  32'b00000000100000010000000000000000;   // add r4, r1
			IMem[8] =  32'b00000000100000110000000000000000;   // add r4, r3 // add r4,r3,r1
			IMem[9] =  32'b00011100100000000000000000001011;   // bltz r4, L1 = 11
			IMem[10] = 32'b00010100000000000000000000001110;   // b L2 = 14
			IMem[11] = 32'b00000000101000010000000000000001;   // comp r5, r1 
			IMem[12] = 32'b00000000010001010000000000000000;  // add r2, r5
			IMem[13] = 32'b00010100000000000000000000000011;
			IMem[14] = 32'b00000000101000100000000000000001;   // comp r5, r2 
			IMem[15] = 32'b00000000001001010000000000000000;   // add r1, r5
			IMem[16] = 32'b00010100000000000000000000000011;   // b loop
			IMem[17] = 32'b00010000000000100000000000000011;   // sw r2
			IMem[18] = 32'b00010100000000000000000000010100;   // b 20
			IMem[19] = 32'b00010000000000010000000000000011;   // sw r1

			//dout = IMem[0];
		end
		//else begin
			//dout = IMem[pc];
		//end
	end
	
	always @(pc) begin
		// here we set the ouput instruction according to the input program control
		dout = IMem[pc];
	end
endmodule
