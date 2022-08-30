# iiitb_sd_fsm --- sequence detector(10111) using moore finite state machine

# Table of contents
 - [1.Sequence Detector(10111) Using Moore State Machine](#1-Sequence-Detector-(10111)-Using-Moore-State-Machine)
 - [2.Block Diagram of a Sequence Detector](#2-Block-Diagram-of-a-Sequence-Detector)
 - [3.State Machine Diagram](#3-State-Machine-Diagram)
 - [4.Sequence Detector Schematic](#4-Sequence-Detector-Schematic)
 - [5.Simulation Waveform](#5-Simulation-Waveform)
 - [6.Synthesizing Verilog Code](#6-Synthesizing-Verilog-Code)
   - [6.1 About Yosys](#61-About-Yosys)
   - [6.2 Statistics](#62-Statistics)
   - [6.3. Synthesized Model](#63-Synthesized Model)
   - [6.4. GATE LEVEL SIMULATION(GLS)](#6.4.-GATE-LEVEL-SIMULATION(GLS))
   - [6.5. Gate level Simulation Waveform](#6.5.-Gate-level-Simulation-Waveform)
 - [7. Physical Design from Netlist to GDSII](#7.-Physical-Design-from-Netlist-to-GDSII)
   - [7.1. Physical design flow](#7.1.-Physical-design-flow)
   - [7.2. Openlane](#7.2.-Openlane)
   - [7.3. Magic](#7.3.-Magic)
   - [7.4. layout](#7.4.-layout)
   
   
 
   
## 1. Sequence Detector(10111) Using Moore State Machine

   -Here I have implemented the Moore finite state machine sequence detector “10111”. Where the Moore finite state machine keeps detecting the digital input and the output of the fsm goes only high when the sequence is detected I.e., “10111”. In Moore fsm output depends only on the present state logic but not on the present input So in this 
   -case we need the extra state to represent the ouput.Here when the sequence is detected at the input the output will represent as a 1. Whereas the next state logic is dependent upon the present input also on the present state. Here I used “10111” as a pattern when the input sequence is detected as a 10111 then the we see output as 1. 
   -Here I performed a overlapping sequence to detect the pattern “10111”.

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
$  iverilog -o iiitb_sd_fsm iiitb_sd_fsm.v iiitb_sd_fsm_tb.v
```
To see the ouput waveform run the following commands 
```
$ ./sd_fsm
$ gtkwave sd_fsm.vcd
```
## 2. Block Diagram of a Sequence Detector 

![image](https://user-images.githubusercontent.com/110079770/181257307-184f6c8b-5652-448f-bb94-62c3e6001dfc.png)

## 3. State Machine Diagram

![image](https://user-images.githubusercontent.com/110079770/181293333-3024d38c-ec1c-4e90-8b31-5f0466b9c4fa.png)

## 4. Sequence Detector Schematic

![image](https://user-images.githubusercontent.com/110079770/181251319-57254d76-186c-4490-a19e-2428facf1718.png)

## 5. Simulation Waveform

![image](https://user-images.githubusercontent.com/110079770/187498122-39662fdc-dc70-46f3-aa53-e641c09b8493.png)

## 6. Synthesizing Verilog Code
### 6.1 About Yosys 
#### This is a framework for RTL synthesis tools. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.

Yosys can be adapted to perform any synthesis job by combining the existing passes (algorithms) using synthesis scripts and adding additional passes as needed by extending the yosys C++ code base.

Yosys is free software licensed under the ISC license (a GPL compatible license that is similar in terms to the MIT license or the 2-clause BSD license).

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
### 6.2 Statistics 
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
### 6.3. Synthesized Model

![image](https://user-images.githubusercontent.com/110079770/184836574-d4e8436e-fec2-4e72-855f-f4b55c1177d6.png)

Now the synthesized netlist is written in "iiitb_sd_fsm_synth.v" file.

### 6.4. GATE LEVEL SIMULATION(GLS)
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met.

### Gate level Simulation Commands
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_sd_fsm_synth.v iiitb_sd_fsm_tb.v
./a.out --> For Generating the vcd file.
gtkwave sd_fsm.vcd
```

### 6.5. Gate level Simulation Waveform

![image](https://user-images.githubusercontent.com/110079770/184317847-0cd052d7-97f2-45e6-b391-2ca74f033861.png)

The gtkwave output for the netlist should match the output waveform for the RTL design file. As netlist and design code have same set of inputs and outputs, we can use the same testbench and compare the waveforms.

## Observation on Gate Level Simulation Waveform
```
I observed that Pre Level Simulation and Post Level Simulation Waveforms are matched.
```

## 7. Physical Design from Netlist to GDSII

Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t power, performance and area.

### 7.1. Physical design flow

![image](https://user-images.githubusercontent.com/110079770/187488471-0b9b639a-e75e-4b4d-8ce9-be046b5ca7d8.png)

Below are the stages and the respective tools that are called by openlane for the functionalities as described:
- Synthesis
  - Generating gate-level netlist ([yosys](https://github.com/YosysHQ/yosys)).
  - Performing cell mapping ([abc](https://github.com/YosysHQ/yosys)).
  - Performing pre-layout STA ([OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA)).
- Floorplanning
  - Defining the core area for the macro as well as the cell sites and the tracks ([init_fp](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/src/init_fp)).
  - Placing the macro input and output ports ([ioplacer](https://github.com/The-OpenROAD-Project/ioPlacer/)).
  - Generating the power distribution network ([pdn](https://github.com/The-OpenROAD-Project/pdn/)).
- Placement
  - Performing global placement ([RePLace](https://github.com/The-OpenROAD-Project/RePlAce)).
  - Perfroming detailed placement to legalize the globally placed components ([OpenDP](https://github.com/The-OpenROAD-Project/OpenDP)).
- Clock Tree Synthesis (CTS)
  - Synthesizing the clock tree ([TritonCTS](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/src/TritonCTS)).
- Routing
  - Performing global routing to generate a guide file for the detailed router ([FastRoute](https://github.com/The-OpenROAD-Project/FastRoute/tree/openroad)).
  - Performing detailed routing ([TritonRoute](https://github.com/The-OpenROAD-Project/TritonRoute))
- GDSII Generation
  - Streaming out the final GDSII layout file from the routed def ([Magic](https://github.com/RTimothyEdwards/magic)).
 
### 7.2. Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

### Installation instructions 
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

 ### 7.3. Magic
 
   - Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

       -More about magic at http://opencircuitdesign.com/magic/index.html

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

**Generating Layout without including sky130_vsdinv cell**

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
$   cd OpenLane/designs/iiitb_sd_fsm/run
$   ls
```

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
$ magic -T /home/ravi/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../../tmp/merged.lef def read iiitb_sd_fsm.def &
```

### 7.4. layout

![image](https://user-images.githubusercontent.com/110079770/186617634-1572ed91-f4a6-4ef4-a76e-0c3fb63dd876.png)

**7.5. Generating Layout including sky130_vsdinv cell** 

## cloning vsdstdcelldesign
![image](https://user-images.githubusercontent.com/110079770/187428747-42f21a1b-f9e0-4513-bd8c-b9659c51ebdf.png)

![image](https://user-images.githubusercontent.com/110079770/187428964-47e49902-86f2-4b22-8e13-f4cf11999d78.png)

copy the sky130A.tech to vsdcelldesign directory and type the following command to see the inverter layout in magic tool.
```
magic -T sky130A.tech sky130A_inv.mag &
```

**7.6. layout of the inverter cell**

![image](https://user-images.githubusercontent.com/110079770/187430507-2b58bfab-51c9-4ce8-a8ec-2512a39e41eb.png)

**Generating the sky130_vsdinv.lef file**

In tkcon terminal type the following command

```
lef write sky130_vsdinv.lef
```

![image](https://user-images.githubusercontent.com/110079770/187432194-96f62f6a-1a1b-4ad3-8051-5b8691e8f9ee.png)

Move the ```sky130_fd_sc_hd__fast.lib```,```sky130_fd_sc_hd__slow.lib```,```sky130_fd_sc_hd__typical.lib```,```sky130_vsdinv.lef``` files to your design ```src``` folder.

![image](https://user-images.githubusercontent.com/110079770/187434721-b6ed028b-d11d-49d8-9f1e-7669850ea7fb.png)


 Invoking openlane by following command.
 ```
 sudo make mount
 ```
![image](https://user-images.githubusercontent.com/110079770/187435635-40600f38-a170-42c2-a588-cb6c37309baf.png)

Run the following commands.
```
$ ./flow.tcl -interactive
% package require openlane 0.9
% prep -design iiitb_sd_fsm
These commands are used for reading the sky130_vsdinv.lef file
% set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
% add_lefs -src $lefs
```
** Reading the design

![image](https://user-images.githubusercontent.com/110079770/187437201-8fc0450d-a698-4113-bb07-cc7739bc63b6.png)

**Include the following the commands in the flow **

![image](https://user-images.githubusercontent.com/110079770/187438660-ebb10bd2-f258-4a20-b8c5-d722879026ca.png)

**7.7. Run_synthesis**

### Type the following command to run synthesis
```
run_synthesis
```

![image](https://user-images.githubusercontent.com/110079770/187439015-10842717-996c-4828-a1bc-dc297aeb32c7.png)

Printing Statistics

**7.8. Pre Synthesis stats

![image](https://user-images.githubusercontent.com/110079770/187440049-2fa68e81-0cf4-422c-9b34-f6ce8a853d2e.png)

**7.9. Post Synthesis stats

![image](https://user-images.githubusercontent.com/110079770/187439774-d9e9be3f-a339-4160-b340-261fa5bf1835.png)

**8. Floorplan**

### Type the following command to run Floorplan

```
run_floorplan
```
![image](https://user-images.githubusercontent.com/110079770/187440482-eda3788f-8d89-4b45-a3c9-4b2572b32bd0.png)

**8.1. Floorplanning

![image](https://user-images.githubusercontent.com/110079770/187441458-e5c844b0-e7d4-41c0-be04-c99cd7b54f7e.png)

**9. Placement**

Type the following command to run placement
```
run_placement
```

![image](https://user-images.githubusercontent.com/110079770/187442337-2f2f9caf-9fe2-4573-86e1-942e9ed2f538.png)

### 9.1. placement

![image](https://user-images.githubusercontent.com/110079770/187443047-0d23f760-d020-41f5-ab41-1b5c880db491.png)

**10. CTS**
Type the following command to run placement
```
run_cts
```
## cts reports

![image](https://user-images.githubusercontent.com/110079770/187494237-864cbb0c-5945-42e3-a7a9-61be43f5f5fc.png)

![image](https://user-images.githubusercontent.com/110079770/187494302-f64171b9-a7b1-4931-95eb-e77097ccb626.png)

![image](https://user-images.githubusercontent.com/110079770/187494407-d74fef68-aca9-49d0-897a-342349a1bbea.png)

![image](https://user-images.githubusercontent.com/110079770/187496829-c6f203e8-7496-49b8-bc74-7e8d8ebca35e.png)


**11. Routing**

### Type the following command to run placement
```
run_routing
```

![image](https://user-images.githubusercontent.com/110079770/187443861-01522132-7365-4433-898b-d6458aeb702f.png)


### 11.1. Routing 

![image](https://user-images.githubusercontent.com/110079770/187444680-d6c2ddf0-50fc-4009-b1ac-3f7dd61ea263.png)

![image](https://user-images.githubusercontent.com/110079770/187444869-01548792-0d75-4185-862a-ccff8cf25487.png)

In tkcon terminal type the following command to know whether the cell is present or not

```getcell sky130_vsdinv
```

![image](https://user-images.githubusercontent.com/110079770/187445677-f2093f38-61f2-4d1f-b1e1-7bca87b722c0.png)

**One sky130_vsdinv cell is present in the design**
```
sky130_vsdinv _14_ 
```

**Identifying the sky130_vsdinv cell**

![image](https://user-images.githubusercontent.com/110079770/187446117-77ff1c12-1548-4919-bc83-4b356fda5ddb.png)

**Expanded version of sky130_vsdinv cell**

![image](https://user-images.githubusercontent.com/110079770/187446574-cedd1b67-3d89-410e-a25e-e59f75e5ec51.png)


**12. Reports**

![image](https://user-images.githubusercontent.com/110079770/187455475-538f58d1-2cb8-4377-b05f-3b1d103e50aa.png)

![image](https://user-images.githubusercontent.com/110079770/187456257-ad692330-fbb1-4448-a8bd-430dc10182b4.png)

![image](https://user-images.githubusercontent.com/110079770/187456396-e9d6aea3-7992-4d06-a242-9a2d59c102c6.png)

![image](https://user-images.githubusercontent.com/110079770/187456496-96350370-d1d9-4956-ad99-be18c53402c0.png)

![image](https://user-images.githubusercontent.com/110079770/187456778-0484fe16-4ddc-4535-a11e-55043fd40052.png)


## 13. References
 
 [1] VLSI System Design: https://www.vlsisystemdesign.com/
 
 [2] SkyWater SKY130 PDK: https://skywater-pdk.readthedocs.io/en/main/contents/libraries/foundry-provided.html
 
 [3] RTL Design using Verilog with Sky130 Technology: https://www.vsdiat.com/dashboard
 
 [4] Openlane - SKY130: https://github.com/The-OpenROAD-Project/OpenLane
 
 [5] Magic Installation: https://github.com/RTimothyEdwards/magic
 

## 14. Contributors 

- **GogiReddy Ravi Kiran Reddy** 
- **Kunal Ghosh** 



## 15. Acknowledgments

- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## 16. Contact Information

- GogiReddy Ravi Kiran Reddy, Postgraduate Student, International Institute of Information Technology, Bangalore.
- Email: gogireddyravikiranreddy1@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
