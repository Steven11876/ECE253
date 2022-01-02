

module part3 (A, B, Function, ALUout);
	
	input [3:0] A;
	input [3:0] B;
	input [2:0] Function;
	output [7:0] ALUout;
	wire w1_0, w1_1, w1_2, w1_3,w2;
	
	part2 u0(
	.a (A),
	.b (B),
	.c_in (1'b0),
	.s ({w1_3, w1_2, w1_1, w1_0}),
	.c_out (w2)
	);
	
	

	reg [7:0] ALUout;
	
	
	always@(*)
	begin
		case(Function[2:0])
			3'b000: ALUout = {1'b0, 1'b0, 1'b0, w2, w1_3, w1_2, w1_1, w1_0};
			3'b001: ALUout = {{4{1'b0}}, A+B};
			3'b010: ALUout = {{4{B[3]}}, B};
			3'b011: ALUout = {{7{1'b0}}, |{A, B}};
			3'b100: ALUout = {{7{1'b0}}, &{A, B}};
			3'b101: ALUout = {A, B};
			default:ALUout = 8'b00000000;
		endcase
	end

endmodule


module part2(a, b, c_in, s, c_out);
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] s;
	output [4:0] c_out;
	wire w1, w2, w3, w4;
	
	adder u0(
		.a (a[0]),
		.b (b[0]),
		.c_in(c_in), 
		.s(s[0]),
		.c_out(w1)
		);
		
	adder u1(
		.a (a[1]),
		.b (b[1]),
		.c_in(w1), 
		.s(s[1]),
		.c_out(w2)
		);
	
	adder u2(
		.a (a[2]),
		.b (b[2]),
		.c_in(w2), 
		.s(s[2]),
		.c_out(w3)
		);
		
	adder u3(
		.a (a[3]),
		.b (b[3]),
		.c_in(w3), 
		.s(s[3]),
		.c_out(w4)
		);
		
	assign c_out = {w4, w3, w2, w1};
	
	endmodule
	
	

module adder(a, b, c_in, s, c_out);
	input a, b, c_in;
	output c_out, s;
	assign c_out = a&b | b&c_in | a&c_in;
	assign s = a&~b&~c_in | ~a&b&~c_in | ~a&~b&c_in | a&b&c_in;
	
	endmodule
