module Ascending_Sorter_3inputs_8bits(min, mid, max, 
                                      in0, in1, in2);
    
    input       [7:0]  in0, in1, in2;
    output  reg [7:0]  min, mid, max;

    always @(*) begin
        min = (in0 <= in1 && in0 <= in2) ? in0 : ((in1 <=in2) ? in1 : in2);
        max = (in0 >= in1 && in0 >= in2) ? in0 : ((in1 >=in2) ? in1 : in2);
        mid = in0 + in1 + in2 - max - min;
    end
    
endmodule