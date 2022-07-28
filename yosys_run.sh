# read design

read_verilog iiitb_sd_fsm.v

# generic synthesis
synth -top iiitb_sd_fsm

# mapping to mycells.lib
dfflibmap -liberty /usr/local/share/qflow/tech/osu018/osu018_stdcells.lib
abc -liberty /usr/local/share/qflow/tech/osu018/osu018_stdcells.lib
clean
flatten
# write synthesized design
write_verilog -assert synth_iiitb_sd_fsm.v
