Message-ID: <20010630223320.2166.qmail@web11602.mail.yahoo.com>
Date: Sat, 30 Jun 2001 15:33:20 -0700 (PDT)
From: Ravindranath <krnsoft@yahoo.com>
Subject: sandPoint 8240 booting: Not reconginzing ethernet card
To: "Mark A. Greer" <mgreer@mvista.com>,
	David Wilhardt <dwilhardt@xyterra.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20010620202250.24435.qmail@web11606.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am having problems with ppc linux booting on my
sandpoint 8240..

I have built the kernel with the ethernet driver(3COM
Fast ethernet)..For this I changed config file and
turn on the ethernet driver in the config file. The
target still doesn't boot..

I have attached the boot log. The significant error
seems to be "No network devices available".

Some more questions:
1. I have setup the dhcp server my host m/c(redhat6.2)
with the instructions form Mvista cdk1.2 docs.Also the
instructions ask for setting fixed ip address for the
target in /etc/dhcpd.conf file. Since I have set up
the dhcp server, I am not sure what should be the
fixed-address in the /etc/dhcpd.conf file.
2. Also do we need to pass the ip address as part of
the boot arguments..If so how??

/*****
Boot Log
******/

  DINK32_KAHLUA >>go 900000
loaded at:     00900000 00914E20
relocated to:  00800000 00814E20
zimage at:     0090B000 00989842
avail ram:     00400000 00800000

Linux/PPC load: root=nfs
Uncompressing Linux...done.
Now booting the kernel
Total memory = 32MB; using 0kB for hash table (at
00000000)
Linux version 2.4.0-test2 (root@badcat.ece.utexas.edu)
(gcc version 2.95.2 19991030 (2.95.3
prerelease/franzo))1Boot arguments: root=nfs
console=ttyS0
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=nfs
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at
fcf400
OpenPIC timer frequency is not set
Calibrating delay loop... 131.89 BogoMIPS
Memory: 30696k available (884k kernel code, 404k data,
164k init) [c0000000,c2000000]
Dentry-cache hash table entries: 4096 (order: 3, 32768
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
kmem_create: Poisoning requested, but con given -
bdev_cache
Inode-cache hash table entries: 2048 (order: 2, 16384
bytes)
kmem_create: Poisoning requested, but con given -
inode_cache
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
CI: device 00:0e.0 has unknown header type 7f,
ignoring.
Auto Config PCI Bars
PCI device 1057:0003 (Motorola) bus 0 dev 0
        BAR 0, Mem,     BAR 1, Mem, size=0x1000,
address=0xfbffec00
Symphony Labs W83C553 bus 0 dev 11
Symphony Labs SL82c105 bus 0 dev 11
        BAR 0, I/O, size=0x8, address=0xaffbf8
        BAR 1, I/O, size=0x4, address=0xaff7f4
        BAR 2, I/O, size=0x8, address=0xaff3e8
        BAR 3, I/O, size=0x4, address=0xafefe4
        BAR 4, I/O, size=0x10, address=0xafebd0
        BAR 5, I/O, size=0x10, address=0xafe7c0
3Com Corporation 3c905 100BaseTX [Boomerang] bus 0 dev
15
        BAR 0, I/O, size=0x40, address=0xafe380
        IRQ 18
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society
NET3.039
kmem_create: Poisoning requested, but con given -
skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind
2048)
NET4: AppleTalk 0.18 for Linux NET4.0
Starting kswapd v1.6
pty: 256 Unix98 ptys configured
loop: registered device at major 7
loop: enabling 8 loop devices
0 3c515 cards found.
Serial driver version 5.01 (2000-05-29) with
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
IP-Config: No network devices available.
kmem_create: Forcing size word alignment - nfs_fh
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
