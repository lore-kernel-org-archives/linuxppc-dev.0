Date: Fri, 15 Dec 2000 06:27:23 -0500 (EST)
From: Christopher Huffine <huffine@wopr.nrl.navy.mil>
To: linuxppc-embedded@lists.linuxppc.org
Subject: BSE IPEngine and HHL 1.2
Message-ID: <Pine.LNX.4.21.0012150620270.23087-100000@wopr.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I just recently installed HHL 1.2 with the intention of
migrating from the Bright Star Engineering tools up to the HHL
setup.

I have an odd problem, where the kernel crashes on loading up,
but, oddly, at different times within the boot sequence.  The trace
will be at the end of this message.

Usually the kernel crashes, as shown below, before it gets
very far.  Sometimes, it doens't crash until after it tries to
make BOOTP requests.  Once it crashed before making bootp requests.

The kernel is vmlinuz-bseip which is linked to
vmlinuz-bseip-2.2.14-1.2.2-1

Any thoughts?


Here's the trace:

relocated to:  00180000 0018B1FC
board data at: 001801C8 001801E4
relocated to:  00200100 0020011C
zimage at:     00216000 0027A251
avail ram:     0027B000 01000000

Linux/PPC load: root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.14 (root@rodan.mvista.com) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #1 Tu
e Aug 8 01:44:34 PDT 2000
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.72 BogoMIPS
Memory: 15160k available (736k kernel code, 452k data, 36k init) [c0000000,c1000000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
NIP: C0006B18 XER: 0000013C LR: C0009418 REGS: c013dd40 TRAP: 0600
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c013c000[1] 'swapper' mm->pgd c00cc000 Last syscall: 120
last math 00000000
GPR00: C0009404 C013DDF0 C013C000 C00E6A4D C013DD68 00736B74 00000000 000003F2
GPR08: C00D1F84 C0162000 C00EB6D0 FFFFFEBF 24000028 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00020000 00009032 0013DE10 00000000 C000253C
GPR24: C000924C 00FF4094 00FF4014 C013DE20 00000000 C00E6A4D C00E6A4D C00E6A2A
Call backtrace:
C0009404 C000253C C00E2E48 C00E2F80 C00DD854 C0002ACC C0006F18


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
