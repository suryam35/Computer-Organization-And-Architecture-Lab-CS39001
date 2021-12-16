`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:24 10/30/2021 
// Design Name: 
// Module Name:    KGP_RISC 
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
module KGP_RISC(new_pc, pc, clk, rst, instruction, aluresult);
	input clk, rst; // clock and reset input signals
	
	output wire [31:0] new_pc; // 32 bit program control value that is for next cycle of instruction
	output wire [31:0] pc; // 32 bit program control value that is for current cycle of instruction
	PC ProgramCounter(.clk(clk), .rst(rst), .new_pc(new_pc), .pc(pc)); // instantiating the program counter block , this will set the program counter value at each cycle of the processor
	
	output wire [31:0] instruction; // instruction for this cycle will be stored in this 
	InstructionMemory IM(.clk(clk), .rst(rst), .pc(pc), .dout(instruction)); // instruction memory will fetch the instruction based upon the program counter
	
	wire [4:0] shiftamount; 
	assign shiftamount = instruction[10:6]; // extracting the shift amount from the instrution
	
	wire [15:0] imm16 = instruction[15:0];
	
	wire [31:0] imm32;
	
	SignExtension signextend(.imm16(imm16), .imm32(imm32)); // instantiating the sign extender block this will sign extend the immidiate value
	// these are the control signals 
	wire memread, memwrite, memtoreg, alusrc, isshift, isloadstore;
	wire isjal, takeaddressfromreg;
	wire regwrite;
	wire [5:0] aluop, branchop;
	// instantiating the contol unit module that will generate the ALUop, Branchop and will set the control signals based on the given instruction
	Control CU(.opcode(instruction[31:26]), .functcode(instruction[5:0]), .MemRead(memread), .MemWrite(memwrite), .MemtoReg(memtoreg), .ALUSrc(alusrc), .ALUop(aluop), .Branchop(branchop), .isShift(isshift), .isLoadStore(isloadstore), .isJAL(isjal), .TakeAddressfromReg(takeaddressfromreg), .regWrite(regwrite));

	wire [31:0] shift_imm;

	assign shift_imm = (isshift == 1) ? shiftamount : imm32;
	
	wire [4:0] load_store;
	
	assign load_store = (isloadstore == 0) ? instruction[25:21] : instruction[20:16];
	
	wire [4:0] reg_to_write;
	
	assign reg_to_write = (isjal == 1) ? 5'b11111: load_store;
	
	wire [31:0] write_data_to_reg;
	wire [31:0] operand2;
	wire[31:0] operand1;
	// instantiating register file this will read and write the data from the appropriate register according to the given instruction
	RegisterFile RF(.clk(clk), .rst(rst), .read_reg1(instruction[25:21]), .read_reg2(instruction[20:16]), .write_reg(reg_to_write), .write_data(write_data_to_reg), .reg_write(regwrite), .data_reg1(operand1), .data_reg2(operand2));
	// the ALUoperand2 is for immediate values and braching address 
	wire [31:0] ALUoperand2;
	assign ALUoperand2 = (alusrc == 1) ? shift_imm : operand2;
	
	wire carry, zero;
	wire lessthanzero;
	output wire [31:0] aluresult;
	// instantiating the ALU module this will do all the arithmetic and logical operations based on the signals setted by the control unit
	ALU alu(.ALUop(aluop), .operand1(operand1), .operand2(ALUoperand2), .carry(carry), .lessthanzero(lessthanzero), .zero(zero), .ALUresult(aluresult));

	wire [31:0] frommemory;
	// after the ALU datamemory is to be instantiated so the write to data memory or read from it can be done
	DataMemory dm(.clk(clk), .rst(rst), .address(aluresult), .datain(operand2), .memwrite(memwrite), .memread(memread), .frommemory(frommemory));

	wire [31:0] last_mux;
	
	assign last_mux = (memtoreg == 1) ? frommemory : aluresult;
	
	wire [31:0] temp_pc;
	assign temp_pc = pc + 1;
	
	
	assign write_data_to_reg = (isjal == 1) ? temp_pc : last_mux;
	
	wire [31:0] reg_label;
	
	assign reg_label = (takeaddressfromreg == 1) ? operand1 : imm32;
	
	wire do_branch;
	// this is the braching module based on the flags outputed from the ALU and the branchop from control unit, this modules decides whether to branch or not
	Branch branch(.branchop(branchop), .carry(carry), .zero(zero), .lessthanzero(lessthanzero), .do_branch(do_branch));
	
	// depending on whether we have to branch or not we assign the value of new program control
	assign new_pc = (do_branch == 1) ? reg_label : temp_pc;

endmodule
