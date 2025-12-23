//`include "Comparator_8bits.v"

module Ascending_Sorter_3inputs_8bits(min, mid, max, 
                                      in0, in1, in2,
                                      clk);
    
    input   wire        clk;
    input   wire [7:0]  in0, in1, in2;
    output  reg  [7:0]  min, mid, max;

    //reg     [7:0] st0_buf[2:0]; // [0] <- max, [1] <- min, [2] <- in2

    wire    [7:0] wC0_Max, wC0_Min;
    wire    [7:0] wC1_Max, wC1_Min;
    wire    [7:0] wC2_Max, wC2_Min;

    reg     [7:0] State0_Buf[2:0];
    reg     [7:0] State1_Buf[2:0];



    Comparator_8bits C0(.Max(wC0_Max), .Min(wC0_Min),
                        .A(in0), .B(in1));

    Comparator_8bits C1(.Max(wC1_Max), .Min(wC1_Min),
                        .A(State0_Buf[0]), .B(State0_Buf[2]));

    Comparator_8bits C2(.Max(wC2_Max), .Min(wC2_Min),
                        .A(State1_Buf[1]), .B(State1_Buf[2]));

    always @(posedge clk) begin
        State0_Buf[0] <= wC0_Max;
        State0_Buf[1] <= wC0_Min;
        State0_Buf[2] <= in2;

        State1_Buf[0] <= wC1_Max;
        State1_Buf[1] <= wC1_Min;
        State1_Buf[2] <= State0_Buf[1];

        max <= State1_Buf[0];
        mid <= wC2_Max;
        min <= wC2_Min;

    end


    // always@(posedge clk) begin
    //     min <= (in0 < in1) ? ((in0 < in2) ? in0 : in2) : ((in1 < in2) ? in1 : in2);
    //     max <= (in0 > in1) ? ((in0 > in2) ? in0 : in2) : ((in1 > in2) ? in1 : in2);
    //     mid <= (in0 > in1) ? 
    //            ((in1 > in2) ? in1 : ((in0 > in2) ? in2 : in0)) : 
    //            ((in0 > in2) ? in0 : ((in1 > in2) ? in2 : in1));
    // end

    
endmodule