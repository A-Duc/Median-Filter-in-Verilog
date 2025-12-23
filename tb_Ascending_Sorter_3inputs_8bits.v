`timescale 1ns / 1ps
`include "Ascending_Sorter_3inputs_8bits.v"

module tb_Ascending_Sorter_3inputs_8bits;

    reg clk;
    reg [7:0] in0, in1, in2;
    wire [7:0] min, mid, max;

    Ascending_Sorter_3inputs_8bits uut (
        .min(min),
        .mid(mid),
        .max(max),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .clk(clk)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("tb_Ascending_Sorter_3inputs_8bits.vcd");
        $dumpvars(0, tb_Ascending_Sorter_3inputs_8bits);

        in0 = 8'd0; in1 = 8'd0; in2 = 8'd0;
        #10;
        
        in0 = 8'd3; in1 = 8'd5; in2 = 8'd7;
        #10;
        
        in0 = 8'd1; in1 = 8'd2; in2 = 8'd3;
        #10;
        
        in0 = 8'd45; in1 = 8'd12; in2 = 8'd78;
        #10;
        
        in0 = 8'd55; in1 = 8'd55; in2 = 8'd55;
        #10;
        
        in0 = 8'd15; in1 = 8'd40; in2 = 8'd40;
        #10;
        
        in0 = 8'd90; in1 = 8'd30; in2 = 8'd30;
        #10;
        
        in0 = 8'd0; in1 = 8'd0; in2 = 8'd0;
        #10;
        
        in0 = 8'd255; in1 = 8'd255; in2 = 8'd255;
        #10;
        
        in0 = 8'd0; in1 = 8'd128; in2 = 8'd255;
        #10;
        
        in0 = 8'd66; in1 = 8'd22; in2 = 8'd88;
        #10;
        
        in0 = 8'd5; in1 = 8'd50; in2 = 8'd100;
        #10;
        
        in0 = 8'd7; in1 = 8'd200; in2 = 8'd77;
        #10;
        
        in0 = 8'd60; in1 = 8'd15; in2 = 8'd150;
        #10;
        
        in0 = 8'd220; in1 = 8'd33; in2 = 8'd111;
        #10;
        
        in0 = 8'd80; in1 = 8'd190; in2 = 8'd9;
        #10;
        
        in0 = 8'd240; in1 = 8'd95; in2 = 8'd1;
        #10;
        
        in0 = 8'd40; in1 = 8'd40; in2 = 8'd80;
        #10;
        
        in0 = 8'd35; in1 = 8'd99; in2 = 8'd35;
        #10;
        
        in0 = 8'd180; in1 = 8'd70; in2 = 8'd70;
        #10;
        
        in0 = 8'd125; in1 = 8'd125; in2 = 8'd20;
        #10;
        
        in0 = 8'd145; in1 = 8'd50; in2 = 8'd145;
        #10;
        
        in0 = 8'd18; in1 = 8'd200; in2 = 8'd200;
        #10;
        
        in0 = 8'd100; in1 = 8'd101; in2 = 8'd102;
        #10;
        
        in0 = 8'd2; in1 = 8'd127; in2 = 8'd250;
        #10;
        
        in0 = 8'd64; in1 = 8'd16; in2 = 8'd128;
        #10;
        
        in0 = 8'd1; in1 = 8'd2; in2 = 8'd3;
        #10;
        
        in0 = 8'd253; in1 = 8'd254; in2 = 8'd255;
        #10;
        
        in0 = 8'd120; in1 = 8'd135; in2 = 8'd128;
        #10;
        
        in0 = 8'd0; in1 = 8'd75; in2 = 8'd150;
        #10;
        
        in0 = 8'd100; in1 = 8'd255; in2 = 8'd50;
        #10;
        
        in0 = 8'd97; in1 = 8'd53; in2 = 8'd149;
        #10;
        
        in0 = 8'd89; in1 = 8'd144; in2 = 8'd55;
        #10;
        
        in0 = 8'd90; in1 = 8'd30; in2 = 8'd60;
        #10;
        
        in0 = 8'd73; in1 = 8'd29; in2 = 8'd171;
        #10;
        
        in0 = 8'd84; in1 = 8'd166; in2 = 8'd42;
        #10;
        
        #50;
        $finish;
    end
    
endmodule
