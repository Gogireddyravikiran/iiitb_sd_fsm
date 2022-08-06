# read design

read_verilog iiitb_sd_fsm.v

# generic synthesis
synth -top iiitb_sd_fsm

# mapping to mycells.lib
dfflibmap -liberty /home/ravi/iiitb_sd_fsm/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ravi/iiitb_sd_fsm/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
flatten
# write synthesized design
write_verilog -noattr iiitb_sd_fsm_synth.v

