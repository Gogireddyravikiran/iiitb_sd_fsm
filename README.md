# iiitb_sd_fsm --- sequence detector(1011) using moore finite state machine
Sequence Detector Using Moore State Machine
Here I have implemented the Moore finite state machine sequence detector “1011”. Where the Moore finite state machine keeps detecting the digital input and the output of the fsm goes only high when the sequence is detected I.e., “1011”. In Moore fsm output depends only on the present state logic but not on the present input So in this 
case we need the extra state to represent the ouput.Here when the sequence is detected at the input the output will represent as a 1. Whereas the next state logic is dependent upon the present input also on the present state. Here I used “1011” as a pattern when the input sequence is detected as a 1011 then the we see output as 1. 
Here I performed a overlapping sequence to detect the pattern “1011”.

### Cloning my verilog files from my github repository

To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.

```
$  sudo apt install -y git
$  git clone https://github.com/Gogireddyravikiran/iiitb_sd_fsm
$  cd iiitb_sd_fsm
```
For Functional simulation run the following commands.
### Functional simulation
```
$  iverilog -o sd_fsm sd_fsm.v sd_fsm_tb.v
$  ./sd_fsm
```
To see the ouput waveform run the following commands 
```
$ ./sd_fsm
$ gtkwave sd_fsm.vcd
```
### Block Diagram of a Sequence Detector 

![image](https://user-images.githubusercontent.com/110079770/181257307-184f6c8b-5652-448f-bb94-62c3e6001dfc.png)

### State Machine Diagram

![image](https://user-images.githubusercontent.com/110079770/181293333-3024d38c-ec1c-4e90-8b31-5f0466b9c4fa.png)

### Sequence Detector Schematic

![image](https://user-images.githubusercontent.com/110079770/181251319-57254d76-186c-4490-a19e-2428facf1718.png)

### Simulation Waveform

![image](https://user-images.githubusercontent.com/110079770/181252206-2a645809-c2cc-4d8a-adb9-218b9dda75ee.png)

### Synthesizing Verilog Code
#### About Yosys 
##### This is a framework for RTL synthesis tools. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.

Yosys can be adapted to perform any synthesis job by combining the existing passes (algorithms) using synthesis scripts and adding additional passes as needed by extending the yosys C++ code base.

Yosys is free software licensed under the ISC license (a GPL compatible license that is similar in terms to the MIT license or the 2-clause BSD license).
#####
### Yosys Installing Commands 
```
sudo apt-get update
sudo apt-get -y install yosys
```
### Commands for Synthesizig the verilog code 
```
read_verilog iiitb_sd_fsm.v

# generic synthesis
synth -top iiitb_sd_fsm

# mapping to mycells.lib
dfflibmap -liberty /home/gogireddyravikiranreddy1/Desktop/iiitb_sd_fsm/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/gogireddyravikiranreddy1/Desktop/iiitb_sd_fsm/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten

# write synthesized design
write_verilog -noattr iiitb_sd_fsm_synth.v

```

# Gate level Simulation Commands
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_sd_fsm_synth.v iiitb_sd_fsm_tb.v
./a.out --> For Generating the vcd file.
gtkwave sd_fsm.vcd
```
# Gate level Simulation Waveform
![image](https://user-images.githubusercontent.com/110079770/184317847-0cd052d7-97f2-45e6-b391-2ca74f033861.png)

# Observation on Gate Level Simulation Waveform
```
I observed that Pre Level Simulation and Post Level Simulation Waveforms are matched.
```

## Contributors 

- **GogiReddy Ravi Kiran Reddy** 
- **Kunal Ghosh** 



## Acknowledgments

- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information

- GogiReddy Ravi Kiran Reddy, Postgraduate Student, International Institute of Information Technology, Bangalore.
- Email: gogireddyravikiranreddy1@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
