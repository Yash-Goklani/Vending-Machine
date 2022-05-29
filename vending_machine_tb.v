module vending_machine_tb();
reg clk,rst;
reg [1:0]in;

wire out;
wire [1:0]change;

parameter zero= 2'b00 , one = 2'b01, two = 2'b10;  // in Rs

vending_machine DUT(clk,rst,in,out,change);

initial
begin
clk =1'b0;
forever #10 clk=~clk;
end

task reset;
begin
@(negedge clk)
rst= 1'b1;
@(negedge clk)
rst= 1'b0;
end
endtask

task initialize;
begin
in=0;
end
endtask


task enter (input [1:0]i);
begin
in = i;
end
endtask

initial
begin
initialize;
reset;
enter (one);
#20;
enter (zero);
#30;
reset;
enter (two);
#20;
enter(one);
#30;
reset;
enter (two);
#20;
enter(two);
#30;
reset;
#30
$finish;
end

initial
$monitor ("Input clk=%b,rst=%b,in=%b, Output out=%b,change=%b",clk,rst,in,out,change);

endmodule
 
