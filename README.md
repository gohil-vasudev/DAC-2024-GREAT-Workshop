# DAC-2024-GREAT-Workshop

## 📅 Sunday, June 23, 13:00 - 17:00 PDT, Room 3004
### Title: GREAT: <ins>G</ins>en-AI <ins>R</ins>esearch in <ins>E</ins>lectronic Design, <ins>A</ins>utomation, and <ins>T</ins>est
Here we provide resources for the workshop itself, as well as additional resources related to the topics discussed.

## Commands needed:

### Software to install
```bash
sudo apt-get install iverilog
sudo apt-get install gtkwave
```
### Generate testbench
```bash
iverilog -o <output_file.out> <verilog-module.v> <all-the-necessary-intermediate-modules.v> <simon_llm_tb.v>
```
### Run testbench
```bash
./output_file.out
```
### Watch the waveform
```bash
gtkwave waveform_llm.vcd
```
