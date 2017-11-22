# Buffer Overflow 
## Summary 
* The vulnerable program always takes user inputs in the form of text or file. 
* The user input is stored in a buffer of underestimated size.
* The attacker gives inputs greater than the size of buffer.  
* The input overrides the value of the return address in the stack. 
* Attacker constructs the input in such a way that another program is injected in the input and the overridden value of the return address now points to the address of injected malicious program. 
* The malicious program is executed. 

## Sample demo application
* Link : https://gitlab.com/shivapbhusal/app_analysis/blob/master/security_examples/bufferoverflow.c

## Useful Links:
* https://courses.cs.washington.edu/courses/cse451/05sp/section/overflow1.ppt
* Smashing the stack for fun and profit, http://www-inst.eecs.berkeley.edu/~cs161/fa08/papers/stack_smashing.pdf
* Lecture Notes: http://www.cis.syr.edu/~wedu/Teaching/CompSec/LectureNotes_New/Buffer_Overflow.pdf
* https://dhavalkapil.com/blogs/Shellcode-Injection/
* GDB tutorial: http://www.unknownroad.com/rtfm/gdbtut/gdbtoc.html

## Seedlab tasks 
* Link : http://www.cis.syr.edu/~wedu/seed/Labs_12.04/Software/Buffer_Overflow/Buffer_Overflow.pdf

## Seedlab Solution:
https://github.com/shivapbhusal/buffer-overflow-attack
Forked from : https://github.com/npapernot/buffer-overflow-attack

## FAQ(s)

[1] How does address space randomization help to prevent buffer overflow ? 

Ans: "ASLR works alongside virtual memory management to randomize the locations of different parts of the program in memory. Every time the program is run, components (including the stack, heap, and libraries) are moved to a different address in virtual memory. Attackers can no longer learn where their target is through trial and error, because the address will be different every time."

Source: https://www.howtogeek.com/278056/what-is-aslr-and-how-does-it-keep-your-computer-secure/

StackExchange: https://security.stackexchange.com/questions/18556/how-do-aslr-and-dep-work

Udacity Video : https://www.youtube.com/watch?v=IX2Qf8K2n9E

ASLR adds random paddings between  between return address and local buffers: http://cactus.eas.asu.edu/partha/Papers-PDF/2010/ISSRE_memory.pdf

MIT : https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-858-computer-systems-security-fall-2014/lecture-notes/MIT6_858F14_lec3.pdf

## Preventive measures: 
* Address Space Randomization: sysctl -w kernel.randomize_va_space=0 
* Enabling stackguard protection scheme: It makes sure that whatever is in the stack, doesn't execute. gcc-fno-stack-protector $file_name


