Message-Id: <199906091737.MAA25209@www.albec.net.mx>
Date: Wed, 09 Jun 1999 11:39:45 +0000
To: linuxppc-dev@lists.linuxppc.org
From: R&D <iyd@sepac.com.mx>
Subject: Help booting MBX through bootd
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gentlemen:

I am trying to use a Motorola MBX860 board in an embedded project.

I download the root.min.tgz system to testing, and I put this
configuration in the MBX:

NIOT 

EPPC-Bug>niot
Controller LUN =00? 20
Device LUN     =00? 
Node Control Memory Address =003C8000? 
Client IP Address      =132.254.169.30? 
Server IP Address      =132.254.169.90? 
Subnet IP Address Mask =255.255.255.0? 
Broadcast IP Address   =255.255.255.255? 
Gateway IP Address     =0.0.0.0? 
Boot File Name ("NULL" for None)     =/ppc/zImage? 
Argument File Name ("NULL" for None) =? 
Boot File Length               =00000000? 
Boot File Byte Offset          =00000000? 
BOOTP/RARP Request Retry       =00? 
TFTP/ARP Request Retry         =00? 
Trace Character Buffer Address =00000000? 
BOOTP/RARP Request Control: Always/When-Needed (A/W)=W? 
BOOTP/RARP Reply Update Control: Yes/No (Y/N)       =Y? 

Update Non-Volatile Memory (Y/N)? Y
Updating Non-Volatile Memory - Standby...

------------------------------------------------------------------------

I am using an SCO machine for boot...

I make a /ppc directory and ungzip-untar the file inside.

I configure inetd for bootpd and tftp, and nfs to export the /ppc directory,

When i run the download command from the MBX I get this response:

EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: /ppc/zImage
Client IP Address      = 132.254.169.30
Server IP Address      = 132.254.169.90
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /ppc/zImage
Argument File Name     = 

Bytes Received =&492532, Bytes Loaded =&492532
Bytes/Second   =&246266, Elapsed Time =2 Second(s.loaded at:     00210000
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
Boot arguments: root=/dev/nfs nfsaddrs=132.254.169.30:132.254.169.90
nfsroot=132.254.169.90:/ppc
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
CPM ENET Version 0.1, 08:00:3e:26:24:52
PPP: version 2.3.3 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Looking up port of RPC 100003/2 on 132.254.169.90
Looking up port of RPC 100005/1 on 132.254.169.90
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 36k init 28k prep


After the last message, the system hangs up and never restart... 

Can anyone help me?

Thanks


Miguel Ceniceros
----------------------------------------------------------------------------
--------------------------------------------------
Miguel Ceniceros                             SEPAC, S.A. de C.V.
Special Projects Manager                 Fundidores #2, Fracc. Ind. Xhala
E-mail: iyd@sepac.com.mx              Cuautitlan de Romero, Edo. de Mexico
54840
                                                      Mexico
URL: http://www.sepac.com.mx        Phone: +52 (5) 872-4888, Fax +52 (5)
872-4065
----------------------------------------------------------------------------
--------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
