

module part2(Clock, Reset_b, Data, Function, ALUout);

	input Clock;
	input Reset_b;
	input [2:0] Function;
	input [3:0] Data;
	output reg [7:0] ALUout;
	wire w1_0, w1_1, w1_2, w1_3, w2_0, w2_1, w2_2, w2_3;
	reg[7:0]q;
	wire [3:0]B;

	assign B = ALUout[3:0];
	
	overadder u0(
	.a (Data),
	.b (B),
	.c_in (1'b0),
	.s ({w1_3, w1_2, w1_1, w1_0}),
	.c_out ({w2_3, w2_2, w2_1, w2_0})
	);
	
	always@(*)
		begin
		case(Function[2:0])
			3'b000: q = {1'b0, 1'b0, 1'b0, w2_3, w1_3, w1_2, w1_1, w1_0};
			3'b001: q = {{3{1'b0}}, {1'b0, Data}+{1'b0,B}};
			3'b010: q = {{4{B[3]}}, B};
			3'b011: q = {{7{1'b0}}, |{Data, B}};
			3'b100: q = {{7{1'b0}}, &{Data, B}};
			3'b101: q = {{{4{1'b0}}, B}<<Data};
			3'b110: q = {Data*B};
			3'b111: q = ALUout;
			default:q = 8'b00000000;
		endcase
	end

	always@(posedge Clock)
	begin
		if(Reset_b == 1'b0)
			ALUout <= 8'b00000000;
		else
			ALUout <= q;
	end
	
endmodule


module overadder(a, b, c_in, s, c_out);
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
	