From: Phillip.Treddenick@colorado.edu
Message-ID: <1045123635.3e4b523351428@webmail.colorado.edu>
Date: Thu, 13 Feb 2003 01:07:15 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: Trouble running hardhat linux on EP405
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I'm trying to run a hardhat kernel on an EP405 board which has an IBM PPC405GP.
I'm able to download the kernel to the board and verify it's there using a boot loader program.  The problem is that as soon as I jump to a location in the code, the board resets.  So, what I really need to know is what the starting address for my kernel build is.  Does anybody know how I can determine this?  Here is some info from the elf header if that helps.

Thanks, Phill Treddenick
        treddeni@colorado.edu


ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           PowerPC
  Version:                           0x1
  Entry point address:               0xc0000000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          1698512 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           40 (bytes)
  Number of section headers:         20
  Section header string table index: 17
Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        c0000000 010000 10ef9c 00  AX  0   0 32
  [ 2] .text.exit        PROGBITS        c010ef9c 11ef9c 0005e0 00  AX  0   0  4
  [ 3] .rodata           PROGBITS        c010f580 11f580 031470 00   A  0   0 16
  [ 4] .kstrtab          PROGBITS        c01409f0 1509f0 003cb0 00   A  0   0  4
  [ 5] .data             PROGBITS        c0145000 155000 0140a4 00  WA  0   0 16
  [ 6] .exitcall.exit    PROGBITS        c01590a4 1690a4 000044 00  WA  0   0  4
  [ 7] __ex_table        PROGBITS        c01590e8 1690e8 000dc0 00   A  0   0  4
  [ 8] __ksymtab         PROGBITS        c0159ea8 169ea8 001d88 00   A  0   0  4
  [ 9] .data.cacheline_a PROGBITS        c015bc40 16bc40 000700 00  WA  0   0 32
  [10] .text.init        PROGBITS        c015d000 16d000 00f45c 00  AX  0   0  4
  [11] .data.init        PROGBITS        c016c45c 17c45c 01d6d8 00  WA  0   0  4
  [12] .setup.init       PROGBITS        c0189b40 199b40 0000d8 00  WA  0   0  4
  [13] .initcall.init    PROGBITS        c0189c18 199c18 000074 00  WA  0   0  4
  [14] .text.openfirmwar PROGBITS        c018a000 19a000 000010 00  AX  0   0  4
  [15] .bss              NOBITS          c018b000 19b000 026850 00  WA  0   0 32
  [16] .comment          PROGBITS        00000000 19b000 0039ff 00      0   0  1
  [17] .shstrtab         STRTAB          00000000 19e9ff 0000d1 00      0   0  1
  [18] .symtab           SYMTAB          00000000 19edf0 036050 10     19 2326
4
  [19] .strtab           STRTAB          00000000 1d4e40 0394f3 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
Program Header:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x010000 0xc0000000 0xc0000000 0x18a010 0x1b1850 RWE 0x10000
 Section to Segment mapping:
  Segment Sections...
   00     .text .text.exit .rodata .kstrtab .data .exitcall.exit __ex_table
__ksymtab .data.cacheline_aligned .text.init .data.init .setup.init
.initcall.init .text.openfirmware .bss


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
