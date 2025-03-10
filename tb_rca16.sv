`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 23:53:55
// Design Name: 
// Module Name: tb_rca16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module tb_rca16;
// Declare inputs and outputs
logic [15:0] A, B;  
logic        cin;   
logic [15:0] s;    
logic        co;   

// Expected output
logic [16:0] expected_sum;

// Instantiate the DUT (Device Under Test)
rca_16 l1 (A, B, cin, s, co);

// Task for running a test case
task run_test(input logic [15:0] a, input logic [15:0] b, input logic c);
begin
A   = a;
B   = b;
cin = c;
#10; // Wait for results

expected_sum = A + B + cin; // Compute expected result

// Assertions
assert (s == expected_sum[15:0]) else
$error("Mismatch: A=%b, B=%b, Cin=%b, Expected Sum=%b, Got Sum=%b", A, B, cin, expected_sum[15:0], s);

assert (co == expected_sum[16]) else
$error("Mismatch: A=%b, B=%b, Cin=%b, Expected Cout=%b, Got Cout=%b", A, B, cin, expected_sum[16], co);
end
endtask

// Constrained Random Testing
task constrained_random_test();
begin
repeat (10) begin // Run 10 random tests
A   = $random; 
B   = $random;
cin = $random % 2; // Ensure cin is 0 or 1
#10;

expected_sum = A + B + cin;

// Assertions
assert (s == expected_sum[15:0]) else
$error("Random Test Mismatch: A=%b, B=%b, Cin=%b, Expected Sum=%b, Got Sum=%b", A, B, cin, expected_sum[15:0], s);

assert (co == expected_sum[16]) else
$error("Random Test Mismatch: A=%b, B=%b, Cin=%b, Expected Cout=%b, Got Cout=%b", A, B, cin, expected_sum[16], co);
end
end
endtask

// Directed Test Cases (Corner Cases)
task directed_test_cases();
begin
// Zero Case
run_test(16'b0000000000000000, 16'b0000000000000000, 0); // 0 + 0 + 0 = 0

// Overflow Case
run_test(16'b1111111111111111, 16'b0000000000000001, 0); // Max + 1 -> Overflow
run_test(16'b1111111111111111, 16'b1111111111111111, 1); // Max + Max + 1 -> Max Overflow

// Arbitrary Values
run_test(16'b0000000000000001, 16'b0000000000000010, 1); // 1 + 2 + 1 = 4
run_test(16'b1010101010101010, 16'b0101010101010101, 0); // Patterned inputs
end
endtask

// Test Sequence
initial begin
$display("Starting Directed Test Cases...");
directed_test_cases();
$display("Directed Tests Completed.");

$display("Starting Constrained Random Testing...");
constrained_random_test();
$display("Random Tests Completed.");

$display("All Tests Finished.");
$stop;
end
endmodule

