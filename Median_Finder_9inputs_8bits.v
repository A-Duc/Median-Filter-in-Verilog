//`include "Ascending_Sorter_3inputs_8bits.v"

module Median_Finder_9inputs_8bits(
    output wire [7:0] median_pixel,
    input  wire [7:0] pixel0, pixel1, pixel2,
    input  wire [7:0] pixel3, pixel4, pixel5,
    input  wire [7:0] pixel6, pixel7, pixel8,
    input  wire       clk
);

    reg     [7:0] rmin0, rmid0, rmax0;
    reg     [7:0] rmin1, rmid1, rmax1;
    reg     [7:0] rmin2, rmid2, rmax2;
    
    wire    [7:0] wmin0, wmid0, wmax0;
    wire    [7:0] wmin1, wmid1, wmax1;
    wire    [7:0] wmin2, wmid2, wmax2;

    reg     [7:0] rmax_col0, rmid_col1, rmin_col2;
    wire    [7:0] wmax_col0, wmid_col1, wmin_col2;

    //STAGE 0
    Ascending_Sorter_3inputs_8bits Row0(
        .min(wmin0), .mid(wmid0), .max(wmax0),
        .in0(pixel0), .in1(pixel1), .in2(pixel2),
        .clk(clk)
    );

    Ascending_Sorter_3inputs_8bits Row1(
        .min(wmin1), .mid(wmid1), .max(wmax1),
        .in0(pixel3), .in1(pixel4), .in2(pixel5),
        .clk(clk)
    );

    Ascending_Sorter_3inputs_8bits Row2(
        .min(wmin2), .mid(wmid2), .max(wmax2),
        .in0(pixel6), .in1(pixel7), .in2(pixel8),
        .clk(clk)
    );


    //STAGE 1
    Ascending_Sorter_3inputs_8bits FindMax(
        .max(wmax_col0),
        .in0(rmin0), .in1(rmin1), .in2(rmin2),        
        .clk(clk)
    );

    Ascending_Sorter_3inputs_8bits FindMid(
        .mid(wmid_col1),
        .in0(rmid0), .in1(rmid1), .in2(rmid2),        
        .clk(clk)
    );

    Ascending_Sorter_3inputs_8bits FindMin(
        .min(wmin_col2),
        .in0(rmax0), .in1(rmax1), .in2(rmax2),        
        .clk(clk)
    );

    always @(posedge clk) begin
        rmin0 <= wmin0;
        rmid0 <= wmid0;
        rmax0 <= wmax0;

        rmin1 <= wmin1;
        rmid1 <= wmid1;
        rmax1 <= wmax1;

        rmin2 <= wmin2;
        rmid2 <= wmid2;
        rmax2 <= wmax2;

        rmax_col0 <= wmax_col0;
        rmid_col1 <= wmid_col1;
        rmin_col2 <= wmin_col2;
    end

    
    
    // assign max_col0 = (rmin0 > rmin1) ? ((rmin0 > rmin2) ? rmin0 : rmin2) : ((rmin1 > rmin2) ? rmin1 : rmin2);

    // assign mid_col1 = (rmid0 > rmid1) ? 
    //              ((rmid1 > rmid2) ? rmid1 : ((rmid0 > rmid2) ? rmid2 : rmid0)) : 
    //              ((rmid0 > rmid2) ? rmid0 : ((rmid1 > rmid2) ? rmid2 : rmid1));
        
    // assign min_col2 = (rmax0 < rmax1) ? ((rmax0 < rmax2) ? rmax0 : rmax2) : ((rmax1 < rmax2) ? rmax1 : rmax2);


    Ascending_Sorter_3inputs_8bits FindMedian(
        .mid(median_pixel),
        .in0(rmax_col0), .in1(rmid_col1), .in2(rmin_col2),
        .clk(clk)
    );

endmodule