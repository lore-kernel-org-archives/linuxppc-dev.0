From: jlhagen@collins.rockwell.com
Subject: 11/20 linuxppc 2_3 snapshot - Boot arguments not making it to the kernel. mvme2604
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 20 Nov 2000 11:43:43 -0600
Message-ID: <OFD3445213.1A15922A-ON8625699D.005FB659@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

could someone point me to the correct place in the source tree to hard code
the boot arguments for the kernel. I'm currently using the .config file to
pass the arguments in but they don't make it to the kernel. Then the kernel
dies mounting the root file system that isn't specified. So I'd like a
quick hack point to test if this is going to work at all. My ramdisk image
is working with 2.2 kernels so I think it should be ok to use for 2.4.

Thanks,
John

PPC1-Bug>nbo 0 0 ,,, /tftpboot/zImage-snap2_single
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: /tftpboot/zImage-snap2_single

Client IP Address      = 192.168.1.5
Server IP Address      = 192.168.1.4
Gateway IP Address     = 192.168.1.249
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /tftpboot/zImage-snap2_single
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1816993, Bytes Loaded =&1816993
Bytes/Second   =&139768, Elapsed Time =13 Second(s)

Residual-Data Located at: $01F78000
loaded at:     00005400 0001A220
relocated to:  00800000 00814E20
board data at: 01F78000 01F7EA0C
relocated to:  0080E314 00814D20
zimage at:     00010400 0008EF40
relocated to:  00815000 00893B40
initrd at:     0008EF40 001BEA3D
relocated to:  00893B40 009C363D
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/ram

Uncompressing Linux...done.
Now booting the kernel
Ramsize from residual data was 0 -- Probing for value
Ramsize default to be 32M
Total memory = 32MB; using 128kB for hash table (at c0180000)
Linux version 2.4.0-test11 (vista@xxx.xxxxx.xxx) (gcc version 2.95.2 19991024 (release/franzo)) #2 Mon Nov 20 12:18:44 CST 2000
PReP architecture

Boot arguments:

On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
time_init: decrementer frequency = 16.657202 MHz
Calibrating delay loop... 398.95 BogoMIPS
Memory: 30608k available (808k kernel code, 432k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting PCI interrupts for a "MVME 2600 with MVME712M"
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: I/O port 112 is not free.
Macintosh non-volatile memory driver v1.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
request_module[block-major-8]: Root fs not mounted

VFS: Cannot open root device "" or 08:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:02


Rebooting in 180 seconds..

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
