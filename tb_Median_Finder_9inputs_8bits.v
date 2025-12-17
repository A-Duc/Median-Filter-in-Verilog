`timescale 10ns / 1ps
`include "Median_Finder_9inputs_8bits.v"

module tb_Median_Finder_9inputs_8bits;
    reg     [7:0] pixel0, pixel1, pixel2;
    reg     [7:0] pixel3, pixel4, pixel5;
    reg     [7:0] pixel6, pixel7, pixel8;
    wire    [7:0] median_pixel;

    Median_Finder_9inputs_8bits utt(
        .median_pixel(median_pixel),
        .pixel0(pixel0), .pixel1(pixel1), .pixel2(pixel2), 
        .pixel3(pixel3), .pixel4(pixel4), .pixel5(pixel5), 
        .pixel6(pixel6), .pixel7(pixel7), .pixel8(pixel8) 
    );

    initial begin
        $dumpfile("tb_Median_Finder_9inputs_8bits.vcd");
        $dumpvars(0, tb_Median_Finder_9inputs_8bits);

        
        pixel0 = 8'd1; pixel1 = 8'd2; pixel2 = 8'd3;
        pixel3 = 8'd1; pixel4 = 8'd2; pixel5 = 8'd3;
        pixel6 = 8'd1; pixel7 = 8'd2; pixel8 = 8'd3;

        #10
        pixel0 = 8'd1; pixel1 = 8'd1; pixel2 = 8'd1;
        pixel3 = 8'd1; pixel4 = 8'd1; pixel5 = 8'd1;
        pixel6 = 8'd1; pixel7 = 8'd1; pixel8 = 8'd1;

        #10
        pixel0 = 8'd1; pixel1 = 8'd2; pixel2 = 8'd3;
        pixel3 = 8'd4; pixel4 = 8'd5; pixel5 = 8'd6;
        pixel6 = 8'd7; pixel7 = 8'd8; pixel8 = 8'd9;

        #10
        pixel0 = 8'd2; pixel1 = 8'd12; pixel2 = 8'd36;
        pixel3 = 8'd5; pixel4 = 8'd27; pixel5 = 8'd18;
        pixel6 = 8'd8; pixel7 = 8'd25; pixel8 = 8'd22;

        #10
        pixel0 = 8'd18; pixel1 = 8'd20; pixel2 = 8'd3;
        pixel3 = 8'd12; pixel4 = 8'd12; pixel5 = 8'd6;
        pixel6 = 8'd15; pixel8 = 8'd12; pixel8 = 8'd9;

        #10;
    end

endmodule