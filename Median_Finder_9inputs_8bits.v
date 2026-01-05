`include "Ascending_Sorter_3inputs_8bits.v"

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
    wire [7:0] result_wire;

    wire stage0_done [0:2];
    wire stage1_done [0:2];
    wire stage2_done;

    wire stage_en [1:2];
    assign stage_en[1] = stage0_done[0] && stage0_done[1] && stage0_done[2];
    assign stage_en[2] = stage1_done[0] && stage1_done[1] && stage1_done[2];   
    
    
    //=====STAGE 0=====
    Ascending_Sorter_3inputs_8bits Row0(
        .done(stage0_done[0]),
        .min(wmin0), .mid(wmid0), .max(wmax0),
        .in0(pixel0), .in1(pixel1), .in2(pixel2),
        .enable(start),
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits Row1(
        .done(stage0_done[1]),
        .min(wmin1), .mid(wmid1), .max(wmax1),
        .in0(pixel3), .in1(pixel4), .in2(pixel5),
        .enable(start),
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits Row2(
        .done(stage0_done[2]),
        .min(wmin2), .mid(wmid2), .max(wmax2),
        .in0(pixel6), .in1(pixel7), .in2(pixel8),
        .enable(start),
        .clk(clk), .reset(reset)
    );

    //=====STAGE 1=====
    Ascending_Sorter_3inputs_8bits FindMax(
        .done(stage1_done[0]),
        .max(wmax_col0), .mid(), .min(),
        .in0(wmin0), .in1(wmin1), .in2(wmin2),   
        .enable(stage_en[1]),     
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits FindMid(
        .done(stage1_done[1]),
        .mid(wmid_col1), .max(), .min(),
        .in0(wmid0), .in1(wmid1), .in2(wmid2),  
        .enable(stage_en[1]),      
        .clk(clk), .reset(reset)
    );
    Ascending_Sorter_3inputs_8bits FindMin(
        .done(stage1_done[2]),
        .min(wmin_col2), .max(), .mid(),
        .in0(wmax0), .in1(wmax1), .in2(wmax2),   
        .enable(stage_en[1]),     
        .clk(clk), .reset(reset)
    );

    //=====STAGE 0=====
    Ascending_Sorter_3inputs_8bits FindMedian(
        .done(stage2_done),
        .mid(result_wire), .max(), .min(),
        .in0(wmax_col0), .in1(wmid_col1), .in2(wmin_col2),
        .enable(stage_en[2]),
        .clk(clk), .reset(reset)
    );

    assign median_pixel = result_wire;
    assign done = stage2_done;

endmodule