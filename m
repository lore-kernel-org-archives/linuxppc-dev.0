Message-ID: <D53137D1F3DDD211A3750800060DA313017023AA@viee122a.erd.siemens.at>
From: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting Linux on MPC860ADS - crash
Date: Mon, 3 Apr 2000 17:44:36 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

after many troubles and some help from members of this mailing list I
managed to start booting Linux on a MPC860ADS board.

But after the first few messages the system crashes.

I use the 8xxROM from Raphael Bossek with a ROM disk for booting (ext2
filesystem in flash rom). (http://www.s4l.de/powerpc.html)

At the end of this email I attached the output on the serial port. Do you
have an idea what went wrong? Perhaps you can support me with a .config file
for the Linux kernel, perhaps my setting for the kernel compilation are
wrong?

Best regards,
Thomas.


rom:0:/> bootz zImage.initrd
Size 517704
4 blocks
entry 0x100000, phoff 0x34, shoff 0x7d588
phnum 0x1, shnum 0xa
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x530c, p_memsz 0xb1cc
Loading at 0x10c000
Size 517704
506 blocks
Starting 0x11c000
loaded at: 0011C000 001271CC
relocated to: 00100000 0010B1CC
board data at: 007F0000 007F001C
relocated to: 00200100 0020011C
zimage at: 00122000 00188D4A
initrd at: 00188D4A 00189547
avail ram: 0018A000 00800000
Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (eisenzopft@pca355) (gcc version 2.95.2 19991024
(release))
#30 Mon Apr 3 12:41:27 Local time zone must be set--see zic manual page 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 43.93 BogoMIPS
Memory: 7036k available (752k kernel code, 356k data, 40k init)
[c0000000,c08000
00]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 8192 bhash 8192)
Starting kswapd v 1.5
NIP: 00000000 XER: A000A77F LR: C00EB250 REGS: c0187df0 TRAP: 0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0186000[1] 'swapper' mm->pgd c00d0000 Last syscall: 120
last math 00000000
GPR00: 00000000 C0187EA0 C0186000 00000000 C00CBF91 C00DE1C8 C00F95D4
00000000
GPR08: 00000000 C00F0000 00000000 C0100000 DA4E4C86 00000000 FE010000
FE010000
GPR16: FE010000 FE010000 FE010000 FE010000 FE010000 007F0000 0011C000
00002C73
GPR24: 00000000 00100000 00100000 0020000D 00000005 C00F9514 00000001
C00F938C
Call backtrace:
C00F9514 C00E9EDC C00E9F48 C00E9040 C00E3854 C0002AB0 C0006E8C
Kernel panic: kernel access of bad area pc 0 lr c00eb250 address 0 tsk
swapper/1
Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
