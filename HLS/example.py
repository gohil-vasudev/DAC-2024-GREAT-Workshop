from openai import OpenAI

client = OpenAI()

#model_name = "gpt-4-turbo-2024-04-09"
model_name = "gpt-3.5-turbo-0125"
system_content = """You are a C expert programmer and High Level Synthesis expert, 
assist in coding tasks targetet to produce synthesizable HLS code. 
Your response must contain one C code snippet contaning all necesary parts needed for successful compilation. 
Do not add any pragmas or directives to the code, the code must be written in a way that the HLS tool can infer the correct behavior."""

# initial message list
message_list=[
        {"role": "system", "content": system_content},
        {"role": "user", "content": "Help me rewrite this function to be compatible with HLS: \n" + inlcudes +  orig_code + "\n The current problem is:" + error +
         "\n\n also include a main function that tests the code in the same way of the reference code: \n" + test_code}
    ]

completion = client.chat.completions.create(
            model=model_name,
            messages = message_list
        )

print( completion.choices[0].message.content)

# we need to keep the whole conversation if we want to keep prompting, including the responses we get:
message_list.append(completion.choices[0].message)


# the response contains both text and code, get the code:
c_code_dut = completion.choices[0].message.content.split("```c")[1].split("```")[0]

# we cam run gcc to check the code compiles

file_name = f"temp_dut.c"
with open(file_name, "w") as f:
    # f.write(inlcudes)
    f.write(c_code_dut)
print("Compiling the code")

import subprocess

log = subprocess.run(["gcc", file_name, "-o", f"temp_dut"], capture_output=True)

subprocess.run(["catapult", "-shell", "-file", tcl_file], capture_output=True)

# To run catapult:
# open reference tcl
#read tcl
with open("inputs/directives.tcl", "r") as f:
    tcl = f.read()

# format reference tcl with the top function and the c file to synthesize
with open("my_tcl.tcl", "w") as f:
    f.write(tcl.format(top_function="quicksort", c_file=file_name))

# run catapult
print("Running catapult")
subprocess.run(["catapult", "-shell", "-file", "my_tcl.tcl"], capture_output=True)