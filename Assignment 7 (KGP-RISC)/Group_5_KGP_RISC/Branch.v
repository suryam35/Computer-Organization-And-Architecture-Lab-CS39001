`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:53 10/30/2021 
// Design Name: 
// Module Name:    Branch 
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
module Branch(branchop, carry, zero, lessthanzero, do_branch);
	input [5:0] branchop; // 6 bit branchop
	input carry, zero, lessthanzero; // input signals from control unit
	output reg do_branch; // output if branching should be done then equals to 1 otherwise 0
	
	always @(*) begin
		case(branchop) 
			// if the branchop is 000001 then the instruction is branch at carry
			6'b000001 : begin // bcy L
				do_branch = carry;
			end
			// if the branchop is 000010 then the instruction is branch at no carry
			6'b000010 : begin // bncy L
				do_branch = (carry == 1) ? 0 : 1;
			end
			// if the branchop is 000011 then the instruction is branch if value at register is equal to zero
			6'b000011 : begin // bz rs L
				do_branch = zero;
			end
			// if the branchop is 000100 then the instruction is branch if value at register is not equal to zero
			6'b000100 : begin // bnz rs L
				do_branch = (zero == 1) ? 0 : 1;
			end
			// if the branchop is 000101 then the instruction is branch if value at register is less than zero
			6'b000101 : begin // bltz rs L
				do_branch = (lessthanzero == 1) ? 1 : 0;
			end
			// if the branchop is 000110 then the instruction is unconditional branch 
			6'b000110 : begin // b L and br rs and bl L
				do_branch = 1;
			end
			default: begin
				do_branch = 0;
			end
		endcase
	end

endmodule
