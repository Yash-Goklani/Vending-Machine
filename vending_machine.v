module vending_machine (clk,rst,in,out,change);
input clk,rst;
input [1:0]in; // 0rs or 1rs or 2rs
output reg out; //product
output reg [1:0]change;  // 0rs or 1rs

parameter S0 = 2'b00, // 0rs state 
		  S1 = 2'b01, // 1rs state
		  S2 = 2'b10; // 2rs state
		  
	reg [1:0] present_state,next_state;
	
	always@ (posedge clk)
	begin
	if (rst)
	begin
	present_state <= 2'b00;
	next_state =2'b00;
	change = 2'b00;
	out =0;
	end
	else
	present_state <= next_state;
	
	case (present_state)
	  S0 : // 0rs state
	  if (in == 2'b00)
	  begin
	    next_state = S0;
		out = 0;
		change = 2'b00;
		end
      else if (in == 2'b01)
        begin
        next_state=S1;
		out=0;
		change=2'b00;
		end
	  else if (in == 2'b10)
        begin
        next_state=S2;
		out=0;
		change=2'b00;
		end
	  
       S1 : // 1rs state
	  if (in == 2'b00)
	  begin
	    next_state = S0;
		out = 0;
		change = 2'b01;
		end
      else if (in == 2'b01)
        begin
        next_state=S2;
		out=0;
		change=2'b00;
		end
	  else if (in == 2'b10)
        begin
        next_state=S0;
		out=1;
		change=2'b00;
		end		
			
	  S2 : // 2rs state
	  if (in == 2'b00)
	  begin
	    next_state = S0;
		out = 0;
		change = 2'b10;
		end
      else if (in == 2'b01)
        begin
        next_state=S0;
		out=1;
		change=2'b00;
		end
	  else if (in == 2'b10)
        begin
        next_state=S0;
		out=1;
		change=2'b01;
		end	
		endcase
		end
	endmodule