`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:23 11/12/2021 
// Design Name: 
// Module Name:    bin_fact 
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


// Name : Suryam Arnav Kalra
// Roll No.: 19CS30050


module bin_fact(clk, start, a, b, done, product);
	// take the input signal
	input clk, start;
	// take the input operands
	input [6:0] a, b;
	// output register to denote the completion of execution
	output reg done;
	// output register for the product
	output reg [12:0] product;
	
	// register to denote the number of iterations
	reg [6:0] count;
	
	// register to store the intermediate values
	reg [6:0] a_, b_;
	
	// register to store the intermediate product
	reg [13:0] p_;
	
	// do some action at the positive edge of the clock
	always @(posedge clk) begin
	
		// if we are in the reset (start) state
		if(start) begin
		   // set the register values
			a_ = a;
			b_ = b;
			// P0 = 0
			p_ = 0;
			// count (iteration number) = 0
			count = 0;
			// output not ready
			done = 0;
		end
		else begin
			
			// the below is the controllerpath which goes to a particular state (if-else block) according to the iteration number
		
			// if the iteration number >= 7, we have the result
			if(count >= 7) begin
				// we are ready to take the result
				done = 1;
				product = p_;
			end
			else begin
			
				// the below is the datapath which computes the partial results
			
				// set the uppermost bits of the product with the addition as P_i = P_i + Y*X[n-1-i]
				{p_[13:6]} = p_[13:6] + (b_*a_[count]);
				// right shift the product 
				p_ = p_ >> 1;
				// increase the iteration count by 1
				count = count + 1;
			end
		end
		
	end


endmodule
