# read design

read_verilog iiitb_sd_fsm.v

# generic synthesis
synth -top iiitb_sd_fsm

# mapping to mycells.lib
dfflibmap -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -assert synth_iiitb_sd_fsm.v
