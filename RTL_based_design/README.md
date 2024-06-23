## For RTL-based design
### [Google Colab Notebook (WIP)](https://colab.research.google.com/drive/1ZWSJuSAwqvnewstt_tK4OR2_aZQSaxr2?usp=sharing)

### Top module declaration
```verilog
module simon(
    input clk,
    input rst,
    input en,
    input [63:0] plaintext,
    input [127:0] key,
    output reg [63:0] ciphertext,
    output reg done
);
```

### Installing required software
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
### Generate waveform
```bash
gtkwave waveform_llm.vcd
```
