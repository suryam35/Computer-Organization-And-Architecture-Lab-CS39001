`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:10 10/30/2021 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory(clk, rst, address, datain, memwrite, memread, frommemory);
	input clk, rst; // clock and reset input signals
	input [31:0] address, datain; // address at the data is to be stored and the data that has to be stored
	input memwrite, memread; // input signals from the control unit
	output reg[31:0] frommemory; // the 32 bit output data that is read from the memory
	
	reg[31:0]	DMem[0:31];
	
	always @(*) begin
		if(rst) begin
			DMem[0] = 0;
			DMem[1] = 4;
			DMem[2] = 22;
			// gcd should be 2 and stored in DMem[3]
			if(memread) begin
			// if memory read is enabled then we read the data from the data memory
				frommemory = DMem[address];
			end
			if(memwrite) begin
			// if memory write is enabled then we write the data to the data memory
				DMem[address] = datain;
			end
			
		end
		else begin
			if(memread) begin
			// if memory read is enabled then we read the data from the data memory
				frommemory = DMem[address];
			end
			if(memwrite) begin
			// if memory write is enabled then we write the data to the data memory
				DMem[address] = datain;
			end
		end
	end

endmodule
