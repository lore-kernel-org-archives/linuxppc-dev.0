Message-ID: <3A006299.73525FEE@vnet.ibm.com>
Date: Wed, 01 Nov 2000 12:36:09 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Yet another RS6k whipped!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Enclosed is the original boot log for Linux on a 43P-140 (200mhz).  As
you might guess it is still a way off from being useful.  Thanks go to
Tom Gall who did the initial work (but ran out of time) and Dave Monroe
for being on irc when I got frustrated :).

For those interested this box boots as prep but has an openpic.  It can
run with a chrp style memory map which is probably what I am going
attempt next after installing something on the disk.  This boot log is
with a prep memory map.
--
Todd Inglett


0 > boot floppy:,zimage \

loaded at:     00600400 00615220
relocated to:  00800000 00814E20
board data at: 00231318 00237D24
relocated to:  0080E314 00814D20
zimage at:     0060B400 0070384A
relocated to:  00815000 0090D44A
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 load_ramdisk=1 root=/dev/fd0
Uncompressing Linux...done.
Now booting the kernel
in prom_init
offset=40000000  kernelbase=c0000000
ok...I am prep.  phys=00000000
PReP architecture
Total memory = 192MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.0-test8 (tinglett@tt.rchland.ibm.com) (gcc version
2.95.2 19991024 (release/franzo)) #88 Wed Nov 1 10:07:56 CST 2000
Boot arguments: console=ttyS0,9600 load_ramdisk=1 root=/dev/fd0
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 load_ramdisk=1 root=/dev/fd0
prep_init_IRQ
looking for OpenPIC in prep_init_IRQ
initing for OpenPIC!
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at f7fc0000
OpenPIC timer frequency is not set
chrp_int_ack_special=0xeffffff0
time_init: decrementer frequency = 16.617035 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 398.13 BogoMIPS
Memory: 189596k available (1600k kernel code, 824k data, 260k init, 0k
highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/0002] 000600 00
Found 00:58 [1014/000a] 000601 00
Found 00:60 [1022/2000] 000200 00
Found 00:68 [1014/0046] 00ff00 00
Found 00:80 [1000/0003] 000100 00
Found 00:b0 [5333/8811] 000300 00
Found 00:b8 [1014/0022] 000604 01
Fixups for bus 00
Scanning behind PCI bridge 00:17.0
Scanning bus 01
Found 01:18 [1014/0018] 000201 00
Fixups for bus 01
Bus scan for 01 returning with max=01
Bus scan for 00 returning with max=01
IBM ID: 000000d5
Setting PCI interrupts for a "IBM 140 (Tiger)"
  map 0:0 to irq 16
  map 0:11 to irq 16
Relocating PCI address 3f7fe400 -> 17fe400
  map 0:12 to irq 22
Relocating PCI address 3f7fe800 -> 17fe800
  map 0:13 to irq 18
  map 0:16 to irq 23
Relocating PCI address 3f7fec00 -> 17fec00
  map 0:22 to irq 17
  map 0:23 to irq 16
Relocating PCI address 3f7ffc00 -> 17ffc00
PCI: Address space collision on region 0 of device IBM TR Auto
LANstreamer
PCI: Address space collision on region 1 of device IBM TR Auto
LANstreamer
PCI: Address space collision on region 6 of device IBM TR Auto
LANstreamer
PCI: Failed to allocate resource 0 for IBM TR Auto LANstreamer
PCI: Failed to allocate resource 1 for IBM TR Auto LANstreamer
PCI: Failed to allocate resource 6 for IBM TR Auto LANstreamer
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Starting kswapd v1.7
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
ncr53c8xx: at PCI bus 0, device 16, function 0
ncr53c8xx: 53c825a detected
ncr53c825a-0: rev 0x13 on pci bus 0 device 16 function 0 irq 23
ncr53c825a-0: ID 7, Fast-10, Parity Checking
ncr53c825a-0: on-chip RAM at 0x37dff000
ncr53c825a-0: restart (scsi reset).
ncr53c825a-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - version 3.3b
scsi : 1 host.
  Vendor: IBM       Model: CDRM00203     !K  Rev: 8B08
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
ncr53c825a-0-<6,0>: wide msgin: 1-2-3-1.
ncr53c825a-0-<6,0>: wide: wide=1 chg=0.
ncr53c825a-0-<6,0>: wide msgout: 8.
ncr53c825a-0-<6,0>: sync msgin: 1-3-1-c-f.
ncr53c825a-0-<6,0>: sync: per=25 scntl3=0x10 ofs=8 fak=0 chg=1.
ncr53c825a-0-<6,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
ncr53c825a-0-<6,0>: sync msgout: 1-3-1-19-8.
  Vendor: IBM       Model: DORS-32160W   !#  Rev: WA3E
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 6, lun 0
ncr53c825a-0-<6,0>: tagged command queue depth set to 8
scsi : detected 1 SCSI cdrom 1 SCSI disk total.
ncr53c825a-0-<3,0>: sync_msgout: 1-3-1-19-8.
ncr53c825a-0-<3,0>: sync msgin: 1-3-1-19-8.
ncr53c825a-0-<3,0>: sync: per=25 scntl3=0x10 ofs=8 fak=0 chg=0.
ncr53c825a-0-<3,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
Uniform CD-ROM driver Revision: 3.11
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4226725 [2063 MB] [2.1
GB]
Partition check:
 /dev/scsi/host0/bus0/target6/lun0: p1 p2
VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER
RAMDISK: Compressed image found at block 0
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
pcnet32_probe_pci: found device 0x001022.0x002000
  ioaddr=0x17fe800  resource_flags=0x000101
eth0: PCnet/PCI II 79C970A at 0x17fe800,<6> 08<6> 00<6> 5a<6> f8<6>
ce<6> 57<6>pcnet32: pcnet32_private lp=cba6e000 lp_dma_addr=0x8ba6e000
 assigned IRQ 22.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de
Macintosh non-volatile memory driver v1.0
mice: PS/2 mouse device common for all mice
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 260k init 20k pmac 4k chrp 4k openfirmware
hello
Yellow Dog install init version 1.2 starting
mounting /proc filesystem... done
opening /proc/cmdline... done
checking command line arguments...
        unknown option 'console=ttyS0,9600'!done
checkEXT2-fs warning: checktime reached, running e2fsck is recommended
ing for NFS root filesystem...no
trying to remount root filesystem read write... done
checking for writeable /tmp... yes
couldn't open /dev/tty4 for syslog -- still using /tmp/syslog
running install...
failed to open /dev/tty1failed.

I can't recover from this.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
