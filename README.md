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
git clone https://github.com/YosysHQ/yosys.git
make
sudo make install make test
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
# Statistics 
```
 Printing statistics.

=== iiitb_sd_fsm ===

   Number of wires:                 19
   Number of wire bits:             19
   Number of public wires:          10
   Number of public wire bits:      10
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 16
     sky130_fd_sc_hd__a21o_2         1
     sky130_fd_sc_hd__a2bb2oi_2      1
     sky130_fd_sc_hd__and2b_2        1
     sky130_fd_sc_hd__and3b_2        1
     sky130_fd_sc_hd__buf_1          1
     sky130_fd_sc_hd__dfrtp_2        3
     sky130_fd_sc_hd__inv_2          3
     sky130_fd_sc_hd__nand2_2        1
     sky130_fd_sc_hd__nand3b_2       1
     sky130_fd_sc_hd__nor2_2         1
     sky130_fd_sc_hd__o211a_2        1
     sky130_fd_sc_hd__o21ba_2        1
```
# Synthesized Model

![image](https://user-images.githubusercontent.com/110079770/184836574-d4e8436e-fec2-4e72-855f-f4b55c1177d6.png)

Now the synthesized netlist is written in "iiitb_sd_fsm_synth.v" file.
### GATE LEVEL SIMULATION(GLS)
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met.

# Gate level Simulation Commands
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_sd_fsm_synth.v iiitb_sd_fsm_tb.v
./a.out --> For Generating the vcd file.
gtkwave sd_fsm.vcd
```

# Gate level Simulation Waveform
![image](https://user-images.githubusercontent.com/110079770/184317847-0cd052d7-97f2-45e6-b391-2ca74f033861.png)

The gtkwave output for the netlist should match the output waveform for the RTL design file. As netlist and design code have same set of inputs and outputs, we can use the same testbench and compare the waveforms.

# Observation on Gate Level Simulation Waveform
```
I observed that Pre Level Simulation and Post Level Simulation Waveforms are matched.
```

## Final Layout
#### Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

more at https://github.com/The-OpenROAD-Project/OpenLane
#### Installation instructions 
```
$   apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

goto home directory->
```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane/
$   sudo make
```
To test the open lane
```
$ sudo make test
```
It takes approximate time of 5min to complete. After 43 steps, if it ended with saying **Basic test passed** then open lane installed succesfully.

#### Magic
Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

More about magic at http://opencircuitdesign.com/magic/index.html

Run following commands one by one to fulfill the system requirement.

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
**To install magic**
goto home directory

```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic/
$   ./configure
$   sudo make
$   sudo make install
```
type **magic** terminal to check whether it installed succesfully or not. type **exit** to exit magic.

**Generating Layout**

Open terminal in home directory
```
$   cd OpenLane/
$   cd designs/
$   mkdir iiitb_pwm_gen
$   cd iiitb_pwm_gen/
$   wget https://raw.githubusercontent.com/Gogireddyravikiran/iiitb_sd_fsm/main/config.json
$   mkdir src
$   cd src/
$   wget https://raw.githubusercontent.com/Gogireddyravikiran/iiitb_sd_fsm/main/iiitb_sd_fsm.v
$   cd ../../../
$   sudo make mount
$   ./flow.tcl -design iiitb_sd_fsm
```
![image](https://user-images.githubusercontent.com/110079770/186616596-225a7778-462f-48ca-be30-34dfcfc58466.png)
To see the layout we use a tool called magic which we installed earlier.
open terminal in home directory
```
$   cd OpenLane/designs/iiitb_pwm_gen/run
$   ls
```
select most run directoy from list 


example:
![image](https://user-images.githubusercontent.com/110079770/186617049-be127141-995b-4d80-8a12-4b6d3e251ee5.png)


```
$  cd RUN_2022.08.21_10.59.29
```
run following instruction
```
$   cd results/final/def
```
update the highlited text with appropriate path

```
$ magic -T /home/ravi/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read iiitb_sd_fsm.def &
```

layout will be open in new window
#### layout

![image](https://user-images.githubusercontent.com/110079770/186617634-1572ed91-f4a6-4ef4-a76e-0c3fb63dd876.png)

## Future work:
working on **GLS for post-layout netlist**.

## Contributors 

- **GogiReddy Ravi Kiran Reddy** 
- **Kunal Ghosh** 



## Acknowledgments

- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information

- GogiReddy Ravi Kiran Reddy, Postgraduate Student, International Institute of Information Technology, Bangalore.
- Email: gogireddyravikiranreddy1@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
