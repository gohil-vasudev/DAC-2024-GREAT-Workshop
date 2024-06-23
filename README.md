# DAC-2024-GREAT-Workshop
![Image](image.png)
## 📅 Sunday, June 23, 13:00 - 17:00 PDT, Room 3004
## Title: GREAT: <ins>G</ins>en-AI <ins>R</ins>esearch in <ins>E</ins>lectronic Design, <ins>A</ins>utomation, and <ins>T</ins>est
Here we provide resources for the workshop itself, as well as additional resources related to the "Design a Chip in a Day" competition.

For RTL-based design, go to the [RTL_based_design](https://github.com/gohil-vasudev/DAC-2024-GREAT-Workshop/tree/0b6f74c24524d346ba5f6c7b1e46fdab9949acee/RTL_based_design) folder.

For HLS-based design, go to the [HLS](https://github.com/gohil-vasudev/DAC-2024-GREAT-Workshop/tree/053a36bd2c4bd867adaae734e1e3281620982b1b/HLS) folder.


### Competition Rules:
* You need to register for DAC (i.e., full conference registration) in order to attend the GREAT workshop and participate in the competition.
* Only use an LLM to generate the RTL/C/C++.
* Minor manual fixes to LLM-generated codes are allowed, e.g., fixing minor syntax issues such as missing keywords or ";".
* Major manual corrections/coding will incur a penalty.
* Participants will be required to submit the LLM conversation links for all submitted codes in order to be eligible for evaluation.
* Participants will be provided with the top module declaration (containing primary input and output signal names) and a testbench for the top module to verify their final design.
* Participants are free to have a hierarchical design and to write custom testbenches for submodules, as long as the top module is according to the provided declaration and is compatible with the provided testbench.
* The submissions will be evaluated by a panel of judges. Overall, the evaluations shall be performed based on functional correctness (using the provided testbench) and PPA metrics.
* The organizers reserve the right to disqualify any entry that does not comply with the competition rules.
* The organizers reserve the right to make the final judgment in any dispute or situation not covered by these rules.
* The organizers' decisions regarding the interpretation of the rules are at their sole discretion and are not subject to appeal.
* The organizers reserve the right to amend these rules at any time. Any changes will be reflected here and/or communicated to participants promptly.

### Submission Process:
Once you have successfully generated the code using the LLM, please prepare a zip package containing the following items:
* Verilog code file(s) for your LLM-generated design
* A README containing the command to be run to test your design, i.e, "iverilog <output_file.out> <file1.v> <file2.v> ... <simon_llm_tb.v>"
* A txt file containing working links to all competition-related conversations with the LLM, including any files you uploaded for the LLM to analyze

Send an email with your **team name** and your **zipped file** to gohil.vasudev@tamu.edu. Please send only one submission per team.
