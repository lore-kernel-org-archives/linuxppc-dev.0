From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Linuxppc-Commit" <linuxppc-commit@source.mvista.com>
Subject: AW: CPCI-405 port (PPC405GP)
Date: Tue, 11 Sep 2001 09:15:52 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJMEFHDCAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3B9CF4B4.E399EC7A@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Please find attached a port to our CPCI-405 board
>
> Nice job, but did you actually get your system booted?  There is
> something generically wrong with the 405 port, and it's been a pain
> in the ass trying to find it.  If you actually booted a system
> that ran properly, it would be interesting to know what you used for
> a file system.

I get my system booted up to the busybox prompt via nfs root file system.
After this most commands do nothing at all (as described from andrew may
"405GP booting"), and the system hangs pretty soon :-(.

I would think that the walnut port is behaving this way too, am I right?

If you are interrested, please take a look at the bootup snapshop of our
board:


PPCBoot 1.0.4 (Aug 29 2001 - 18:55:29)

CPU:   IBM PowerPC 405GP Rev. D at 198 MHz (PLB=99, OPB=49, EBC=33 MHz)
           PCI sync clock at 33 MHz, internal PCI arbiter enabled
           16 kB I-Cache 8 kB D-Cache
Board: CPCI405_AC033 (PCI Host Version)
FPGA:  cpci4052.ncd s05xlvq100 2001/05/10 15:15:23
DRAM:  16 MB
FLASH:  4 MB
IDE:   Bus 0: OK
  Device 0: Model: Hitachi CV 7.1.1 Firm: Rev 1.01 Ser#:
              Type: Removable Hard Disk
              Capacity: 15.4 MB = 0.0 GB (31488 x 512)
BEDBUG Ready
In:    serial
Out:   serial
Err:   serial

Hit any key to stop autoboot:  0
ENET Speed is 100 Mbps - FULL duplex connection
ARP broadcast 1
TFTP from server 10.0.18.190; our IP address is 10.0.111.111
Filename '/tftpboot/pImage88'.
Load address: 0x400000
Loading:
############################################################################
##########################
done
Bytes transferred = 519304 (7ec88 hex)
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.10-pre6
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    519240 Bytes = 507 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.10-pre6 (stefan@pc-linux-dev) (gcc version 2.95.2 19991030
(2.95.3 prerelease/franzo)) #2 Mon Sep 10 16:57:01 CEST 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=10.0.18.190:/home/matthias/target_root_esd
ip=10.0.111.111:10.0.18.190:10.0.0.79:255.255.0.0:pc-linux-dev::off
Calibrating delay loop... 197.83 BogoMIPS
Memory: 14636k available (924k kernel code, 448k data, 64k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Memory resource not set for host bridge 0
PCI: Failed to allocate resource 1(0-ffffffff) for 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
i2c-core.o: i2c core module
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 1) is a 16550A
block: 64 slots per queue, batch=8
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
: PPC405 EMAC 100 Mbs Full duplex MAC 00:02:27:00:01:79
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Reset ethernet interfaces
eth0: PPC405 Enet open completed
IP-Config: Complete:
      device=eth0, addr=10.0.111.111, mask=255.255.0.0, gw=10.0.0.79,
     host=pc-linux-dev, domain=, nis-domain=(none),
     bootserver=10.0.18.190, rootserver=10.0.18.190, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.18.190
Looking up port of RPC 100005/1 on 10.0.18.190
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 64k init 4k openfirmware
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.60.1 (2001.08.24-09:23+0000) multi-call binary

Please press Enter to activate this console.


BusyBox v0.60.1 (2001.08.24-10:05+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# ps
# ls
Please press Enter to activate this console.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
