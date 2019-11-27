# segfault_explain
Translates linux segfault error numbers to english using bitwise ops.  

---

#### Segfault error code meanings(http://lxr.free-electrons.com/source/arch/x86/mm/fault.c):
```      
/*
 * Page fault error code bits:
 *
 *   bit 0 ==    0: no page found       1: protection fault
 *   bit 1 ==    0: read access         1: write access
 *   bit 2 ==    0: kernel-mode access  1: user-mode access
 *   bit 3 ==                           1: use of reserved bit detected
 *   bit 4 ==                           1: fault was an instruction fetch
 */
```

---

#### Kernel Panic error code meanings:
```
If the first bit is clear (0), the exception was caused by an access to a page that is not present; if the bit is set (1), this means invalid access right.  
If the second bit is clear (0), the exception was caused by read or execute access; if set (1), the exception was caused by a write access.  
If the third bit is clear (0), the exception was caused while the processor was in Kernel mode; otherwise, it occurred in User mode.  
The fourth bit tells us whether the fault was an Instruction Fetch. This is only valid for 64-bit architecture. Since our machine is 64-bit, the bit has meaning here.  
```

---

#### Taint flag meanings:
```
/**
 *  print_tainted - return a string to represent the kernel taint state.
 *
 *  'P' - Proprietary module has been loaded.
 *  'F' - Module has been forcibly loaded.
 *  'S' - SMP with CPUs not designed for SMP.
 *  'R' - User forced a module unload.
 *  'M' - System experienced a machine check exception.
 *  'B' - System has hit bad_page.
 *  'U' - Userspace-defined naughtiness.
 *  'D' - Kernel has oopsed before
 *  'A' - ACPI table overridden.
 *  'W' - Taint on warning.
 *  'C' - modules from drivers/staging are loaded.
 *  'I' - Working around severe firmware bug.
 *  'O' - Out-of-tree module has been loaded.
 *  'E' - Unsigned module has been loaded.
 *
 *  The string is overwritten by the next call to print_tainted().
 * 
```
