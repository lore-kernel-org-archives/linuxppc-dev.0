Message-Id: <v03130301b3f116a864e2@[192.168.1.1]>
In-Reply-To: <v0313030fb3efcb9a9d0f@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 31 Aug 1999 00:26:35 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David D. Kilzer wrote:

>Is anyone running LinuxPPC with a Daystart 604e 200MHz dual-processor 
>card?

Hmmm...must have been half-asleep when typing that.  Yes, it's a 
Daystar nPower processor card with dual 200 MHz 604e PowerPC CPUs.

Here's what's left of the boot messages on the screen in 2.2.12 from 
CVS that I compiled on Aug 29, 1999:


POSIX conformance testing by UNIFIX
Entering SMP Mode...
Processor 1 is stuck.
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0.
IP Protocols: ICMP, UDP, TCP, IGMP
NET4: AppleTalk 0.18 for Linux NET4.0
Starting kswapd v1.5
MacOS display is /chaos/control
Monitor sense value = 0x603, using video mode 13 and color mode 1.
Console: switching to colour frame buffer device 104x39
fb0: control display adapter
ADB keyboard at 2, handler set to 3
ADB mouse at 3, handler set to 2
Serial driver version 4.27 with no serial options enabled
Machine check in kernel mode.
Caused by (from msr): regs c01fbcf0 Machine check signal - probably due to mm fault
with mmu off
NIP: C00E8818 XER: 00000000 LR: C00E87C0 REGS: c01fbcf0 TRAP: 0200
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01fa000[1] 'swapper' mm->pgd c015b000 Last syscall: 120
last math 00000000 CPU: 0 last CPU: 255
GPR00: 000000FF C01FBDA0 C01FA000 000000FF C01A1068 C01A1068 00000020 C1080000
GPR08: FFFFFFFF 000003F9 F2000000 F2000000 C0180000 001EB0A4 C00E822C C00E79F4
GPR16: C00E704C C00E7B14 C00E496C C00E48FC C00E7660 C00E65AC C00E6680 C00E65E4
GPR24: C01BE77C 00000000 C0171EAC 00000000 00000000 00000001 C0171EAC C01FBDA8
Call backtrace:
C00E87C0 C018C9E8 C018BAF0 C018BB64 C018A028 C017C97C C00043C0
C000A274
Kernel panic: machine check
Rebooting in 180 seconds..


The part about "Processor 1 is stuck." doesn't look good, then we get 
the big OOPS.

Any more suggestions?  I've tried booting without extensions, and with
virtual memory turned off.  I have not tried the BootX startup extension
yet, though, only the application.

One thing I'm not sure I have set up correctly is swap for LinuxPPC.  I'm
sure it's setup fine for MkLinux, but I may be missing something in this 
case.

Thanks!

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
