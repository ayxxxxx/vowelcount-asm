# Vowelcount ASM x86-64

--- 

**First project in ASM using FASM for windows 64 bit console applications**

- The user inputs a string
- It counts the vowels from the string
- The result is shown in the console
- Supports strings up to 255 characters
- Console window stays open until user presses a key

Built as a PE64 exe with FASM
Uses windows C runtime functions for I and O
Uses windows API ExitProcess to terminate cleanly
Has input buffer size limits to prevent overflow
