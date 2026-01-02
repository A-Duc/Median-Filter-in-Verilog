module Ascending_Sorter_3inputs_8bits(
    output reg  [7:0] min, mid, max, 
    input  wire [7:0] in0, in1, in2,
    input  wire       clk,
    input  wire       reset,
    input  wire       enable 
);
    reg [7:0] rin0, rin1, rin2;
    reg       cmp0, cmp1, cmp2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            min <= 0; mid <= 0; max <= 0;
            rin0 <= 0; rin1 <= 0; rin2 <= 0;
            cmp0 <= 0; cmp1 <= 0; cmp2 <= 0;
        end else if (enable) begin 
            rin0 <= in0;
            rin1 <= in1;
            rin2 <= in2;
            
            cmp0 <= (in0 < in1);
            cmp1 <= (in1 < in2);
            cmp2 <= (in2 < in0);

            case ({cmp0, cmp1, cmp2})
                3'b110: begin min <= rin0; mid <= rin1; max <= rin2; end 
                3'b100: begin min <= rin0; mid <= rin2; max <= rin1; end 
                3'b010: begin min <= rin1; mid <= rin0; max <= rin2; end 
                3'b011: begin min <= rin1; mid <= rin2; max <= rin0; end 
                3'b101: begin min <= rin2; mid <= rin0; max <= rin1; end 
                3'b001: begin min <= rin2; mid <= rin1; max <= rin0; end 
                default: begin min <= rin0; mid <= rin1; max <= rin2; end
            endcase
        end
    end 
endmodule