//`include "Comparator_8bits.v"

module Ascending_Sorter_3inputs_8bits(min, mid, max, 
                                      in0, in1, in2,
                                      clk);
    
    input   wire        clk;
    input   wire [7:0]  in0, in1, in2;
    output  reg  [7:0]  min, mid, max;

    // reg     [7:0] St0_0, St0_1, St0_2;
    // reg     [7:0] St1_0, St1_1, St1_2;

    // always @(posedge clk) begin

    //     //STAGE 0

    //     St0_2 <= in2;
    //     if (in0 < in1) begin
    //         St0_0 <= in0;
    //         St0_1 <= in1;
    //     end
    //     else begin
    //         St0_0 <= in1;
    //         St0_1 <= in0;
    //     end

    //     //STAGE 1
    //     St1_1 <= St0_1;
    //     if (St0_0 < St0_2) begin
    //         St1_0 <= St0_0;
    //         St1_2 <= St0_2;
    //     end
    //     else begin
    //         St1_0 <= St0_2;
    //         St1_2 <= St0_0;
    //     end

    //     //STAGE 3
    //     min <= St1_0;
    //     if (St1_1 < St1_2) begin
    //         mid <= St1_1;
    //         max <= St1_2;
    //     end
    //     else begin
    //         mid <= St1_2;
    //         max <= St1_1;
    //     end
    // end
    reg [7:0] rin0, rin1, rin2;
    reg       cmp0, cmp1, cmp2;  //0: in0 < in1?; 1:in1 < in2?; in0 < in2? 

    always @(posedge clk) begin
        rin0 <= in0;
        rin1 <= in1;
        rin2 <= in2;
        
        cmp0 <= (in0 < in1);
        cmp1 <= (in1 < in2);
        cmp2 <= (in2 < in0);

        if (cmp0) begin
            if (cmp2) begin
                min <= rin2;
                mid <= rin0;
                max <= rin1;
            end
            else begin
                min <= rin0;
                if (cmp1) begin
                    max <= rin2;
                    mid <= rin1;
                end
                else begin
                    max <= rin1;
                    mid <= rin2;
                end
            end
        end
        else begin
            if (cmp1) begin
                min <= rin1;
                if (cmp2) begin
                    mid <= rin2;
                    max <= rin0;
                end
                else begin
                    mid <= rin0;
                    max <= rin2;
                end
            end
            else begin
                min <= rin2;
                mid <= rin1;
                max <= rin0;
            end
        end
    end 

endmodule