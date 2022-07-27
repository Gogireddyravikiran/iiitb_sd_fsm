`timescale 1ns / 1ps
// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for Sequence Detector using Moore FSM
// Verilog Testbench for Sequence Detector using Moore FSM 
module tb_Sequence_Detector_Moore_FSM_Verilog;

 // Inputs
 reg sequence_in;
 reg clock;
 reg reset;

 // Outputs
 wire detector_out;

 // Instantiate the Sequence Detector using Moore FSM
 Sequence_Detector_MOORE_Verilog uut (
  .sequence_in(sequence_in), 
  .clock(clock), 
  .reset(reset), 
  .detector_out(detector_out)
 );
 initial begin
 clock = 0;
 forever #5 clock = ~clock;
 end 
 initial begin
  // Initialize Inputs
  sequence_in = 0;
  reset = 1;

  #10;reset = 0;
  
  #10;sequence_in = 1;
  #10; sequence_in = 0;
  #10; sequence_in = 1; 
  #10;sequence_in = 1; 
  #10;sequence_in = 0; 
 
  // Add stimulus here

 end
      
endmodule
