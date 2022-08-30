`timescale 1ns / 1ps
// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for Sequence Detector using Moore FSM
// Verilog Testbench for Sequence Detector using Moore FSM 
module iiitb_sd_fsm_tb;

 // Inputs
 reg sequence_in;
 reg clock;
 reg reset;

 // Outputs
 wire detector_out;

 // Instantiate the Sequence Detector using Moore FSM
 iiitb_sd_fsm uut (
  .sequence_in(sequence_in), 
  .clock(clock), 
  .reset(reset), 
  .detector_out(detector_out)
 );
 initial begin
 clock = 0;
  $dumpfile("sd_fsm.vcd");
 $dumpvars(0);
 forever #5 clock = ~clock;
 end 
 initial #200 $finish;  
 initial begin
  // Initialize Inputs
  sequence_in = 0;
  reset = 1;

  #10;reset = 0;
  
  #10;sequence_in = 1;
  #10; sequence_in = 0;
  #10; sequence_in = 1; 
  #10;sequence_in = 1; 
  #10;sequence_in = 1; 
  #10;sequence_in =0;
 
  // Add stimulus here

 end

endmodule
