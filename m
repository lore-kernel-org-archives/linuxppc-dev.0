Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3B412551.60D20D82@engmail.uwaterloo.ca>
Date: Mon, 02 Jul 2001 21:52:17 -0400
From: Tim Woo <thwoo@engmail.uwaterloo.ca>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: NFS mount root problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am unable to mount to the host.  I'm using MBX860 and I'm having
problem to mount to the host's NFS.  Can anyone please help.  I have
enclosed the log in the following.  Thank you very much.

Tim

EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: /tftpboot/192.168.0.2/zImage

Client IP Address      = 192.168.0.2
Server IP Address      = 192.168.0.1
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /tftpboot/192.168.0.2/zImage
Argument File Name     =

Bytes Received =&471750, Bytes Loaded =&471750
Bytes/Second   =&235875, Elapsed Time =2 Second(s)
loaded at:     00210000 00204AA4
relocated to:  00100000 000F4AA4
board data at: 003F4558 003F4580
relocated to:  00200100 00200128
zimage at:     00216000 00271FD4
avail ram:     00272000 00400000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (thwoo@linuxnanpa) (gcc version 2.9-edk-000221) #3
Mon Jul 2 16:19:36 EDT 1Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.83 BogoMIPS
Memory: 3084k available (704k kernel code, 308k data, 0k init)
[c0000000,c0400000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 4096 bhash 4096)
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
ttyS02 at 0x03e8 (irq = 4) is a 16450
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
eth0: CPM ENET Version 0.2, 08:00:3e:2d:35:ab
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.0.1, my address is 192.168.0.2
Looking up port of RPC 100003/2 on 192.168.0.1
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.1
Root-NFS: Server returned error -13 while mounting /tftpboot/linuxbrd
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
