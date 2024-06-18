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
