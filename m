Message-ID: <39C1DE70.F1D90668@siemens.at>
Date: Fri, 15 Sep 2000 10:31:46 +0200
From: Rainer Kloud <rainer.kloud@siemens.at>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 FCC Ethernet driver
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm porting the embedded 2.4.0-test4 kernel to the
Motorola Scout Board. This board consists of a
MPC750 and MPC8260 which we use in 'Companion Mode',
that means that the core of the MPC8260 is switched
off and therefore the core of the MPC750 is mapped
into the MPC8260.

Up to now I had only to insert the Memory Map of my
Board and to perform some minor modifications (f.e to
enable the serial interface which resides on SCC1).

The next step of the porting process will be to enable
the Ethernet which resides on FCC2.
So my question is: Does anyone have a Ethernet Driver
for the FCC?

Thanx in advance.

Rainer

scout> load net 5f0000
scout> go 600000
Jump to Addr: 0x600000 ...
loaded at:     00600000 0060B274
relocated to:  00400000 0040B274
board data at: 0000002E 0000005A
relocated to:  00200100 0020012C
zimage at:     00606000 0067EEFC
avail ram:     0067F000 02000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Total memory = 32MB; using 128kB for hash table (at c0160000)
Linux version 2.4.0-test4 (kloud@PCC141) (gcc version 2.95.2 19991024
(release)) #135 Thu Sep 14 17:32:46 CEST 2000
Boot arguments: root=/dev/nfs rw
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
Calibrating delay loop... 3434.09 BogoMIPS
Memory: 30736k available (912k kernel code, 380k data, 44k init)
[c0000000,c2000000]
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x8000 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
Serial driver version 5.01 (2000-05-29) with no serial options enabled
Testing ttyS0 (0x03f8, 0x0000)...


--
.........................................................
Rainer Kloud
Siemens AG Österreich, PSE EZE TR2
mailto:rainer.kloud@siemens.at      http://www.siemens.at


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
