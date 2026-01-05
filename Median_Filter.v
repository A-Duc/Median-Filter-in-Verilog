`timescale 1ns/1ps
`include "Median_Finder_9inputs_8bits.v"

module Median_Filter();

    parameter WIDTH  = 430;
    parameter HEIGHT = 554;
    parameter TOTAL_PIXELS = WIDTH * HEIGHT;

    wire        done;
    wire [7:0]  median_pixel;

    reg         clk, start, reset;   
    reg  [7:0]  pixel0, pixel1, pixel2;
    reg  [7:0]  pixel3, pixel4, pixel5;
    reg  [7:0]  pixel6, pixel7, pixel8;

    integer x, y; 
    integer output_file;

    reg  [7:0]  i_img [0:TOTAL_PIXELS-1];
    reg  [7:0]  o_img [0:TOTAL_PIXELS-1];
    
    Median_Finder_9inputs_8bits utt(
        .median_pixel(median_pixel),
        .done(done), 
        .clk(clk), 
        .start(start), 
        .reset(reset),
        .pixel0(pixel0), .pixel1(pixel1), .pixel2(pixel2),
        .pixel3(pixel3), .pixel4(pixel4), .pixel5(pixel5),
        .pixel6(pixel6), .pixel7(pixel7), .pixel8(pixel8)
    );

    always #5 clk = ~clk;

    function [7:0] Get_Pixel;
        input integer r; 
        input integer c; 

        begin
            if (c < 0 || c >= WIDTH || r < 0 || r >= HEIGHT)
                Get_Pixel = 8'd0; 
            else
                Get_Pixel = i_img[r * WIDTH + c];
        end
    endfunction

    initial begin
        clk = 0; start = 0; reset = 1;   
        pixel0 = 0; pixel1 = 0; pixel2 = 0;
        pixel3 = 0; pixel4 = 0; pixel5 = 0;
        pixel6 = 0; pixel7 = 0; pixel8 = 0;

        $readmemh("input_img.txt", i_img);
        output_file = $fopen("output_img.txt", "w");

        if (output_file == 0) begin
            $display("Error: Cannot open output file!");
            $finish;
        end

        #20;
        reset = 0;
        

        #20
        @(negedge clk)
        start = 1;
        

        for (x = 0; x < HEIGHT; x = x + 1) begin
            for (y = 0; y < WIDTH; y = y + 1) begin
                
                pixel0 = Get_Pixel(x-1, y-1);
                pixel1 = Get_Pixel(x-1, y  );
                pixel2 = Get_Pixel(x-1, y+1);
                
                pixel3 = Get_Pixel(x,   y-1);
                pixel4 = Get_Pixel(x,   y  );   
                pixel5 = Get_Pixel(x,   y+1);
                
                pixel6 = Get_Pixel(x+1, y-1);
                pixel7 = Get_Pixel(x+1, y  );
                pixel8 = Get_Pixel(x+1, y+1);

                @(posedge clk);
            end
        end

        @(negedge clk); 
        start = 0;
        
        #200; 
        
        $fclose(output_file);
        $finish;
    end

    always @(negedge clk) begin
        if (done) begin
            $fwrite(output_file, "%02x\n", median_pixel);
        end
    end

endmodule