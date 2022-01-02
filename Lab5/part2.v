module part2(ClockIn, Reset, Speed, CounterValue);
	input ClockIn;
	input Reset;
	input [1:0] Speed;
	output reg [3:0] CounterValue;
	wire [10:0] rate;
	wire enable;


	clocker cl0(
	.clock(ClockIn),
	.speed(Speed), 
	.count(rate),
	.reset(Reset)
	);
	
	assign enable = (rate==11'b00000000000)?1:0;
	
	always @(posedge ClockIn)
	begin
		if (Reset == 1'b1)
			CounterValue <=0;
		else if (enable == 1'b1)
			CounterValue <= CounterValue +1;
	
	end

endmodule
			


module clocker(clock, speed, count, reset);
	input clock;
	input [1:0] speed;
	input reset;
	output reg [10:0] count;
	wire [10:0] d;

	
	mux4to1 muxy(
		.MuxSelect(speed),
		.Out(d)
		);
	
	always @(posedge clock)
		begin
		if (count == 11'b00000000000)
			count <=d;
		else if (reset == 1'b1)
			count <= d;
		else
			count <= count - 1;
		end
		
endmodule
		
	
	
module mux4to1 (MuxSelect, Out);
	input [1:0] MuxSelect;
	output reg [10:0] Out;
	
	always@(*)
	begin
		case(MuxSelect[1:0])
			2'b00: Out = 11'b00000000000;
			2'b01: Out = 11'b00111110011;
			2'b10: Out = 11'b01111100111;
			2'b11: Out = 11'b11111001111;
		endcase
	end

endmodule
