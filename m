From: bgat@open-widgets.com
Date: Tue, 5 Dec 2000 16:31:00 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX860 serial on J19?
Message-ID: <20001205163100.A7845@sr1.open-widgets.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!


I have a stock Motorola MBX860 board, and I'm trying to use the serial
ports connected to the Utility #2 connector, J19.  These ports are
connected to the SMSC 37c672.

In short, nothing is working.  I'm using the kernel that comes with
the Red Hat Embedded DevKit, which appears to be a modestly-modified
2.2.13.

I'm in the process of trying out the MontaVista HHL 2.2.14 kernel as I
write this.

I think I must be missing something obvious, because the SMSC chip is
used in a lot of PCs and is therefore probably well supported...

Any thoughts or suggestions would be much appreciated.

I'm mounting my root directory via NFS, and I have this in /dev:

crwxrwx---   1 root     root       5,   1 Dec  4 13:53 console
crwxrwx---   1 root     root       6,   0 Dec  4 15:54 lp0
crwxrwx---   1 root     root       1,   3 Dec  4 13:53 null
crwxrwx---   1 root     root      99,   0 Dec  4 13:54 parport0
brwxrwx---   1 root     root       1,   1 Dec  4 13:53 ram
crw-r--r--   1 root     root       4,  64 Dec  5 14:13 ttyS00
crw-r--r--   1 root     root       4,  65 Dec  5 14:13 ttyS01
crw-r--r--   1 root     root       4,  66 Dec  5 14:13 ttyS02
crwxrwx---   1 root     root       1,   5 Dec  4 13:53 zero

When I boot, my console (SMC1/COM1) looks like this:

Bytes Received =&444278, Bytes Loaded =&444278
Bytes/Second   =&222139, Elapsed Time =2 Second(s)
loaded at:     00210000 00204AA4
relocated to:  00100000 000F4AA4
board data at: 003F4570 003F4598
relocated to:  00200100 00200128
zimage at:     00216000 0026B457
avail ram:     0026C000 00400000

Linux/PPC load: init=/sbin/sash
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (bgat@sol) (gcc version 2.9-edk-000221) #1
Tue Dec 5 15:1900
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.77 BogoMIPS

Memory: 3148k available (652k kernel code, 296k data, 0k init)
[c0000000,c04000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
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
eth0: CPM ENET Version 0.2, 00:01:af:02:7a:22
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.2.11, my address is 192.168.2.2
IP-Config: Cannot add default route (-101).
Looking up port of RPC 100003/2 on 192.168.2.11
Looking up port of RPC 100005/1 on 192.168.2.11
VFS: Mounted root (NFS filesystem) readonly.

...

Thanks!


b.g.
--
Bill Gatliff
bgat@open-widgets.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
