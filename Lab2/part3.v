

module hex_decoder(c, display);
	input [3:0] c;
	output [6:0] display;
	inside u0(
		.a (c[3]),
		.b (c[2]),
		.c (c[1]),
		.d (c[0]),
		.h0 (display[0]),
		.h1 (display[1]),
		.h2 (display[2]),
		.h3 (display[3]),
		.h4 (display[4]),
		.h5 (display[5]),
		.h6 (display[6])
		);
	
endmodule
	
	
module inside(a, b, c, d, h0, h1, h2, h3, h4, h5, h6);
	input a, b, c, d;
	output h0, h1, h2, h3, h4, h5, h6;
	
	in0 u0(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h0 (h0)
		);
		
	in1 u1(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h1 (h1)
		);

	in2 u2(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h2 (h2)
		);
		
	in3 u3(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h3 (h3)
		);
		
	in4 u4(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h4 (h4)
		);
		
	in5 u5(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h5 (h5)
		);
		
	in6 u6(
		.a (a),
		.b (b),
		.c (c),
		.d (d),	
		.h6 (h6)
		);

endmodule
	
	
module in0(a, b, c, d, h0);
	input a, b, c, d;
	output h0;
	
	assign h0 = ~(b&c | ~b&~d | ~a&b&d | a&~d | ~a&c | a&~b&~c);

	
endmodule
	
module in1(a, b, c, d, h1);
	input a, b, c, d;
	output h1;
	
	assign h1 = ~(~a&c&d | ~a&~c&~d | ~b&~c | a&~c&d | ~b&~d);

	
endmodule

module in2(a, b, c, d, h2);
	input a, b, c, d;
	output h2;
	
	assign h2 = ~(~c&d | ~a&b | ~a&~c | ~a&d | a&~b);
	

endmodule
	

module in3(a, b, c, d, h3);
	input a, b, c, d;
	output h3;
	
	assign h3 = ~(b&c&~d | ~a&~b&~d | b&~c&d | ~b&c&d | a&~c);
	

endmodule
	
	
module in4(a, b, c, d, h4);
	input a, b, c, d;
	output h4;
	
	
	assign h4 = ~(c&~d | a&c| ~d&~b | a&b);
	

endmodule
	
	
module in5(a, b, c, d, h5);
	input a, b, c, d;
	output h5;
	
	assign h5 = ~(a&~b | ~a&b&~c | ~c&~d | b&~d | a&c);
	

endmodule
	
	
module in6(a, b, c, d, h6);
	input a, b, c, d;
	output h6;
	
	assign h6 = ~(~b&c | a&~b | ~a&b&~c | c&~d | a&d);
	

endmodule
	