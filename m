Message-ID: <38266602.C333E608@syseng.anu.edu.au>
Date: Mon, 08 Nov 1999 16:56:18 +1100
From: Peter Brown <pfb@syseng.anu.edu.au>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX860 mbxroot.min problem.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm attempting to boot an MBX860 card using the mbxroot.min.tgz filesystem. 
The following listing shows that the zImage is TFTPed OK and the kernel starts
loading.  When the NFS mount is attempted, the IP address of the NFS server
appears to be corrupted from what was used before.  I've successfully executed
the NFS mount on another network using the server address 192.168.1.1 and MBX
address 192.168.1.4.  What would cause the boot arguments to be changed from
the Program Load settings?

Thanks for your time.


EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: /mbx860/zImage

Client IP Address      = 150.203.126.140
Server IP Address      = 150.203.126.12
Gateway IP Address     = 150.203.126.1
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /mbx860/zImage
Argument File Name     = 

Bytes Received =&492532, Bytes Loaded =&492532
Bytes/Second   =&164177, Elapsed Time =3 Second(syloaded at:     00210000
0030E42C
relocated to:  00100000 001FE42C
board data at: 003F4228 003F4250
relocated to:  00200100 00200128
zimage at:     00216000 00276D6D
avail ram:     0030E42C 00400000

Linux/PPC load: 
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.1.119 (dan@pbdan.clearone.com) (gcc version egcs-2.90.25
980302 (egcs-1.0.2 prerelease)) #31 Mon Sep 7 18:14:20 EDT 1998
Boot arguments: root=/dev/nfs nfsaddrs=150.23.126.140:150.23.126.12
nfsroot=150.23.126.12:/mbx860
time_init: decrementer frequency = 150000000/60
Memory: 2872k available (732k kernel code, 456k data, 36k init)
[c0000000,c0400000]
PCI: Probing PCI hardware
Calibrating delay loop... 39.63 BogoMIPS
POSIX conformance testing by UNIFIX
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP, IGMP
Starting kswapd v 1.5 
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
CPM ENET Version 0.1, 08:00:3e:26:9c:f7
PPP: version 2.3.3 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Looking up port of RPC 100003/2 on 150.23.126.12
portmap: server 150.23.126.12 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 150.23.126.12
portmap: server 150.23.126.12 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 150.23.126.12 not responding, timed out
Root-NFS: Server returned error -5 while mounting /mbx860
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..



-- 
Peter Brown, Software Engineer      | Phone: +61 2 6279 8830
Robotic Systems Lab, RSISE          | Fax:   +61 2 6279 8660
Australian National University      | 
Canberra ACT 0200 AUSTRALIA         |
--------------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
