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
For Post Layout simulation run the following commands.
### Post layout simulation
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

### Sequence Detector Schematic

![image](https://user-images.githubusercontent.com/110079770/181251319-57254d76-186c-4490-a19e-2428facf1718.png)

### Functional Simulation

![image](https://user-images.githubusercontent.com/110079770/181252206-2a645809-c2cc-4d8a-adb9-218b9dda75ee.png)


