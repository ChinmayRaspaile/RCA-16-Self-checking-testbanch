# README

## Project: Self-Checking Testbench for 16-bit Ripple Carry Adder

### Overview
This project involves designing a self-checking testbench in SystemVerilog to verify the functionality of a 16-bit ripple carry adder. The verification is divided into two parts:

- **Part A:** Reads test vectors from a file (`abc.txt`), applies them to the adder, compares the output against expected results, and logs mismatches in an output file (`xyz.txt`).
- **Part B:** Implements a testbench using SystemVerilog tasks to perform **Constrained Random Testing** and **Directed Test Cases** with assertion-based verification.

---

## Part A: File-Based Verification

### Functionality:
- The testbench reads 49-bit binary test vectors from `abc.txt`, which consist of:
  - 16-bit input vector A
  - 16-bit input vector B
  - 1-bit carry-in
  - 17-bit expected output (sum and carry-out)
- These values are supplied to the **16-bit Ripple Carry Adder (RCA)**
- The computed 17-bit sum (including carry-out) is compared against the expected output
- The comparison results are logged in `xyz.txt`, indicating **pass/fail** for each test case

### File Format:
Each line in `abc.txt` contains:
```
AAAAAAAAAAAAAAAA BBBBBBBBBBBBBBBB C SSSSSSSSSSSSSSSSS
```
where:
- `A` = 16-bit input A
- `B` = 16-bit input B
- `C` = 1-bit carry-in
- `S` = 17-bit expected sum (including carry-out)

**Example Entry:**
```
0000000000000001 0000000000000010 1 0000000000000100
```

### Output File (`xyz.txt`):
Each line in `xyz.txt` logs the test result:
```
Test Vector: <A> <B> <Cin> | Expected: <Expected Sum> | Actual: <Actual Sum> | Result: PASS/FAIL
```

---

## Part B: Constrained Random & Directed Test Cases

### Features:
- Implements a **task** in SystemVerilog for executing test cases
- Uses **Constrained Random Testing** to generate test cases with randomized values within defined constraints
- Implements **Directed Testing** to cover:
  - **Overflow Cases** (maximum values, carry-out conditions)
  - **Zero Cases** (all-zero inputs)
  - **Arbitrary Cases** (specific test values for thorough verification)
- Uses **assertions** to verify correctness and catch unexpected results

### Testing Approaches:
1. **Constrained Random Testing:**
   - Generates random values for A, B, and carry-in, ensuring full test coverage
   - Checks expected sum and carry-out correctness using assertions
2. **Directed Testing:**
   - Manually defines edge cases (e.g., all ones, all zeros, mid-range values)
   - Verifies behavior under known conditions

---

## How to Run
1. Compile and simulate the testbench using a SystemVerilog simulator (e.g., **Vivado, QuestaSim, ModelSim**)
2. Ensure `abc.txt` is in the working directory
3. Run the simulation
4. Check `xyz.txt` for results

---

## Dependencies
- SystemVerilog simulator (e.g., **Vivado 2016**, **QuestaSim**, **ModelSim**)
- 16-bit Ripple Carry Adder module

---

## Expected Outcome
- The testbench should correctly verify the adder using **file-based testing** and **constrained random + directed testing**
- The results should be logged and mismatches should be reported in `xyz.txt`

---

## Author
- **Your Name**
- **Date**: March 2025

