`timescale 1ns / 1ps


module part1(Clock, Enable, Clear_b, CounterValue);
	input Clock;
	input Enable;
	input Clear_b;
	output [7:0] CounterValue;
	wire w1, w2, w3, w4, w5, w6, w7, w8;
	
	tflipflop flop1(
		.clock(Clock),
		.reset(Clear_b),
		.t(Enable),
		.q(w1)
		);

	tflipflop flop2(
		.clock(Clock),
		.reset(Clear_b),
		.t(w1&Enable),
		.q(w2)
		);
		
		
	tflipflop flop3(
		.clock(Clock),
		.reset(Clear_b),
		.t(w1&w2&Enable),
		.q(w3)
		);
		
		
	tflipflop flop4(
		.clock(Clock),
		.reset(Clear_b),
		.t(w1&w2&w3&Enable),
		.q(w4)
		);
		
		
	tflipflop flop5(
		.clock(Clock),
		.reset(Clear_b),
		.t(w1&w2&w3&w4&Enable),
		.q(w5)
		);
		
		
	tflipflop flop6(
		.clock(Clock),
		.reset(Clear_b),
		.t(w1&w2&w3&w4&w5&Enable),
		.q(w6)
		);
		
		
	tflipflop flop7(
		.clock(Clock),
		.reset(Clear_b),
		.t(w1&w2&w3&w4&w5&w6&Enable),
		.q(w7)
		);
		
	
	tflipflop flop8(
		.clock(clock),
		.reset(Clear_b),
		.t(w1&w2&w3&w4&w5&w6&w7&Enable),
		.q(w8)
		);
		
	assign CounterValue = {w8, w7, w6, w5, w4, w3, w2, w1};
endmodule
	
module tflipflop(clock, reset, q, t);
	input clock;
	input reset;
	output reg q;
	input t;
	wire w1;
	
	assign w1 = q ^ t;
	
	always@(posedge clock, negedge reset)
	begin
		if (reset == 1'b0)
			q<=0;
		
		else
			q<=w1;
	end
endmodule









