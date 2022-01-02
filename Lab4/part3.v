`timescale 1ns / 1ps



module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input clock;
	input reset;
	input ParallelLoadn;
	input [7:0] Data_IN;
	input ASRight;
	input RotateRight;
	output [7:0] Q;
	wire muxer;
	
	mux2to1 mm(
		.x(Q[7]),
		.y(Q[0]),
		.s(ASRight),
		.m(muxer)
		);
		
		
	sub sub0(
		.clock(clock),
		.reset(reset),
		.Q(Q[0]),
		.left(Q[7]),
		.right(Q[1]),
		.loadn(ParallelLoadn),
		.D(Data_IN[0]),
		.loadleft(~RotateRight)
	);
	
	sub sub1(
		.clock(clock),
		.reset(reset),
		.Q(Q[1]),
		.left(Q[0]),
		.right(Q[2]),
		.loadn(ParallelLoadn),
		.D(Data_IN[1]),
		.loadleft(~RotateRight)
	);

	sub sub2(
		.clock(clock),
		.reset(reset),
		.Q(Q[2]),
		.left(Q[1]),
		.right(Q[3]),
		.loadn(ParallelLoadn),
		.D(Data_IN[2]),
		.loadleft(~RotateRight)
	);
	
	sub sub3(
		.clock(clock),
		.reset(reset),
		.Q(Q[3]),
		.left(Q[2]),
		.right(Q[4]),
		.loadn(ParallelLoadn),
		.D(Data_IN[3]),
		.loadleft(~RotateRight)
	);
	
	sub sub4(
		.clock(clock),
		.reset(reset),
		.Q(Q[4]),
		.left(Q[3]),
		.right(Q[5]),
		.loadn(ParallelLoadn),
		.D(Data_IN[4]),
		.loadleft(~RotateRight)
	);
	
	sub sub5(
		.clock(clock),
		.reset(reset),
		.Q(Q[5]),
		.left(Q[4]),
		.right(Q[6]),
		.loadn(ParallelLoadn),
		.D(Data_IN[5]),
		.loadleft(~RotateRight)
	);
	
	sub sub6(
		.clock(clock),
		.reset(reset),
		.Q(Q[6]),
		.left(Q[5]),
		.right(Q[7]),
		.loadn(ParallelLoadn),
		.D(Data_IN[6]),
		.loadleft(~RotateRight)
	);
	
	sub sub7(
		.clock(clock),
		.reset(reset),
		.Q(Q[7]),
		.left(Q[6]),
		.right(muxer),
		.loadn(ParallelLoadn),
		.D(Data_IN[7]),
		.loadleft(~RotateRight)
	);
	
	

endmodule
	
	
	
module sub (clock, reset, Q, left, right, loadn, D, loadleft);
	input clock;
	input reset;
	input loadn;
	input left;
	input right;
	input loadleft;
	input D;
	output Q;
	wire w1, w2;
	
	
	mux2to1 M1(
	.x(left),
	.y(right),
	.s(loadleft),
	.m(w1)
	);
	
	mux2to1 M2(
	.x(w1),
	.y(D),
	.s(loadn),
	.m(w2)
	);
	
	flipflop f1(
	.clock(clock),
	.reset(reset),
	.d(w2),
	.q(Q)
	);
	
endmodule
	
	
module mux2to1 (x,y,s,m);
	input x, y, s;
	output m;
	assign m = s&x | ~s&y;
endmodule
	
	
module flipflop(clock, reset, q, d);
	input clock;
	input reset;
	output reg q;
	input d;
	
	always@( posedge clock)
	begin
		if (reset == 1'b1)
			q<=0;
		
		else
			q<=d;
	end
endmodule