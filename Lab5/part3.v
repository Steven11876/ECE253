

module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input ClockIn;
	input Resetn;
	input [2:0] Letter;
	input Start;
	output DotDashOut;
	reg [7:0] w;
	reg [11:0] w2;
	reg [11:0] w3;

		
	always @(posedge ClockIn)
		begin
		if (Resetn == 1'b0) 
			w <= 8'b11111001;
			//w <= 8'b00000111;
		else if (w == 8'b00000000) 
			w <= 8'b11111001;
			//w <= 8'b00000111;
		else
			w <= w - 1;
		end
	
	always@(*)
	begin
		case(Letter[2:0])
			3'b000: w2 = 12'b101110000000;
			3'b001: w2 = 12'b111010101000;
			3'b010: w2 = 12'b111010111010;
			3'b011: w2 = 12'b111010100000;
			3'b100: w2 = 12'b100000000000;
			3'b101: w2 = 12'b101011101000;
			3'b110: w2 = 12'b111011101000;
			3'b111: w2 = 12'b101010100000;
		endcase
	end
	
	assign DotDashOut = w3[0];
	

	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[0]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[0] <= w2[0];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[0] <= w3[11];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[1]<=1'b0;
			//w <= 8'b11111001;
		end
			
		else if (Start ==1) begin
			w3[1] <= w2[1];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[1] <= w3[0];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[2]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[2] <= w2[2];
			//w <= 8'b11111001;
		end
			
		else if (w == 0)
			w3[2] <= w3[1];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[3]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[3] <= w2[3];
			//w <= 8'b11111001;
		end
			
		else if (w == 0)
			w3[3] <= w3[2];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[4]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[4] <= w2[4];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[4] <= w3[3];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[5]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[5] <= w2[5];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[5] <= w3[4];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[6]<=1'b0;
			//w <= 8'b11111001;
		end
			
		else if (Start ==1) begin
			w3[6] <= w2[6];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[6] <= w3[5];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[7]<=1'b0;
			//w <= 8'b11111001;
		end
			
		else if (Start ==1) begin
			w3[7] <= w2[7];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[7] <= w3[6];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[8]<=1'b0;
			//w <= 8'b11111001;
		end
			
		else if (Start ==1) begin
			w3[8] <= w2[8];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[8] <= w3[7];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[9]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[9] <= w2[9];
			//w <= 8'b11111001;
		end
			
		else if (w == 0)
			w3[9] <= w3[8];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[10]<=1'b0;
			//w <= 8'b11111001;
		end
			
		else if (Start ==1) begin
			w3[10] <= w2[10];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[10] <= w3[9];
	end
	
	always@(posedge ClockIn, negedge Resetn, posedge Start)
	begin
		if (Resetn == 1'b0) begin
			w3[11]<=1'b0;
			//w <= 8'b11111001;
		end
		
		else if (Start ==1) begin
			w3[11] <= w2[11];
			//w <= 8'b11111001;
		end
		
		else if (w == 0)
			w3[11] <= w3[10];
	end
	

//	flipflop flop1(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[0]&Start | ~Start&w3[1]),
//		.slowclock(w),
//		.q(w3[0])
//		);
//		
//	flipflop flop2(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[1]&Start | ~Start&w3[2]),
//		.slowclock(w),
//		.q(w3[1])
//		);
//		
//	flipflop flop3(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[2]&Start | ~Start&w3[3]),
//		.slowclock(w),
//		.q(w3[2])
//		);
//		
//	flipflop flop4(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[3]&Start | ~Start&w3[4]),
//		.slowclock(w),
//		.q(w3[3])
//		);
//		
//	flipflop flop5(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[4]&Start | ~Start&w3[5]),
//		.slowclock(w),
//		.q(w3[4])
//		);
//
//	flipflop flop6(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[5]&Start | ~Start&w3[6]),
//		.slowclock(w),
//		.q(w3[5])
//		);
//		
//	flipflop flop7(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[6]&Start | ~Start&w3[7]),
//		.slowclock(w),
//		.q(w3[6])
//		);
//		
//	flipflop flop8(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[7]&Start | ~Start&w3[8]),
//		.slowclock(w),
//		.q(w3[7])
//		);
//		
//	flipflop flop9(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[8]&Start | ~Start&w3[9]),
//		.slowclock(w),
//		.q(w3[8])
//		);
//		
//	flipflop flop10(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[9]&Start | ~Start&w3[10]),
//		.slowclock(w),
//		.q(w3[9])
//		);
//		
//	flipflop flop11(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[10]&Start | ~Start&w3[11]),
//		.slowclock(w),
//		.q(w3[10])
//		);
//		
//	flipflop flop12(
//		.clock(ClockIn),
//		.reset (Resetn),
//		.d(w2[11]&Start | ~Start&w3[0]),
//		.slowclock(w),
//		.q(w3[11])
//		);
		

		
endmodule
	//rotate with mux, .dashout takes first value of flop1 q
	


//module clockes(clock, count);
//	input clock;
//	output reg [7:0] count;
//	initial 
//		assign count = 8'b11111010;
//	always @(posedge clock)
//		begin
//		if (count == 8'b00000000)
//			count <= 8'b11111010;
//		else
//			count <= count - 1;
//		end
//		
//endmodule
		
	
//module mux8to1 (MuxSelect, Out);
//	input [2:0] MuxSelect;
//	output reg [11:0] Out;
//	
//	always@(*)
//	begin
//		case(MuxSelect)
//			3'b000: Out = 12'b10111000000;
//			3'b001: Out = 12'b11101010100;
//			3'b010: Out = 12'b11101011101;
//			3'b011: Out = 12'b11101010000;
//			3'b100: Out = 12'b10000000000;
//			3'b101: Out = 12'b10101110100;
//			3'b110: Out = 12'b11101110100;
//			3'b111: Out = 12'b10101010000;
//		endcase
//	end
//
//endmodule

//
//module flipflop(clock, reset, q, d, slowclock);
//	input clock;
//	input reset;
//	input [7:0]slowclock;
//	output reg q;
//	input d;
//	
//	always@(posedge clock, negedge reset)
//	begin
//		if (reset == 1'b0)
//			q<=1'b0;
//		
//		else if (slowclock == 8'b00000000)
//			q<=d;
//	end
//endmodule


//s&x | ~s&y