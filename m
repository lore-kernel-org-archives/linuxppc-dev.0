Message-ID: <382BC9B2.FDF9AD50@ctam.com.au>
Date: Fri, 12 Nov 1999 19:02:59 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: LinuxPPC Embedded: root nfs boot problems.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to boot embedded-2.2.5 kernel using a nfsr root filesystem.
Here is a log of the console session.  I get a "neighbour table
overflow" error.  What does this mean ?  I have a look in the source but
can't figure out what is happening.

Thanks,
Brendan Simon.



loaded at:     FF801000 FF813BAC
relocated to:  00100000 00112BAC
board data at: 001001F8 00100214
relocated to:  00200100 0020011C
zimage at:     FF808000 FF8690B9
avail ram:     00201000 00400000

Linux/PPC load: root=/dev/nfs nfsaddrs=203.21.127.132:203.21.127.160
nfsroot=203.21.127.160:/sys/ads-root
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.5 (root@k9) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 rel
ease)) #39 Fri Nov 12 17:49:11 EST 1999
Boot arguments: root=/dev/nfs nfsaddrs=203.21.127.132:203.21.127.160
nfsroot=203
.21.127.160:/sys/ads-root
time_init: decrementer frequency = 93750000/60
Calibrating delay loop... 24.52 BogoMIPS
Memory: 15188k available (700k kernel code, 464k data, 32k init)
[c0000000,c1000
000]
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
eth0: CPM ENET Version 0.2, 00:d0:1f:11:22:33
IP-Config: Guessing netmask 255.255.255.0
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
portmap: server 203.21.127.160 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 203.21.127.160
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
portmap: server 203.21.127.160 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
mount: server 203.21.127.160 not responding, timed out
Root-NFS: Server returned error -5 while mounting /sys/ads-root
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..Machine check in kernel mode.
Caused by (from msr): regs c0f4bb30 Machine check signal - probably due
to mm fa
ult


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
