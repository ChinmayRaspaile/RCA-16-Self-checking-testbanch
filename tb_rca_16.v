`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 15:31:42
// Design Name: 
// Module Name: tb_rca_16
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

module tb_rca_16;
// Declare inputs and outputs
reg  [15:0] A, B;      
reg         cin;       
wire [15:0] s;       
wire        co;       

// Expected output
reg  [16:0] expected_output;

// File handling variables
integer input_file, output_file;
integer test_count = 0, pass_count = 0, fail_count = 0;
integer scan_count;

// Instantiate the RCA-16 module
rca_16 DUT (.x(A), .y(B), .cin(cin), .s(s), .co(co));

initial begin
// Open input and output files
input_file  = $fopen("D:\\abc.txt", "r");
output_file = $fopen("D:\\xyz.txt", "w");

if (input_file == 0) begin
$display("Error: Unable to open abc.txt");
$finish;
end
if (output_file == 0) begin
$display("Error: Unable to create xyz.txt");
$finish;
end

// Write test result headers
$fwrite(output_file, "Test Case | A                 | B                 | Cin | Expected Sum       | Expected Cout | Sum               | Cout | Result\n");
$fwrite(output_file, "----------------------------------------------------------------------------------------------------------------------------\n");

// Read test vectors
while (!$feof(input_file)) begin
test_count = test_count + 1;

// Read 16-bit A, 16-bit B, 1-bit Cin, 17-bit Expected Output
scan_count = $fscanf(input_file, "%16b %16b %1b %17b\n", A, B, cin, expected_output);

// Check if the line was correctly read
if (scan_count != 4) begin
$display("Error: Incorrect data format in abc.txt. Read only %d values.", scan_count);
$stop;
end

// Debug print
$display("Read from file: A=%b, B=%b, Cin=%b, Expected Output=%b", A, B, cin, expected_output);

#10; // Allow signals to propagate

// Compare actual vs expected
if ({co, s} == expected_output) begin
pass_count = pass_count + 1;
$fwrite(output_file, "%d | %b | %b | %b | %b | %b | %b | %b | PASS\n", 
test_count, A, B, cin, expected_output[16:1], expected_output[0], s, co);
end else begin
fail_count = fail_count + 1;
$fwrite(output_file, "%d | %b | %b | %b | %b | %b | %b | %b | FAIL\n", 
test_count, A, B, cin, expected_output[16:1], expected_output[0], s, co);
end
end

// Final test summary
$fwrite(output_file, "\nTotal Tests: %d, Passed: %d, Failed: %d\n", test_count, pass_count, fail_count);
$display("Testing Completed. Check xyz.txt for results.");

// Close files
$fclose(input_file);
$fclose(output_file);
$stop;
end
endmodule
