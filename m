From: tom_gall@vnet.ibm.com
Message-ID: <397F2344.CCCE7FD0@vnet.ibm.com>
Date: Wed, 26 Jul 2000 17:43:32 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: RS/6000 Model 170 Boots Linux
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  Here is the boot log of an RS/6000 Model 170 which for the first time booted
Linux this past Friday.

  If I recall correctly it's a 375 Mhz Power 3 box. It's kinda weird as you'll
notice below the OpenPIC line indicates there are 8 processors here... well
there isn't, it's just a single processor box. Patches to be posted shortly.


Total memory = 512MB; using 2048kB for hash table (at c0800000)
Linux version 2.3.99-pre9 (tgall@vorlon.rchland.ibm.com) (gcc version 2.95.2
19991024 (release/franzo)) #24 Fri Jul 21 14:22:53 /usr/local/etc/localtime 2000
Boot arguments: root=/dev/sda2
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
OpenPIC addrs: ffc00000 feff7c00 feef7c00
RTAS Event Scan Rate: 1 (2999 jiffies)
On node 0 totalpages: 131072
zone(0): 131072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at ffc00000
OpenPIC timer frequency is not set
time_init: decrementer frequency = 3000126390/30 (95 MHz)
Console: colour dummy device 80x25
Calibrating delay loop... 799.54 BogoMIPS
Memory: 509440k available (1532k kernel code, 916k data, 272k init)
[c0000000,e0000000]
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Don't know how to access NVRAM with 0 addresses
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Starting kswapd v1.6
matroxfb: Matrox unknown G200 (PCI) detected
matroxfb: 640x480x8bpp (virtual: 640x3270)
matroxfb: framebuffer at 0xC0000000, mapped to 0x80000000, size 2097152
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: setting PCI_COMMAND_INVALIDATE (fix-up)
sym53c8xx: 53c896 detected
sym53c8xx: at PCI bus 0, device 12, function 1
sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: setting PCI_COMMAND_INVALIDATE (fix-up)
sym53c8xx: 53c896 detected
sym53c896-0: rev 0x5 on pci bus 0 device 12 function 0 irq 20
sym53c896-0: ID 7, Fast-40, Parity Checking
sym53c896-0: on-chip RAM at 0xc3216000
sym53c896-0: restart (scsi reset).
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-0: Downloading SCSI SCRIPTS.
sym53c896-1: rev 0x5 on pci bus 0 device 12 function 1 irq 17
sym53c896-1: NCR clock is 40218KHz
sym53c896-1: ID 7, Fast-40, Parity Checking
sym53c896-1: on-chip RAM at 0xc3214000
sym53c896-1: restart (scsi reset).
sym53c896-1: handling phase mismatch from SCRIPTS.
sym53c896-1: Downloading SCSI SCRIPTS.
ncr53c8xx: at PCI bus 0, device 12, function 0
ncr53c8xx: IO region 0xfff400[0..127] is in use
ncr53c8xx: at PCI bus 0, device 12, function 1
ncr53c8xx: IO region 0xfff800[0..127] is in use
scsi0 : sym53c8xx - version 1.5m
scsi1 : sym53c8xx - version 1.5m
scsi : 2 hosts.
  Vendor: IBM       Model: CDRM00203     !K  Rev: 1_03
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
  Vendor: IBM       Model: DNES-309170W      Rev: SAGU
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 4, lun 0
sym53c896-0-<4,0>: tagged command queue depth set to 8
scsi : detected 1 SCSI cdrom 1 SCSI disk total.
sym53c896-0-<1,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
Uniform CD-ROM driver Revision: 3.08
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17774160 [8678 MB] [8.7 GB]
Partition check:
 /dev/scsi/host0/bus0/target4/lun0: p1 p2 p3 p4
Serial driver version 4.93 (2000-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pcnet32_probe_pci: found device 0x001022.0x002000
  ioaddr=0xffec00  resource_flags=0x000101
PCI: Enabling device 00:0f.0 (0140 -> 0143)
eth0: PCnet/FAST 79C971 at 0xffec00,<6> 00<6> 06<6> 29<6> ac<6> ad<6> f4<6>
    tx_start_pt(0x0c00):<6>~220 bytes,<6> BCR18(6821):<6>BurstWrEn <6>NoUFlow
<6>
    SRAMSIZE=0x7f00,<6> SRAM_BND=0x4000,<6>pcnet32: pcnet32_private lp=c07d0000
lp_dma_addr=0x7d0000
 assigned IRQ 30.
<6>pcnet32_probe_pci: found device 0x001022.0x002000
  ioaddr=0xfff000  resource_flags=0x000101
PCI: Enabling device 00:10.0 (0140 -> 0143)
eth1: PCnet/FAST 79C971 at 0xfff000,<6> 00<6> 06<6> 29<6> 04<6> 15<6> d8<6>
    tx_start_pt(0x0c00):<6>~220 bytes,<6> BCR18(6821):<6>BurstWrEn <6>NoUFlow
<6>
    SRAMSIZE=0x7f00,<6> SRAM_BND=0x4000,<6>pcnet32: pcnet32_private lp=c07cf000
lp_dma_addr=0x7cf000
 assigned IRQ 18.
<6>Macintosh non-volatile memory driver v1.0
devfs: v0.96 (20000430) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 272k init 32k prep 12k pmac
Adding Swap: 263160k swap-space (priority -1)

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
