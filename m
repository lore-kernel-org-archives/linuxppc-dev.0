Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <Zq989176867389.18785@webmail5.inner-21cn.com>
Date: Thu, 23 Aug 2001 13:26:10 +0800 (CST)
From: "yah" <hay8888@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: boot on MCP750
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all.
  I use MCP750 board and linuxppc_2_4 from penguinppc. I rebuild the kernel,then boot my board,faild. I had used vmlinuz from mvista to boot the board,it's ok. So I don't think it's hardware problem. What's wrong? Pleas give me a hand.Thanks in advance.Following is the boot info.

Linux/PPC load: root=nfs
Uncompressing Linux...done.
Now booting the kernel
Total memory = 128MB; using 512kB for hash table (at c0280000)
Linux version 2.4.6-pre2 (root@amy.w-ibeda.com) (gcc version 2.95.2 19991024 (r1
PReP architecture
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=nfs
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at fc000000
OpenPIC timer frequency is 8.333519 MHz
time_init: decrementer frequency = 16.666518 MHz
Calibrating delay loop... 732.36 BogoMIPS
Memory: 125984k available (1284k kernel code, 720k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup mem res, dev: 0.0, res_start: 3c000000->fc000000
Fixup mem res, dev: 0.e, res_start: 3bffff00->fbffff00
Fixup mem res, dev: 0.e, res_start: fffc0000->bffc0000
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
PCI: Unable to handle 64-bit address space for
Setting PCI interrupts for a "Mesquite cPCI (MCP750) w/ HAC"
PCI:0:0:0: Resource fc000000-fc03ffff (f=200)
PCI:0:b:1: Resource 0000fff0-0000fff7 (f=101)
PCI:0:b:1: Resource 0000ffec-0000ffef (f=10d)
PCI:0:b:1: Resource 0000ffe0-0000ffe7 (f=101)
PCI:0:b:1: Resource 0000ffdc-0000ffdf (f=10d)
PCI:0:b:1: Resource 0000ffc0-0000ffcf (f=101)
PCI:0:b:2: Resource 0000ffa0-0000ffbf (f=101)
PCI:0:e:0: Resource 0fffff00-0fffff7f (f=101)
PCI:0:e:0: Resource fbffff00-fbffff7f (f=200)
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI ed
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 83653kB/27884kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 59
VP_IDE: chipset revision 6
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0xffc0-0xffc7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffc8-0xffcf, BIOS settings: hdc:pio, hdd:pio
hdc: ST310211A, ATA DISK drive
ide1 at 0xffe0-0xffe7,0xffde on irq 14
hdc: 16514064 sectors (8455 MB) w/1024KiB Cache, CHS=16383/16/63
Partition check:
 hdc:hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
 unknown partition table
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
Linux Tulip driver version 0.9.15-pre2 (May 16, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xfffff00, 00:01:AF:00:FC:AA, IRQ 18.
__ioremap(): phys addr 6000000 is RAM lr c0010840
Registered physmem device from 98304Kb to 131072Kb
Mapped from 0x00000000 to 0x02000000
Macintosh non-volatile memory driver v1.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Insert root floppy and press ENTER
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k init 20k pmac 4k chrp 4k openfirmware
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..
----------------------------------------------
劲爆下载--爽快!
http://download.21cn.com

你的邮箱需要升级吗？
http://service.21cn.com/feemail/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
