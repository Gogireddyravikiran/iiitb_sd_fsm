# read design

read_verilog iiitb_sd_fsm.v

# generic synthesis
synth -top iiitb_sd_fsm

# mapping to mycells.lib
dfflibmap -liberty /home/gogireddyravikiranreddy1/Desktop/iiitb_sd_fsm/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/gogireddyravikiranreddy1/Desktop/iiitb_sd_fsm/lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -assert iiitb_sd_fsm_synth.v
