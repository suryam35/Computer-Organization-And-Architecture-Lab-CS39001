`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:34:22 10/30/2021 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(clk, rst, read_reg1, read_reg2, write_reg, write_data, reg_write, data_reg1, data_reg2);
	input clk, rst, reg_write;
	input [4:0] read_reg1, read_reg2, write_reg;
	input [31:0] write_data;
	output reg[31:0] data_reg1, data_reg2;
	
	always @(read_reg1, read_reg2) begin
		// at the input read the value of registers from register file
		data_reg1 <= RF[read_reg1];
		data_reg2 <= RF[read_reg2];
	end
	
	reg [31:0] RF [31:0];
	integer i;
	always @(posedge rst, negedge clk) begin
		if(rst) begin
			for(i=0;i<32;i=i+1)
			// initiaize all the register values to 0
				RF[i] = 32'b00000000000000000000000000000000;
		end
		else if(reg_write) begin
			// if register write is enabled then we write the given data at the given position
			RF[write_reg] = write_data;
		end
	end


endmodule
