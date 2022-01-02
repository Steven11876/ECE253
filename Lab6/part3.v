// DataIn - input data port
// Resetn - synchronous reset
// Go signal starts things
// DataResult - register at output of ALU
// a is dividend
// b is divisor

module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);
    input Clock;
    input Resetn;
    input Go;
    input [3:0] Divisor;
	 input [3:0] Dividend;
	 output [3:0] Quotient;
    output [3:0] Remainder;


    // lots of wires to connect our datapath and control
//    wire ld_a, ld_b, ld_r; //ld_c, ld_x, 
//    wire ld_alu_out;
    //wire [1:0]  alu_select_a, alu_select_b;
    wire [2:0]alu_op;

    control C0(
        .clk(Clock),
        .resetn(Resetn),
        
        .go(Go),
        
//        .ld_alu_out(ld_alu_out), 
//        .ld_x(ld_x),
//        .ld_a(ld_a),
//        .ld_b(ld_b),
        //.ld_c(ld_c), 
        .ld_r(ld_r), 
        
        //.alu_select_a(alu_select_a),
        //.alu_select_b(alu_select_b),
        .alu_op(alu_op)
    );

    datapath D0(
        .clk(Clock),
        .resetn(Resetn),

        //.ld_alu_out(ld_alu_out), 
        //.ld_x(ld_x),
        //.ld_a(ld_a),
        //.ld_b(ld_b),
        //.ld_c(ld_c), 
        .ld_r(ld_r), 

        //.alu_select_a(alu_select_a),
        //.alu_select_b(alu_select_b),
        .alu_op(alu_op),

        .Quotient(Quotient),
        .Divisor(Divisor),
		  .Remainder(Remainder),
		  .Dividend(Dividend)
		  
    );
                
 endmodule      


module datapath(
    input clk,
    input resetn,
    //input [7:0] data_in,    
	 input [3:0] Divisor,
	 input [3:0] Dividend,
    //input ld_alu_out, 
    //input ld_a, ld_b, //ld_c, ld_x, 
    input ld_r,
    input [2:0] alu_op, 
    //input [1:0] alu_select_a, alu_select_b,
    //output reg [7:0] data_result
	 output reg [3:0] Quotient,
    output reg [3:0] Remainder
    );
    
    // input registers
    //reg [3:0]a;
	 //reg [4:0]b; //c, x
	 
	 reg set;

//    // output of the alu
    reg [8:0] alu_out;

 
    // Output result register
    always@(posedge clk) begin
	 
        
//        else 
            if(ld_r) begin
                //data_result <= alu_out;
					 Quotient <= alu_out[3:0];
					 Remainder <= alu_out[7:4];
					 
    end
	 else if(!resetn) begin
            alu_out <= 9'b000000000;
				Quotient <= 4'b0000;
				Remainder <= 4'b0000;
//				a <= 4'b0; 
//            b <= 5'b0; 
        end
	 end
	 


    // The ALU 
    always @(*)
    begin : ALU
        // alu
        case (alu_op)
            3'd0: begin
                   alu_out = alu_out << 1; //performs addition (shifts)
               end
            3'd1: begin
                   alu_out[8:4] = alu_out[8:4] - {1'b0, Divisor}; //performs multiplication
						 set = alu_out[8];
               end
				3'd2: begin
						if (set)
						 alu_out[8:4] = alu_out[8:4] +{1'b0, Divisor}; 
						 end
				3'd3: begin
						 alu_out[0] = set ? {alu_out[8:1], 1'b0} : {alu_out[8:1], 1'b1}; 
						 end
				3'd4: begin
						 alu_out =  {5'b00000, Dividend};
						 end
            default: alu_out = 8'b0;
				
        endcase
    end
    
endmodule
 
                

module control(
    input clk,
    input resetn,
    input go,

    output reg  ld_r,  //ld_a, ld_b, ld_c, ld_x, 
//    output reg  ld_alu_out,
//    output reg [1:0]  alu_select_a, alu_select_b,
    output reg [2:0]alu_op
    );

    reg [5:0] current_state, next_state; 
    
// S_LOAD_A        = 5'd0,
//                S_LOAD_A_WAIT   = 5'd1,
//                S_LOAD_B        = 5'd2,
//                S_LOAD_B_WAIT   = 5'd3,
//                S_LOAD_C        = 5'd4,
//                S_LOAD_C_WAIT   = 5'd5,
//                S_LOAD_X        = 5'd6,
//                S_LOAD_X_WAIT   = 5'd7,
localparam      load = 5'd0,
					 S_CYCLE_0       = 5'd1,
                S_CYCLE_1       = 5'd2,
                S_CYCLE_2       = 5'd3,
					 S_CYCLE_3       = 5'd4,
					 S_CYCLE_4       = 5'd5,
					 S_CYCLE_5       = 5'd6,
                S_CYCLE_6       = 5'd7,
					 S_CYCLE_7       = 5'd8,
					 S_CYCLE_8       = 5'd9,
					 S_CYCLE_9       = 5'd10,
                S_CYCLE_10       = 5'd11,
					 S_CYCLE_11       = 5'd12,
					 S_CYCLE_12       = 5'd13,
					 S_CYCLE_13       = 5'd14,
                S_CYCLE_14       = 5'd15,
					 S_CYCLE_15       = 5'd16,
					 S_CYCLE_16       = 5'd17;
    
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
//                S_LOAD_A: next_state = go ? S_LOAD_A_WAIT : S_LOAD_A; // Loop in current state until value is input
//                S_LOAD_A_WAIT: next_state = go ? S_LOAD_A_WAIT : S_LOAD_B; // Loop in current state until go signal goes low
//                S_LOAD_B: next_state = go ? S_LOAD_B_WAIT : S_LOAD_B; // Loop in current state until value is input
//                S_LOAD_B_WAIT: next_state = go ? S_LOAD_B_WAIT : S_LOAD_C; // Loop in current state until go signal goes low
//                S_LOAD_C: next_state = go ? S_LOAD_C_WAIT : S_LOAD_C; // Loop in current state until value is input
//                S_LOAD_C_WAIT: next_state = go ? S_LOAD_C_WAIT : S_LOAD_X; // Loop in current state until go signal goes low
//                S_LOAD_X: next_state = go ? S_LOAD_X_WAIT : S_LOAD_X; // Loop in current state until value is input
//                S_LOAD_X_WAIT: next_state = go ? S_LOAD_X_WAIT : S_CYCLE_0; // Loop in current state until go signal goes low
                load: next_state = go ? S_CYCLE_0: load;
					 S_CYCLE_0: next_state = S_CYCLE_1;
                S_CYCLE_1: next_state = S_CYCLE_2; 
					 S_CYCLE_2: next_state = S_CYCLE_3;
					 S_CYCLE_3: next_state = S_CYCLE_4;
					 S_CYCLE_4: next_state = S_CYCLE_5;
                S_CYCLE_5: next_state = S_CYCLE_6;
                S_CYCLE_6: next_state = S_CYCLE_7; 
					 S_CYCLE_7: next_state = S_CYCLE_8;
					 S_CYCLE_8: next_state = S_CYCLE_9;
					 S_CYCLE_9: next_state = S_CYCLE_10;
					 S_CYCLE_10: next_state = S_CYCLE_11;
                S_CYCLE_11: next_state = S_CYCLE_12;
                S_CYCLE_12: next_state = S_CYCLE_13; 
					 S_CYCLE_13: next_state = S_CYCLE_14;
					 S_CYCLE_14: next_state = S_CYCLE_15;
					 S_CYCLE_15: next_state = S_CYCLE_16;
					 S_CYCLE_16: begin 
						next_state = go ? S_CYCLE_0 : S_CYCLE_16;
						ld_r =1 ;
						end
					 
					 // we will be done our two operations, start over after
            default:     next_state = S_CYCLE_0;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
//        ld_alu_out = 1'b0;
//        ld_a = 1'b0;
//        ld_b = 1'b0;
//        ld_c = 1'b0;
//        ld_x = 1'b0;
        ld_r = 1'b0;
//        alu_select_a = 2'b0;
//        alu_select_b = 2'b0;
        //alu_op       = 3'b011;

        case (current_state)
//            S_LOAD_A: begin
//                ld_a = 1'b1;
//                end
//            S_LOAD_B: begin
//                ld_b = 1'b1;
//                end
//            S_LOAD_C: begin
//                ld_c = 1'b1;
//                end
//            S_LOAD_X: begin
//                ld_x = 1'b1;
//                end
            S_CYCLE_0: begin // Do A <- A * x 
//                ld_alu_out = 1'b1; ld_a = 1'b1; // store result back into A
//                alu_select_a = 2'b00; // Select register A
//                alu_select_b = 2'b11; // Also select register A
					if (go)
                alu_op = 3'b100; // Do multiply operation
            end
				
            S_CYCLE_1: alu_op = 3'b000;
				
            S_CYCLE_2: alu_op = 3'b001;

            S_CYCLE_3: alu_op = 3'b010;
				
            S_CYCLE_4: alu_op = 3'b011;
				
            S_CYCLE_5: alu_op = 3'b000;

            S_CYCLE_6: alu_op = 3'b001;
				
            S_CYCLE_7: alu_op = 3'd010;
				
			   S_CYCLE_8: alu_op = 3'b011;
            S_CYCLE_9: alu_op = 3'b000;

            S_CYCLE_10: alu_op = 3'b001;
				
            S_CYCLE_11: alu_op = 3'b010;
				
			   S_CYCLE_12: alu_op = 3'b011;
            S_CYCLE_13: alu_op = 3'b000;

            S_CYCLE_14: alu_op = 3'b001;
				
            S_CYCLE_15: alu_op = 3'b010;
				
			   S_CYCLE_16: begin
					//alu_op = 3'b011;
					ld_r = 1;
				end
				
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= load;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

