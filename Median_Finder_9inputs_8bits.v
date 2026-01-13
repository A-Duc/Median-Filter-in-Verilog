//`include "Ascending_Sorter_3inputs_8bits.v"

module Median_Finder_9inputs_8bits(
    output wire  [7:0] median_pixel,
    output wire        done,
    input  wire       clk, reset, start,
    input  wire [7:0] pixel0, pixel1, pixel2,
    input  wire [7:0] pixel3, pixel4, pixel5,
    input  wire [7:0] pixel6, pixel7, pixel8
);
    wire [7:0] wmin0, wmid0, wmax0;
    wire [7:0] wmin1, wmid1, wmax1;
    wire [7:0] wmin2, wmid2, wmax2;
    wire [7:0] wmax_col0, wmid_col1, wmin_col2;

    reg [5:0] pipe_ctrl;

    always @(posedge clk or posedge reset) begin
        if (reset) 
            pipe_ctrl <= 6'b0;
        else 
            pipe_ctrl <= {pipe_ctrl[4:0], start};
    end

    //=====enable for each stage=====
    wire en_stage0 = start;
    wire en_stage1 = pipe_ctrl[1];
    wire en_stage2 = pipe_ctrl[3];


    assign done = pipe_ctrl[5];


    //===== STAGE 0 (Input Row Sorting) =====
    Ascending_Sorter_3inputs_8bits Row0(
        .min(wmin0), .mid(wmid0), .max(wmax0),
        .in0(pixel0), .in1(pixel1), .in2(pixel2),
        .enable(en_stage0), 
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits Row1(
        .min(wmin1), .mid(wmid1), .max(wmax1),
        .in0(pixel3), .in1(pixel4), .in2(pixel5),
        .enable(en_stage0),
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits Row2(
        .min(wmin2), .mid(wmid2), .max(wmax2),
        .in0(pixel6), .in1(pixel7), .in2(pixel8),
        .enable(en_stage0),
        .clk(clk), .reset(reset)
    );

    //===== STAGE 1 (Column Sorting) =====
    Ascending_Sorter_3inputs_8bits FindMax(
        .max(wmax_col0), .mid(), .min(),
        .in0(wmin0), .in1(wmin1), .in2(wmin2),   
        .enable(en_stage1),     
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits FindMid(
        .mid(wmid_col1), .max(), .min(),
        .in0(wmid0), .in1(wmid1), .in2(wmid2),  
        .enable(en_stage1),      
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits FindMin(
        .min(wmin_col2), .mid(), .max(),
        .in0(wmax0), .in1(wmax1), .in2(wmax2), 
        .enable(en_stage1),        
        .clk(clk), .reset(reset)
    );

    //===== STAGE 2 (Final Median Calculation) =====
    Ascending_Sorter_3inputs_8bits FindMedian(
        .mid(median_pixel), .max(), .min(),
        .in0(wmax_col0), .in1(wmid_col1), .in2(wmin_col2),
        .enable(en_stage2),
        .clk(clk), .reset(reset)
    );

endmodule