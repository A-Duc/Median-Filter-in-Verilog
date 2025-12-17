`timescale 1ns / 1ps
`include "Ascending_Sorter_3inputs_8bits.v"

module tb_Ascending_Sorter_3inputs_8bits;

    // Inputs
    reg [7:0] in0, in1, in2;
    
    // Outputs
    wire [7:0] min, mid, max;
    
    // Instantiate the Unit Under Test (UUT)
    Ascending_Sorter_3inputs_8bits uut (
        .min(min),
        .mid(mid),
        .max(max),
        .in0(in0),
        .in1(in1),
        .in2(in2)
    );
    
    // Test variables
    integer i;
    
    initial begin
        // Display header
        $display("========================================");
        $display("  Testbench: Ascending Sorter (3 inputs, 8-bit)");
        $display("========================================");
        $display("Time\t in0\t in1\t in2\t | min\t mid\t max");
        $display("----------------------------------------");
        
        // Test case 1: Already sorted (ascending)
        in0 = 8'd3; in1 = 8'd5; in2 = 8'd7;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 2: Reverse sorted (descending)
        in0 = 8'd1; in1 = 8'd2; in2 = 8'd3;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 3: Random order
        in0 = 8'd45; in1 = 8'd12; in2 = 8'd78;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 4: All equal
        in0 = 8'd55; in1 = 8'd55; in2 = 8'd55;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 5: Two equal, one different (smaller)
        in0 = 8'd15; in1 = 8'd40; in2 = 8'd40;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 6: Two equal, one different (larger)
        in0 = 8'd90; in1 = 8'd30; in2 = 8'd30;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 7: Minimum values
        in0 = 8'd0; in1 = 8'd0; in2 = 8'd0;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 8: Maximum values
        in0 = 8'd255; in1 = 8'd255; in2 = 8'd255;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 9: Mixed boundary values
        in0 = 8'd0; in1 = 8'd128; in2 = 8'd255;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 10: Random test
        in0 = 8'd66; in1 = 8'd22; in2 = 8'd88;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 11: in0=min, in1=mid, in2=max
        in0 = 8'd5; in1 = 8'd50; in2 = 8'd100;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 12: in0=min, in2=mid, in1=max
        in0 = 8'd7; in1 = 8'd200; in2 = 8'd77;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 13: in1=min, in0=mid, in2=max
        in0 = 8'd60; in1 = 8'd15; in2 = 8'd150;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 14: in1=min, in2=mid, in0=max
        in0 = 8'd220; in1 = 8'd33; in2 = 8'd111;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 15: in2=min, in0=mid, in1=max
        in0 = 8'd80; in1 = 8'd190; in2 = 8'd9;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 16: in2=min, in1=mid, in0=max
        in0 = 8'd240; in1 = 8'd95; in2 = 8'd1;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 17: in0=in1, both smaller than in2
        in0 = 8'd40; in1 = 8'd40; in2 = 8'd80;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 18: in0=in2, both smaller than in1
        in0 = 8'd35; in1 = 8'd99; in2 = 8'd35;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 19: in1=in2, both smaller than in0
        in0 = 8'd180; in1 = 8'd70; in2 = 8'd70;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 20: in0=in1, both larger than in2
        in0 = 8'd125; in1 = 8'd125; in2 = 8'd20;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 21: in0=in2, both larger than in1
        in0 = 8'd145; in1 = 8'd50; in2 = 8'd145;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 22: in1=in2, both larger than in0
        in0 = 8'd18; in1 = 8'd200; in2 = 8'd200;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 23: Consecutive numbers
        in0 = 8'd100; in1 = 8'd101; in2 = 8'd102;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 24: Large gap between values
        in0 = 8'd2; in1 = 8'd127; in2 = 8'd250;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 25: Powers of 2
        in0 = 8'd64; in1 = 8'd16; in2 = 8'd128;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 26: Near boundary (low)
        in0 = 8'd1; in1 = 8'd2; in2 = 8'd3;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 27: Near boundary (high)
        in0 = 8'd253; in1 = 8'd254; in2 = 8'd255;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 28: Mid-range values
        in0 = 8'd120; in1 = 8'd135; in2 = 8'd128;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 29: 0 with non-zero values
        in0 = 8'd0; in1 = 8'd75; in2 = 8'd150;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 30: 255 with non-max values
        in0 = 8'd100; in1 = 8'd255; in2 = 8'd50;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 31: Prime numbers
        in0 = 8'd97; in1 = 8'd53; in2 = 8'd149;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 32: Fibonacci-like numbers
        in0 = 8'd89; in1 = 8'd144; in2 = 8'd55;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 33: Multiple of 10
        in0 = 8'd90; in1 = 8'd30; in2 = 8'd60;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 34: Odd numbers
        in0 = 8'd73; in1 = 8'd29; in2 = 8'd171;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        // Test case 35: Even numbers
        in0 = 8'd84; in1 = 8'd166; in2 = 8'd42;
        #10;
        $display("%0t\t %d\t %d\t %d\t | %d\t %d\t %d", $time, in0, in1, in2, min, mid, max);
        
        $display("========================================");
        $display("  Total Test Cases: 35");
        $display("  Test completed!");
        $display("========================================");
        
        $finish;
    end
    
endmodule
