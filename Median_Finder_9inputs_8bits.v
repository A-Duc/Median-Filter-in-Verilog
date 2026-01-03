`include "Ascending_Sorter_3inputs_8bits.v"

module Median_Finder_9inputs_8bits(
    output reg  [7:0] median_pixel,
    output reg        done,
    input  wire       clk, reset, start,
    input  wire [7:0] pixel0, pixel1, pixel2,
    input  wire [7:0] pixel3, pixel4, pixel5,
    input  wire [7:0] pixel6, pixel7, pixel8
);
    wire [7:0] wmin0, wmid0, wmax0;
    wire [7:0] wmin1, wmid1, wmax1;
    wire [7:0] wmin2, wmid2, wmax2;
    wire [7:0] wmax_col0, wmid_col1, wmin_col2;
    wire [7:0] result_wire;

    reg [5:0] pipe_valid;
    
    // STAGE 0
    Ascending_Sorter_3inputs_8bits Row0(
        .min(wmin0), .mid(wmid0), .max(wmax0),
        .in0(pixel0), .in1(pixel1), .in2(pixel2),
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits Row1(
        .min(wmin1), .mid(wmid1), .max(wmax1),
        .in0(pixel3), .in1(pixel4), .in2(pixel5),
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits Row2(
        .min(wmin2), .mid(wmid2), .max(wmax2),
        .in0(pixel6), .in1(pixel7), .in2(pixel8),
        .clk(clk), .reset(reset)
    );

    // STAGE 1
    Ascending_Sorter_3inputs_8bits FindMax(
        .max(wmax_col0), .mid(), .min(),
        .in0(wmin0), .in1(wmin1), .in2(wmin2),        
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits FindMid(
        .mid(wmid_col1), .max(), .min(),
        .in0(wmid0), .in1(wmid1), .in2(wmid2),        
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits FindMin(
        .min(wmin_col2), .max(), .mid(),
        .in0(wmax0), .in1(wmax1), .in2(wmax2),        
        .clk(clk), .reset(reset)
    );

    // STAGE 2
    Ascending_Sorter_3inputs_8bits FindMedian(
        .mid(result_wire), .max(), .min(),
        .in0(wmax_col0), .in1(wmid_col1), .in2(wmin_col2),
        .clk(clk), .reset(reset)
    );

    // CONTROL LOGIC
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pipe_valid <= 6'b0;
            done <= 1'b0;
            median_pixel <= 8'b0;
        end else begin
            pipe_valid <= {pipe_valid[4:0], start};
            
            done <= pipe_valid[4];

            if (pipe_valid[5]) 
                median_pixel <= result_wire;
            else 
                median_pixel <= 8'b0;
        end
    end

endmodule