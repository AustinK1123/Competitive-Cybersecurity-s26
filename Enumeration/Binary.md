# Binary 1 and 2

This writeup covers two NCL Gymnasium reverse-engineering binary challenges.

## Tool Primer: GDB (GNU Debugger)

GDB is the main tool used here because it gives you direct visibility into how a compiled program behaves at runtime, even when you do not have source code. For CTF-style binaries, this is ideal: you can inspect control flow, identify dangerous functions, trace checks that gate success/failure paths, and test hypotheses immediately. Instead of guessing what the program is doing, GDB lets you observe and validate behavior step by step.

### Why GDB is useful for NCL binary challenges

- You can find vulnerable patterns quickly (for example unsafe input functions like gets).
   This helps you spot likely exploit points fast, such as stack overflows, weak input validation, or logic that trusts user input too early.
- You can inspect function names and call graph hints in stripped or semi-stripped binaries.
   Even partial symbols often expose intent (for example getflagbytid), which can reveal shortcut paths to flag-printing logic.
- You can pause execution and call internal helper functions directly.
   Breakpoints let you stop before checks run, then use call to invoke target functions and observe outputs without fully following intended program flow.
- You can validate exploit ideas with immediate feedback.
   You can test payload length, argument values, and function behavior in seconds, which is much faster than repeatedly rerunning blind attempts.

### High-value GDB commands for challenges like these

- gdb ./binary
: Start debugger on target binary.
- info functions
: List discovered function symbols (good for finding suspicious names like getflagbytid).
- disassemble main
: Show assembly for main and identify control-flow checks and risky calls.
- break main
: Set breakpoint at program entry logic.
- run <args>
: Start program with challenge arguments.
- continue
: Resume execution after breakpoint.
- call (void) function_name(args)
: Invoke internal function directly while paused.
- x/20i $pc
: Show instructions around current program counter.
- info registers
: View register state during debugging.

## Binary 1

The binary requires a 4-digit argument (example used: 7074), then prompts for a password. In the disassembly, the pass variable is initialized at `[B1-32]` (`movl $0x0,0x3c(%esp)`), input is written through `gets` at `[B1-37]`, and the input buffer base is `lea 0x1e(%esp),%eax` at `[B1-35]`. That places the buffer and pass check 30 bytes apart (`0x3c - 0x1e = 0x1e = 30`). The pass check is performed at `[B1-38]` and the success call path (`fg`) appears at `[B1-42]`. Entering 31+ bytes overflows into pass, flips it non-zero, and prints the flag (shown at `[B1-52]`).

Key idea: controlled stack overflow to flip a boolean gate.

### Numbered Input/Output (Binary 1)

```text
[B1-01] ❯ gdb RE1_32bit
[B1-02] Enable debuginfod for this session? (y or [n]) y
[B1-03] (gdb) disassemble main
[B1-04] Dump of assembler code for function main:
[B1-05]    0x080486a6 <+0>:     push   %ebp
[B1-06]    0x080486a7 <+1>:     mov    %esp,%ebp
[B1-07]    0x080486a9 <+3>:     and    $0xfffffff0,%esp
[B1-08]    0x080486ac <+6>:     sub    $0x40,%esp
[B1-09]    0x080486af <+9>:     cmpl   $0x2,0x8(%ebp)
[B1-10]    0x080486b3 <+13>:    je     0x80486d6 <main+48>
[B1-11]    0x080486b5 <+15>:    mov    0xc(%ebp),%eax
[B1-12]    0x080486b8 <+18>:    mov    (%eax),%eax
[B1-13]    0x080486ba <+20>:    mov    %eax,0x4(%esp)
[B1-14]    0x080486be <+24>:    movl   $0x80487fe,(%esp)
[B1-15]    0x080486c5 <+31>:    call   0x80483b0 <printf@plt>
[B1-16]    0x080486ca <+36>:    movl   $0x1,(%esp)
[B1-17]    0x080486d1 <+43>:    call   0x80483f0 <exit@plt>
[B1-18]    0x080486d6 <+48>:    mov    0xc(%ebp),%eax
[B1-19]    0x080486d9 <+51>:    add    $0x4,%eax
[B1-20]    0x080486dc <+54>:    mov    (%eax),%eax
[B1-21]    0x080486de <+56>:    mov    %eax,(%esp)
[B1-22]    0x080486e1 <+59>:    call   0x8048400 <strlen@plt>
[B1-23]    0x080486e6 <+64>:    cmp    $0x4,%eax
[B1-24]    0x080486e9 <+67>:    je     0x804870c <main+102>
[B1-25]    0x080486eb <+69>:    mov    0xc(%ebp),%eax
[B1-26]    0x080486ee <+72>:    mov    (%eax),%eax
[B1-27]    0x080486f0 <+74>:    mov    %eax,0x4(%esp)
[B1-28]    0x080486f4 <+78>:    movl   $0x80487fe,(%esp)
[B1-29]    0x080486fb <+85>:    call   0x80483b0 <printf@plt>
[B1-30]    0x08048700 <+90>:    movl   $0x1,(%esp)
[B1-31]    0x08048707 <+97>:    call   0x80483f0 <exit@plt>
[B1-32]    0x0804870c <+102>:   movl   $0x0,0x3c(%esp)
[B1-33]    0x08048714 <+110>:   movl   $0x804880f,(%esp)
[B1-34]    0x0804871b <+117>:   call   0x80483b0 <printf@plt>
[B1-35]    0x08048720 <+122>:   lea    0x1e(%esp),%eax
[B1-36]    0x08048724 <+126>:   mov    %eax,(%esp)
[B1-37]    0x08048727 <+129>:   call   0x80483c0 <gets@plt>
[B1-38]    0x0804872c <+134>:   cmpl   $0x0,0x3c(%esp)
[B1-39]    0x08048731 <+139>:   je     0x8048740 <main+154>
[B1-40]    0x08048733 <+141>:   mov    0xc(%ebp),%eax
[B1-41]    0x08048736 <+144>:   mov    %eax,(%esp)
[B1-42]    0x08048739 <+147>:   call   0x804853d <fg>
[B1-43]    0x0804873e <+152>:   jmp    0x804874c <main+166>
[B1-44]    0x08048740 <+154>:   movl   $0x8048829,(%esp)
[B1-45]    0x08048747 <+161>:   call   0x80483d0 <puts@plt>
[B1-46]    0x0804874c <+166>:   mov    $0x0,%eax
[B1-47]    0x08048751 <+171>:   leave
[B1-48]    0x08048752 <+172>:   ret
[B1-49] ❯ ./RE1_32bit 7074
[B1-50] Please enter a password: 1234567890123456789012345678901
[B1-51] your tid: 7074
[B1-52] NCL-EZOF-4024
```

## Binary 2

This binary is solved through function discovery, not overflow. In `info functions`, `getflagbytid` is visible at `[B2-26]`. After setting a breakpoint at main (`[B2-28]`) and running (`[B2-30]`), execution pauses at main (`[B2-37]`). Calling `getflagbytid` with the team ID at `[B2-38]` prints the flag on `[B2-39]`. On newer GDB versions, an explicit cast like `(void)` may be required (as shown).

Key idea: enumerate symbols and invoke the hidden flag function directly.

### Numbered Input/Output (Binary 2)

```text
[B2-01] ❯ gdb RE2_32bit
[B2-02] Enable debuginfod for this session? (y or [n]) y
[B2-03] (gdb) info functions
[B2-04] All defined functions:
[B2-05]
[B2-06] Non-debugging symbols:
[B2-07] 0x08048420  _init
[B2-08] 0x08048460  printf@plt
[B2-09] 0x08048470  fflush@plt
[B2-10] 0x08048480  sleep@plt
[B2-11] 0x08048490  puts@plt
[B2-12] 0x080484a0  __gmon_start__@plt
[B2-13] 0x080484b0  exit@plt
[B2-14] 0x080484c0  strlen@plt
[B2-15] 0x080484d0  __libc_start_main@plt
[B2-16] 0x080484e0  memset@plt
[B2-17] 0x080484f0  putchar@plt
[B2-18] 0x08048500  __isoc99_scanf@plt
[B2-19] 0x08048510  strtol@plt
[B2-20] 0x08048520  _start
[B2-21] 0x08048550  __x86.get_pc_thunk.bx
[B2-22] 0x08048560  deregister_tm_clones
[B2-23] 0x08048590  register_tm_clones
[B2-24] 0x080485d0  __do_global_dtors_aux
[B2-25] 0x080485f0  frame_dummy
[B2-26] 0x0804861d  getflagbytid
[B2-27] 0x08048795  main
[B2-28] (gdb) break main
[B2-29] Breakpoint 1 at 0x8048798
[B2-30] (gdb) r
[B2-31] Starting program: /run/media/brandon/EEB0F0D1B0F0A0EF/Security/NCL/EnumExploit/RE2_32bit
[B2-32] Downloading 1.13 M separate debug info for /lib/ld-linux.so.2
[B2-33] Downloading 10.17 M separate debug info for /usr/lib32/libc.so.6
[B2-34] [Thread debugging using libthread_db enabled]
[B2-35] Using host libthread_db library "/usr/lib/libthread_db.so.1".
[B2-36]
[B2-37] Breakpoint 1, 0x08048798 in main ()
[B2-38] (gdb) call (void) getflagbytid(4930)
[B2-39] NCL-FYOF-0044
```
