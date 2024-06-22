# HLS flow

You can implement the task using HLS. 
We cann give you access to servers running Siemens Catapult HLS for the competition, or you can use any other AISC compatible HLS tool you have access to.

## Connecting to our server
Request us a username and password and log in at:
*[https://ecs01.poly.edu:3300/auth/ssh/](https://ecs01.poly.edu:3300/auth/ssh/)*

Run 
```
chmod +x setup.sh
./setup.sh
setenv PATH /home/$USER/.localpython/bin:PATH
setenv OPENAI_API_KEY <your key>
```
The second line needs to be ran every time you open a new terminal

You will need an OpenAI API Key to run code using Open AI APIs.

Use python3.12 to run the python examples.

## Scripting LLM and Catapult
*[example.py](https://github.com/gohil-vasudev/DAC-2024-GREAT-Workshop/blob/main/HLS/example.py)* works you through simple OpenAPI calls and running Catapult HLS from python. 

*[C2HLSC.py](https://github.com/gohil-vasudev/DAC-2024-GREAT-Workshop/blob/main/HLS/C2HLSC.py)* shows an example of a complete script that uses an LLM in the loop using feedback from catapult to go from generic C to synthesizable C. [Paper C2HLSC](https://arxiv.org/pdf/2406.09233)   
