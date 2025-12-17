`include "Ascending_Sorter_3inputs_8bits.v"

module Median_Finder_9inputs_8bits(
    output wire [7:0] median_pixel,
    input  wire [7:0] pixel0, pixel1, pixel2,
    input  wire [7:0] pixel3, pixel4, pixel5,
    input  wire [7:0] pixel6, pixel7, pixel8
);

    wire [7:0] min0, mid0, max0;
    wire [7:0] min1, mid1, max1;
    wire [7:0] min2, mid2, max2;

    wire [7:0] max_col0, mid_col1, min_col2;

    Ascending_Sorter_3inputs_8bits Row0(
        .min(min0), .mid(mid0), .max(max0),
        .in0(pixel0), .in1(pixel1), .in2(pixel2)
    );

    Ascending_Sorter_3inputs_8bits Row1(
        .min(min1), .mid(mid1), .max(max1),
        .in0(pixel3), .in1(pixel4), .in2(pixel5)
    );

    Ascending_Sorter_3inputs_8bits Row2(
        .min(min2), .mid(mid2), .max(max2),
        .in0(pixel6), .in1(pixel7), .in2(pixel8)
    );

    

    Ascending_Sorter_3inputs_8bits FindMax(
        .max(max_col0),
        .in0(min0), .in1(min1), .in2(min2)
    );

    Ascending_Sorter_3inputs_8bits FindMid(
        .mid(mid_col1),
        .in0(mid0), .in1(mid1), .in2(mid2)
    );

    Ascending_Sorter_3inputs_8bits FindMin(
        .min(min_col2),
        .in0(max0), .in1(max1), .in2(max2)
    );



    Ascending_Sorter_3inputs_8bits FindMedian(
        .mid(median_pixel),
        .in0(max_col0), .in1(mid_col1), .in2(min_col2)
    );

endmodule