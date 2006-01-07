Return-Path: <mbello@tcc.com.pe>
Received: from maestro.tcc.com.pe (mail.tcc.com.pe [200.121.72.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4D5E68A03
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Jan 2006 03:21:22 +1100 (EST)
Received: from [192.168.0.3] (desarrollo.tcc.com.pe [192.168.0.3])
	by maestro.tcc.com.pe (8.12.8/8.12.8) with ESMTP id k07G4LPO022743
	for <linuxppc-embedded@ozlabs.org>; Sat, 7 Jan 2006 11:04:22 -0500
Message-ID: <43BFE6A7.90809@tcc.com.pe>
Date: Sat, 07 Jan 2006 11:04:55 -0500
From: Miguel Bello <mbello@tcc.com.pe>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/alternative;
	boundary="------------010807020006040607070803"
Subject: Cardmgr Prism Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010807020006040607070803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We have a TQMxxL board with ppcboot 1.1.5, kernel 2.4.25 and a ramdisk.
I would like to setup a wireless link with WPA protocol (hostap driver
and wpa_supplicant client). We are testing 2 cards: Netgear MA401 and
Linksys WPC11 v3, both with prism chipset.

When I execute cardmgr, I get the kernel error message attached below.
With others cards with no prism chipset, like YDI Diamond, YDI Sapphire
or Cisco Airnet 350, I have no problem, the cardmgr recognize them.
But I need to use the hostap driver with prism chipset cards
(Please take note that with kernel 2.4.4 the cardmgr recognize the
Netgear MA401, for instance)

If anyone has a clue to what I'm doing wrong, I'd appreciate it.

Best Regards

Miguel Bello

====================================================================0

PPCBoot 1.1.5 (Sep  6 2004 - 13:09:55)

CPU:   PPC823EZTnnB2 at 50 MHz: 16 kB I-Cache 8 kB D-Cache
Board: ### No HW ID - assuming TQM8xxL
DRAM:  16 MB
FLASH:  8 MB
In:    serial
Out:   lcd
Err:   lcd
Linux version 2.4.25 (root@desarrollo) (gcc version 2.95.2 19991024
(release)) #18 Fri Jan 6 17:45:37 PET 2006
MPC823 LCD memory at C01BE000
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram/ rw
ip=192.168.0.115:::255.255.255.0:::off panic=1
Decrementer Frequency = 187500000/60
Console: colour dummy device 80x25
Calibrating delay loop... 49.86 BogoMIPS
Memory: 12852k available (1240k kernel code, 436k data, 76k init, 0k
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Console: switching to colour frame buffer device 80x30
fb0: MPC823 LCD frame buffer device
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0380 is on SMC2 using BRG2
pty: 256 Unix98 ptys configured
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at
40000000
Registered flash device /dev/flasha (minor 0, 4 partitions)
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at
40400000
Registered flash device /dev/flashb (minor 8, 2 partitions)
eth0: CPM ENET Version 0.2 on SCC2, 00:d0:93:00:05:4c
RAMDISK driver initialized: 16 RAM disks of 5120K size 1024 blocksize
init_tqm_mtd: chip probing count 0
TQM8xxL-0: Found 2 x16 devices at 0x0 in 32-bit bank
TQM8xxL-0: Found 2 x16 devices at 0x400000 in 32-bit bank
Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
init_tqm_mtd: bank1, name:TQM8xxL-0, size:8388608bytes
TQM flash0: Using Static image partition definition
Creating 7 MTD partitions on "TQM8xxL-0":
0x00000000-0x00040000 : "u-boot"
0x00040000-0x00100000 : "kernel"
0x00100000-0x00200000 : "user"
0x00200000-0x00400000 : "initrd"
0x00400000-0x00600000 : "cramfs"
0x00600000-0x00800000 : "jffs"
0x00400000-0x00800000 : "big_fs"
Linux Kernel Card Services 3.1.22
 options:  none
m8xx_pcmcia: Version 0.05, 14-Apr-2002
m8xx_pcmcia: TQM8xxL using SLOT_B with IRQ 13.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Complete:
     device=eth0, addr=192.168.0.115, mask=255.255.255.0,
gw=255.255.255.255,
    host=192.168.0.115, domain=, nis-domain=(none),
    bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1260k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 76k init
init started:  BusyBox v0.51 (2005.12.14-06:57+0000) multi-call bi

BusyBox v0.51 (2005.12.14-06:57+0000) Built-in shell (lash)
Enter 'help' for a list of built-in commands.

/ #
/ #
/ # cardmgr
cardmgr[14]: watching 1 sockets
/ # cardmgr[15]: starting, version is 3.2.1
Machine check in kernel mode.
Caused by (from SRR1=9032): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C00C4840 XER: 00000000 LR: C00C481C SP: C094FB50 REGS: c094faa0
TRAP: 0200    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c094e000[15] 'cardmgr' Last syscall: 54
last math 00000000 last altivec 00000000
GPR00: C30C1000 C094FB50 C094E000 C30C0000 C0158C30 C30C0000 FDFB3000
00000000
GPR08: C30C0000 C30C0000 C0F99000 00001000 84004002 100223D8 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 0094FF40 00000000
C0004768
GPR24: C00044C0 C094FBBA 00000002 C0FE2844 C094FBBA 00000002 C0FE2800
00000000
Call backtrace:
C00C481C C00C4EF8 C00C5410 C00C51D8 C00C6B44 C00C9FF4 C0047EDC
C000451C 00000000 10001A58 100031CC 10004874 0FEA2394 00000000

/ #

CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_8xx=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_TQM823L=y
CONFIG_MATH_EMULATION=y
CONFIG_EMBEDDEDBOOT=y
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_M8XX=y
CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_ROM=y
CONFIG_MTD_TQM8XXL=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=5120
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_RADIO=y
CONFIG_HERMES=m
CONFIG_HOSTAP=m
CONFIG_PCMCIA_HERMES=m
CONFIG_HOSTAP_CS=m
CONFIG_AIRO_CS=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_8xx_LCD=y
CONFIG_PRIMEVIEW_V16C6448AC=y
CONFIG_FB_8xx_PRE_INIT_FB=y
CONFIG_INVERSE_VIDEO=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_VT=y
CONFIG_CONSOLE_NOBLANK=y
CONFIG_CONSOLE_NOCUR=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32
CONFIG_RTC_8XX=y
CONFIG_FLASH=y
CONFIG_AMD_FLASH=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_JFFS_FS=y
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_JFFS2_CMODE_PRIORITY=y
CONFIG_JFFS2_PROC=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_8xx_COPYBACK=y
CONFIG_SCC_ENET=y
CONFIG_SCC2_ENET=y
CONFIG_ENET_BIG_BUFFERS=y
CONFIG_8xx_SMC1=y
CONFIG_8xx_SMC1_RX_BDNUM=4
CONFIG_8xx_SMC1_RX_BDSIZE=32
CONFIG_8xx_SMC1_TX_BDNUM=4
CONFIG_8xx_SMC1_TX_BDSIZE=32
CONFIG_8xx_SMC2=y
CONFIG_ALTSMC2=y
CONFIG_8xx_SMC2_MAXIDL=1
CONFIG_8xx_SMC2_RX_BDNUM=4
CONFIG_8xx_SMC2_RX_BDSIZE=32
CONFIG_8xx_SMC2_TX_BDNUM=4
CONFIG_8xx_SMC2_TX_BDSIZE=32
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LOG_BUF_SHIFT=0


--------------010807020006040607070803
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<pre wrap="">We have a TQMxxL board with ppcboot 1.1.5, kernel 2.4.25 and a ramdisk.
I would like to setup a wireless link with WPA protocol (hostap driver
and wpa_supplicant client). We are testing 2 cards: Netgear MA401 and
Linksys WPC11 v3, both with prism chipset.

When I execute cardmgr, I get the kernel error message attached below.
With others cards with no prism chipset, like YDI Diamond, YDI Sapphire
or Cisco Airnet 350, I have no problem, the cardmgr recognize them.
But I need to use the hostap driver with prism chipset cards
(Please take note that with kernel 2.4.4 the cardmgr recognize the
Netgear MA401, for instance)

If anyone has a clue to what I'm doing wrong, I'd appreciate it.

Best Regards

Miguel Bello

====================================================================0

PPCBoot 1.1.5 (Sep  6 2004 - 13:09:55)

CPU:   PPC823EZTnnB2 at 50 MHz: 16 kB I-Cache 8 kB D-Cache
Board: ### No HW ID - assuming TQM8xxL
DRAM:  16 MB
FLASH:  8 MB
In:    serial
Out:   lcd
Err:   lcd
Linux version 2.4.25 (root@desarrollo) (gcc version 2.95.2 19991024
(release)) #18 Fri Jan 6 17:45:37 PET 2006
MPC823 LCD memory at C01BE000
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=<i class="moz-txt-slash"><span
 class="moz-txt-tag">/</span>dev/ram<span class="moz-txt-tag">/</span></i> rw
ip=192.168.0.115:::255.255.255.0:::off panic=1
Decrementer Frequency = 187500000/60
Console: colour dummy device 80x25
Calibrating delay loop... 49.86 BogoMIPS
Memory: 12852k available (1240k kernel code, 436k data, 76k init, 0k
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Console: switching to colour frame buffer device 80x30
fb0: MPC823 LCD frame buffer device
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0380 is on SMC2 using BRG2
pty: 256 Unix98 ptys configured
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at
40000000
Registered flash device /dev/flasha (minor 0, 4 partitions)
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at
40400000
Registered flash device /dev/flashb (minor 8, 2 partitions)
eth0: CPM ENET Version 0.2 on SCC2, 00:d0:93:00:05:4c
RAMDISK driver initialized: 16 RAM disks of 5120K size 1024 blocksize
init_tqm_mtd: chip probing count 0
TQM8xxL-0: Found 2 x16 devices at 0x0 in 32-bit bank
TQM8xxL-0: Found 2 x16 devices at 0x400000 in 32-bit bank
Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
init_tqm_mtd: bank1, name:TQM8xxL-0, size:8388608bytes
TQM flash0: Using Static image partition definition
Creating 7 MTD partitions on "TQM8xxL-0":
0x00000000-0x00040000 : "u-boot"
0x00040000-0x00100000 : "kernel"
0x00100000-0x00200000 : "user"
0x00200000-0x00400000 : "initrd"
0x00400000-0x00600000 : "cramfs"
0x00600000-0x00800000 : "jffs"
0x00400000-0x00800000 : "big_fs"
Linux Kernel Card Services 3.1.22
 options:  none
m8xx_pcmcia: Version 0.05, 14-Apr-2002
m8xx_pcmcia: TQM8xxL using SLOT_B with IRQ 13.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Complete:
     device=eth0, addr=192.168.0.115, mask=255.255.255.0,
gw=255.255.255.255,
    host=192.168.0.115, domain=, nis-domain=(none),
    bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1260k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 76k init
init started:  BusyBox v0.51 (2005.12.14-06:57+0000) multi-call bi

BusyBox v0.51 (2005.12.14-06:57+0000) Built-in shell (lash)
Enter 'help' for a list of built-in commands.

/ #
/ #
/ # cardmgr
cardmgr[14]: watching 1 sockets
/ # cardmgr[15]: starting, version is 3.2.1
Machine check in kernel mode.
Caused by (from SRR1=9032): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C00C4840 XER: 00000000 LR: C00C481C SP: C094FB50 REGS: c094faa0
TRAP: 0200    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c094e000[15] 'cardmgr' Last syscall: 54
last math 00000000 last altivec 00000000
GPR00: C30C1000 C094FB50 C094E000 C30C0000 C0158C30 C30C0000 FDFB3000
00000000
GPR08: C30C0000 C30C0000 C0F99000 00001000 84004002 100223D8 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 0094FF40 00000000
C0004768
GPR24: C00044C0 C094FBBA 00000002 C0FE2844 C094FBBA 00000002 C0FE2800
00000000
Call backtrace:
C00C481C C00C4EF8 C00C5410 C00C51D8 C00C6B44 C00C9FF4 C0047EDC
C000451C 00000000 10001A58 100031CC 10004874 0FEA2394 00000000

/ #

CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_8xx=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_TQM823L=y
CONFIG_MATH_EMULATION=y
CONFIG_EMBEDDEDBOOT=y
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_M8XX=y
CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_ROM=y
CONFIG_MTD_TQM8XXL=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=5120
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_RADIO=y
CONFIG_HERMES=m
CONFIG_HOSTAP=m
CONFIG_PCMCIA_HERMES=m
CONFIG_HOSTAP_CS=m
CONFIG_AIRO_CS=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_8xx_LCD=y
CONFIG_PRIMEVIEW_V16C6448AC=y
CONFIG_FB_8xx_PRE_INIT_FB=y
CONFIG_INVERSE_VIDEO=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_VT=y
CONFIG_CONSOLE_NOBLANK=y
CONFIG_CONSOLE_NOCUR=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32
CONFIG_RTC_8XX=y
CONFIG_FLASH=y
CONFIG_AMD_FLASH=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_JFFS_FS=y
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_JFFS2_CMODE_PRIORITY=y
CONFIG_JFFS2_PROC=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_8xx_COPYBACK=y
CONFIG_SCC_ENET=y
CONFIG_SCC2_ENET=y
CONFIG_ENET_BIG_BUFFERS=y
CONFIG_8xx_SMC1=y
CONFIG_8xx_SMC1_RX_BDNUM=4
CONFIG_8xx_SMC1_RX_BDSIZE=32
CONFIG_8xx_SMC1_TX_BDNUM=4
CONFIG_8xx_SMC1_TX_BDSIZE=32
CONFIG_8xx_SMC2=y
CONFIG_ALTSMC2=y
CONFIG_8xx_SMC2_MAXIDL=1
CONFIG_8xx_SMC2_RX_BDNUM=4
CONFIG_8xx_SMC2_RX_BDSIZE=32
CONFIG_8xx_SMC2_TX_BDNUM=4
CONFIG_8xx_SMC2_TX_BDSIZE=32
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LOG_BUF_SHIFT=0
</pre>
</body>
</html>

--------------010807020006040607070803--
