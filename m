Message-Id: <3.0.5.32.19990305103259.00802940@mailhost.bulldog.com>
Date: Fri, 05 Mar 1999 10:32:59 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Joe Julicher <joe_julicher@macktrucks.com>
Subject: MBX821 Kernel
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I finally had some time to spend on the MBX and got my cross compiler running.

Thanks for the librarys Dan I will get them installed next!

I downloaded 2.2.0 kernel and cross compiled it.
It did not finish the boot, I am not sure why.  Perhaps I am not starting
from a stable source tree.
I can't access CVS (never have been able to) through the firwall here at
work so this tree did not
come from there.  

Any help would be appreciated.

Yes, there are 68MB on this MBX board... :)

Thanks,
Joe Julicher

_______________Terminal Capture Follows ______________________________

Copyright Motorola Inc. 1988-1998, All Rights Reserved

MBX
Debugger/Diagnostics Release Version 1.4 - 04/01/98 RM01
COLD Start

Local
Memory Found =04400000 (&71303168)

MPU Clock Speed =40Mhz

WARNING:
Keyboard Not Connected

EPPC-Bug>pl 20 0
Network Booting from: MPC860,
Controller 20, Device 0
Loading: zImage

Client IP Address      =
170.102.107.40
Server IP Address      = 170.102.103.62
Gateway IP Address
  = 170.102.107.9
Subnet IP Address Mask = 255.255.255.0
Boot File Name
    = zImage
Argument File Name     = 

Bytes Received =&505090, Bytes
Loaded =&505090
Bytes/Second   =&56121, Elapsed Time =9 Second(s)
loaded
at:     00210000 0030E440
relocated to:  00100000 001FE440
board data at:
043F4558 043F4580
relocated to:  00200100 00200128
zimage at:     00216000
00279C82
avail ram:     0030E440 043F5000

Linux/PPC load: console=tty0
console=ttyS0,9600n8
Uncompressing Linux...done.
Now booting the
kernel
Linux version 2.2.0 (root@h07212.bulldog.com) (gcc version
egcs-2.91.60 19981201 (egcs-1.1.1 release)) #13 Fri Mar 5 07:31:07 EST
1999
Boot arguments: console=tty0 console=ttyS0,9600n8 root=/dev/nfs
nfsroot=/sys/mbxroot
time_init: decrementer frequency =
150000000/60
Calibrating delay loop... 39.83 BogoMIPS
Memory: 67804k
available (716k kernel code, 1072k data, 40k init)
[c0000000,c4400000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI
hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer
Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4:
Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v
1.5 
Serial driver version 4.27 with no serial options enabled
ttyS00 at
0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
ttyS02 at
0x03e8 (irq = 4) is a 16450
CPM UART driver version 0.02
ttyS00 at 0x0280
is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at
0x0200 is a SCC
pty: 256 Unix98 ptys configured
W82C105: IDE controller on
PCI bus 00 dev 19
W82C105: not 100% native mode: will probe irqs later
NIP:
C00DFCC8 XER: 20000000 LR: C00DF808 REGS: c01cdd10 TRAP: 0300
MSR: 00009032
EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01cc000[1] 'swapper' mm->pgd
c00c7000 Last syscall: 120 
last math 00000000
GPR00: 00000000 C01CDE00
C01CC000 C0105FAC 00000000 C00C38C4 C010664D C00C0000 
GPR08: 00000000
81000020 00000000 00000000 00000001 00000000 00000000 00000000 
GPR16:
00000000 00000000 00000000 00000004 C00E2F8A C00E2F89 C00E2F88 00000000

GPR24: 00000001 00000000 C01DD5C0 00000000 C00C38C4 00000000 C0105FAC
01000020 
Call backtrace: 
00000000 C00DF808 C00DFA68 C00DEE44 C00DEE64
C00DEEA4 C00DE778 
C00DEEDC C00DA750 C000287C C0005F0C 
Instruction DUMP:
54002738  7fff0214  3d3f8000 <89690002> 7c0006ac  716a0080  41820018
3c60c00c  38633f9c 
Kernel panic: kernel access of bad area pc c00dfcc8 lr
c00df808 address 81000022 tsk swapper/1
Rebooting in 180 seconds..
_______________________________________________________________________
Joe Julicher                    | Phone : 301-790-5442
Sr Project Engineer             | Fax   : 301-790-5743
Mack Trucks                     | E-Mail: joe_julicher@macktrucks.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
