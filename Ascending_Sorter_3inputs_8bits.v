//`include "Comparator_8bits.v"

module Ascending_Sorter_3inputs_8bits(min, mid, max, 
                                      in0, in1, in2,
                                      clk);
    
    input   wire        clk;
    input   wire [7:0]  in0, in1, in2;
    output  reg  [7:0]  min, mid, max;

    //reg     [7:0] rin0, rin1, rin2;
    wire cmp0, cmp1, cmp2;  //0: in0 < in1?; 1:in1 < in2?; in0 < in2? 

    assign cmp0 = (in0 < in1);
    assign cmp1 = (in1 < in2);
    assign cmp2 = (in2 < in0);

    always @(posedge clk) begin
        if (cmp0) begin
            if (cmp2) begin
                min <= in2;
                mid <= in0;
                max <= in1;
            end
            else begin
                min <= in0;
                if (cmp1) begin
                    max <= in2;
                    mid <= in1;
                end
                else begin
                    max <= in1;
                    mid <= in2;
                end
            end
        end
        else begin
            if (cmp1) begin
                min <= in1;
                if (cmp2) begin
                    mid <= in2;
                    max <= in0;
                end
                else begin
                    mid <= in0;
                    max <= in2;
                end
            end
            else begin
                min <= in2;
                mid <= in1;
                max <= in0;
            end
        end
    end 

endmodule