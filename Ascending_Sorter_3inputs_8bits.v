//`include "Comparator_8bits.v"

module Ascending_Sorter_3inputs_8bits(min, mid, max, 
                                      in0, in1, in2,
                                      clk);
    
    input   wire        clk;
    input   wire [7:0]  in0, in1, in2;
    output  reg  [7:0]  min, mid, max;

    reg [7:0] rin0, rin1, rin2;
    reg [7:0] cmp0, cmp1, cmp2;  //0: in0 < in1?; 1:in1 < in2?; in0 < in2? 

    always @(posedge clk) begin
        //STAGE 0
        rin0 <= in0;
        rin1 <= in1;
        rin2 <= in2;

        cmp0 <= (in0 < in1);
        cmp1 <= (in1 < in2);
        cmp2 <= (in0 < in2);

        //STAGE 1

        if (cmp0) begin
            if (cmp2) min <= rin0;
            else min <= rin2;

            if (cmp1) begin
                mid <= rin1;
                max <= rin2;
            end
            else begin
                mid <= rin2;
                max <= rin1;
            end
        end
        else begin
            if (cmp1) min = rin1;
            else min = rin2;

            if (cmp2) begin
                mid <= rin0;
                max <= rin2;
            end
            else begin
                mid <= rin2;
                max <= rin0;
            end
        end

    end


    // always@(posedge clk) begin
    //     min <= (in0 < in1) ? ((in0 < in2) ? in0 : in2) : ((in1 < in2) ? in1 : in2);
    //     max <= (in0 > in1) ? ((in0 > in2) ? in0 : in2) : ((in1 > in2) ? in1 : in2);
    //     mid <= (in0 > in1) ? 
    //            ((in1 > in2) ? in1 : ((in0 > in2) ? in2 : in0)) : 
    //            ((in0 > in2) ? in0 : ((in1 > in2) ? in2 : in1));
    // end

    
endmodule