From: kd@flaga.is
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <00256770.0067906D.00@notes.flaga.is>
Date: Thu, 13 May 1999 18:51:11 +0000
Subject: Re: MBX (MPC860) Question
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am having similar problems with a custom mpc823 board that we are trying
to port LinuxPPC to.
We have 4Mb of ram and 2Mb of Flashrom. We load the kernel from the
Flashrom and attemp to
mount the root file system over NFS. I am wondering if this could be
related to memorysize, i.e
we are seeing some kind of memory starvation? I will try to find a bigger
simm and try with
bigger memory.

Below is the output of the boot process.

loaded at:     FE100000 FE111BAC
relocated to:  00100000 00111BAC
board data at: 001001C4 001001E0
relocated to:  00200100 0020011C
zimage at:     FE120000 FE16B357
avail ram:     00201000 00400000

Linux/PPC load: root=/dev/nfs nfsaddrs=192.168.145.220:192.168.145.222
nfsroot=1
92.168.145.222:/usr/local/embedded
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.5 (kd@linux) (gcc version egcs-2.91.60 19981201
(egcs-1.1.1
release)) #81 Wed May 12 20:04:59 GMT 1999
Boot arguments:
time_init: decrementer frequency = 93750000/60
Calibrating delay loop... 24.27 BogoMIPS
Memory: 3176k available (596k kernel code, 292k data, 32k init)
[c0000000,c04000
00]
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
eth0: CPM ENET Version 0.2, 00:20:94:21:ff:f0
Sending BOOTP requests....page fault in interrupt handler, addr=64
NIP: C0004004 XER: 2000FF11 LR: C0003FB8 REGS: c00edcc0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00ec000[1] 'swapper' mm->pgd c00a5000 Last syscall: 120
last math 00000000
GPR00: C008F424 C00EDD70 C00EC000 00000000 00000005 00000000 00000001
C00E6680
GPR08: FF002830 C008F427 00000014 C00AA9F4 82401010 FFFFFFFF 00000000
FF0023D0
GPR16: 00000003 00000000 81000900 01000000 00001032 000EDDC0 00000000
C000249C
GPR24: C00040A0 000046EB 00100000 00000000 00000000 C00EDDD0 00000005
C00BD164
Instruction DUMP: 801f0000  2c000000  41820074 <801f0004> 74082000
40820008  48
0026b9  801f0000  7fc3f378
page fault in interrupt handler, addr=64
NIP: C0004004 XER: 2000FF11 LR: C0003FB8 REGS: c00edcc0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00ec000[1] 'swapper' mm->pgd c00a5000 Last syscall: 120
last math 00000000
GPR00: C008F424 C00EDD70 C00EC000 00000000 00000005 00000000 00000001
C00E6680
GPR08: FF002830 C008F424 00000014 C00AA9F4 82401010 FFFFFFFF 00000000
FF0023D0
GPR16: 00000003 00000000 81000900 01000000 00001032 000EDDC0 00000000
C000249C
GPR24: C00040A0 000046EB 00100000 00000000 00000000 C00EDDD0 00000005
C00BD164
Instruction DUMP: 801f0000  2c000000  41820074 <801f0004> 74082000
40820008  48
0026b9  801f0000  7fc3f378
......... timed out!
IP-Config: Auto-configuration of network failed.
dev_close: bug eth0 still running
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
