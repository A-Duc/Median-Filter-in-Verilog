//`include "Comparator_8bits.v"

module Ascending_Sorter_3inputs_8bits(min, mid, max, 
                                      in0, in1, in2,
                                      clk);
    
    input   wire        clk;
    input   wire [7:0]  in0, in1, in2;
    output  reg  [7:0]  min, mid, max;

    reg [7:0] rin0, rin1, rin2;
    reg       cmp0, cmp1, cmp2;  //0: in0 < in1?; 1:in1 < in2?; in0 < in2? 

    always @(posedge clk) begin
        //STAGE 0
        rin0 <= in0;
        rin1 <= in1;
        rin2 <= in2;
        
        cmp0 <= (in0 < in1);
        cmp1 <= (in1 < in2);
        cmp2 <= (in2 < in0);

        // STAGE 1
        case ({cmp0, cmp1, cmp2})
            //in0 < in1 < in2
            3'b110: begin min <= rin0; mid <= rin1; max <= rin2; end 

            //in0 < in2 < in1
            3'b100: begin min <= rin0; mid <= rin2; max <= rin1; end 

            //in1 < in0 < in2
            3'b010: begin min <= rin1; mid <= rin0; max <= rin2; end 

            //in1 < in2 < in0
            3'b011: begin min <= rin1; mid <= rin2; max <= rin0; end 

            //in2 < in0 < in1
            3'b101: begin min <= rin2; mid <= rin0; max <= rin1; end 

            //in2 < in1 < in0
            3'b001: begin min <= rin2; mid <= rin1; max <= rin0; end 

            default: begin min <= rin0; mid <= rin1; max <= rin2; end
        endcase
    end 

endmodule