Return-Path: <albert.david@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id AADC9DDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 18:37:22 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so416079tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 01:37:20 -0700 (PDT)
Message-ID: <61124de70805160137h3dc015dbk5fa43c15b6206e9@mail.gmail.com>
Date: Fri, 16 May 2008 14:07:19 +0530
From: "Albert David" <albert.david@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: eth0: WakeUp interrupt ! (PPC 405EP board)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Friends,
we have a custom board based on PPC405EP processor, this design is
based on bubinga reference board.
we have ported u-boot 1.4 and linux kernel 2.4.32 - this design is
already in production for several months
recently, on few boards we started seeing "eth0: WakeUp interrupt !"
message while linux bootup(to be specific when ethernet driver is
loaded). but this problem is sort of intermittant in nature, out of 5
reboots, once or twice "eth0: WakeUp interrupt !" keeps printing on
terminal without proceeding any further....

can anyone give me a direction why this happens?
Thanks for your support,
Albert.


following is the boot message from my target board,


U-Boot 1.1.4.1.4 (Dec  5 2007 - 17:22:12)

CPU:   AMCC PowerPC 405EP Rev. B at 266.666 MHz (PLB=133, OPB=66, EBC=33 MHz)
       I2C boot EEPROM disabled
       16 kB I-Cache 16 kB D-Cache
Board: ### No HW ID - assuming PICO4
I2C:   ready
DRAM:  32 MB
FLASH: 16 MB
Hit any key to stop autoboot:  0
00fd: fd    .

## Checking Image at ff000000 ...
   Bad Magic Number
## Booting image at ff960000 ...
   Image Name:   GH2(PICO4) ukernel V-2.4.32-2.6
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    789480 Bytes = 771 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ffc00000 ...
   Image Name:   GH2(PICO4) uramdisk V-2.4.32
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1640575 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 01dae000, end 01f3e87f ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
setup_arch: ocp_early_init
arch: exit
Linux version 2.4.32-2.6 (adav@noiclt10850-lx) (gcc version 3.4.2) #7
Mon Feb 12 17:31:12 IST 2007
Pico4 Barco
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
ip=192.168.1.144:192.168.1.128:192.168.1.1:255.255.255.0::eth0:off
panic=1 console=ttyS0,115200
Calibrating delay loop... 266.24 BogoMIPS
Memory: 28968k available (1352k kernel code, 388k data, 64k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Squashfs 2.2-r2 (released 2005/09/08) (C) 2002-2005 Phillip Lougher
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010830)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
IBM gpio driver version 07.25.02
GPIO #0 at 0xc307d700
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
emac: IBM OCP EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
mal0: Initialized, 4 tx channels, 2 rx channels
eth0: IBM emac, MAC 00:04:a5:06:15:6b
eth0: Found Generic MII PHY (0x00)
emac1: Cannot reset EMAC
Looking for 3 devices
probing for memory type cfi_probe
physmap flash device: 1000000 at ff000000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 8-bit mode
 Amd/Fujitsu Extended Query Table at 0x0040
phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
probing for memory type map_ram
physmap flash device: 8000000 at f0000000
probing for memory type map_ram
physmap flash device: 8000000 at e0000000
Pico40: Found 1 x16 devices at 0x0 in 8-bit mode
 Amd/Fujitsu Extended Query Table at 0x0040
Pico40: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Pico4 flash bank 0: Using static image partition definition
Creating 13 MTD partitions on "Pico40":
0x00000000-0x00360000 : "uscratchpad (3.4MB)"
0x00360000-0x00660000 : "ugh2disk (3MB)"
0x00660000-0x00760000 : "ujffs2_1 (1MB)"
0x00760000-0x00960000 : "ujffs2_2 (2MB)"
0x00960000-0x00b00000 : "uimage (1.6MB)"
0x00b00000-0x00b80000 : "ufpga (512Kb)"
0x00b80000-0x00be0000 : "uiiu (384Kb)"
0x00c00000-0x00ee0000 : "uramdisk (2944KB)"
0x00f60000-0x01000000 : "uboot (640KB)"
0x00360040-0x00660000 : "Pico4 GH2Disk mount point"
mtd: partition "Pico4 GH2Disk mount point" doesn't start on an erase
block boundary -- force read-only
0x00c00040-0x00ee0000 : "Pico4 RootFS mount point"
mtd: partition "Pico4 RootFS mount point" doesn't start on an erase
block boundary -- force read-only
0x00be0000-0x00c00000 : "uversioninfo (128Kb)"
0x00ee0000-0x00f60000 : "ufpgax (512kb)"
IBM IIC driver v2.0
ibm-iic0: using standard (100 kHz) mode
emac1: Cannot reset EMAC
adm9240.o version 2.8.6
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
eth0: WakeUp interrupt !
