format PE64 console
entry start

include 'win64a.inc'

section '.data' data readable writeable
    inputMsg    db 'Geef een string: ', 0
    outputFmt   db 'Aantal klinkers: %lld', 10, 0
    inputBuf    db 256 dup(0)
    fmtStr      db '%255s', 0

section '.text' code readable executable
start:
    sub rsp, 28h

    lea rcx, [inputMsg]
    call [printf]

    lea rcx, [fmtStr]
    lea rdx, [inputBuf]
    call [scanf]

    xor rcx, rcx
    xor rax, rax

CountLoop:
    movzx rdx, byte [inputBuf + rcx]
    test  dl, dl
    jz    PrintCount

    cmp   dl, 'A'
    jb    LowerCase
    cmp   dl, 'Z'
    ja    LowerCase
    add   dl, 32

LowerCase:
    cmp   dl, 'a'
    je    IncVowel
    cmp   dl, 'e'
    je    IncVowel
    cmp   dl, 'i'
    je    IncVowel
    cmp   dl, 'o'
    je    IncVowel
    cmp   dl, 'u'
    je    IncVowel
    jmp   NextChar

IncVowel:
    inc   rax

NextChar:
    inc   rcx
    jmp   CountLoop

PrintCount:
    lea rcx, [outputFmt]
    mov rdx, rax
    call [printf]

    call [getchar]
    call [getchar]
    add rsp, 28h
    xor ecx, ecx
    call [ExitProcess]

section '.idata' import data readable
    library kernel32, 'KERNEL32.DLL',\
            msvcrt,   'MSVCRT.DLL'
    import kernel32,\
           ExitProcess, 'ExitProcess'
    import msvcrt,\
           printf, 'printf',\
           scanf, 'scanf',\
           getchar, 'getchar'
