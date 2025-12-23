module Comparator_8bits(Max, Min, A, B/*, clk*/);
    //input             clk;
    input       [7:0] A, B;
    output      [7:0] Max, Min;

    // always @(posedge clk) begin
    //     Max <= (A > B) ? A : B;
    //     Min <= (A < B) ? A : B;
    // end

    assign Max = (A > B) ? A : B;
    assign Min = (A < B) ? A : B;
endmodule