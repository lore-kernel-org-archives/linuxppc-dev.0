Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F9D10@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: IDE on PCMCIA error
Date: Thu, 25 Oct 2001 16:08:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody!
I´m new in this list.
I´m trying to install direct IDE on PCMCIA port on a MPC823FADS board.
(Excuse me for the long mail)
I configured the ppcboot (1.0.0) and the kernel to do this. I am using a
"PCMCIA type III ATA card".

When ppcboot starts gives the following message:
		PPCBoot 1.0.0 (Oct 25 2001 - 08:08:14)

		Initializing...
		CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB D-Cache
	   Board: FADS with db MPC823 rev ENG or PILOT
	   DRAM:  (4 MB SDRAM)  8 MB
	   FLASH:  2 MB

      PCMCIA:unknown card type
      In:    serial
      Out:   serial
      Err:   serial

      Hit any key to stop autoboot:  0


When the kernel starts it gives the followinf message:
	:>bootm 02880000 02940000
	## Booting image at 02880000 ...
	   Image Name:   Linux 2.4.4 en la FADS
	   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
	   Data Size:    534027 Bytes = 521 kB = 0 MB
	   Load Address: 00000000
	   Entry Point:  00000000
	   Verifying Checksum ... OK
	   Uncompressing Kernel Image ... OK
	## Loading RAMDisk Image at 02940000 ...
	   Image Name:   Ramdisk Image
	   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
	   Data Size:    365313 Bytes = 356 kB = 0 MB
	   Load Address: 00000000
	   Entry Point:  00000000
	   Verifying Checksum ... OK
	   Loading Ramdisk to 00705000, end 0075e301 ... OK

	Linux version 2.4.4 (root@GASTONDOA2001) (gcc version 2.95.3
20010315 (release/MontaVista)) #34 mié oct 24 14:41
	On node 0 totalpages: 20
	zone(1): 0 pages.
	zone(2): 0 pages.
	Kernel command line: root=/dev/ram init=/linuxrc
	Decrementer Frequency: 3000000
	Calibrating delay loop... 47.82 BogoMIPS
	Memory: 6216k available (996k kernel code, 412k data, 44k init, 0k
highmem)
	Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
	Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
	Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
	Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
	POSIX conformance testing by UNIFIX
	Linux NET4.0 for Linux 2.4
	Based upon Swansea University Computer Society NET3.039
	Initializing RT netlink socket
	Starting kswapd v1.8
	CPM UART driver version 0.03
	ttyS0 on SMC1 at 0x0280, BRG1
	pty: 256 Unix98 ptys configured
	block: queued sectors max/low 4042kB/1347kB, 64 slots per queue
	RAMDISK driver initialized: 16 RAM disks of 2048K size 1024
blocksize
	Uniform Multi-Platform E-IDE driver Revision: 6.31
	ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
	PCMCIA slot B: phys mem e0000000...e0030000 (size 00030000)
	unknown card type
	unknown card type
	unknown card type
	unknown card type
	unknown card type
	unknown card type
	unknown card type
	unknown card type
	unknown card type
	[429] m8xx_ide_default_irq 0
	unknown card type
	[429] m8xx_ide_default_irq 0
	unknown card type
	[429] m8xx_ide_default_irq 0
	unknown card type
	[429] m8xx_ide_default_irq 0
	unknown card type
	[429] m8xx_ide_default_irq 0
	unknown card type
	[429] m8xx_ide_default_irq 0
	unknown card type
	[429] m8xx_ide_default_irq 0
	hdc: IRQ probe failed (0x0)
	hdc: IRQ probe failed (0x0)
	hdd: IRQ probe failed (0x0)
	hdd: IRQ probe failed (0x0)
	hde: IRQ probe failed (0x0)
	hde: IRQ probe failed (0x0)
	hdf: IRQ probe failed (0x0)
	hdf: IRQ probe failed (0x0)
	hdg: IRQ probe failed (0x0)
	hdg: IRQ probe failed (0x0)
	hdh: IRQ probe failed (0x0)
	hdh: IRQ probe failed (0x0)
	hdi: IRQ probe failed (0x0)
	hdi: IRQ probe failed (0x0)
	hdj: IRQ probe failed (0x0)
	hdj: IRQ probe failed (0x0)
	hdk: IRQ probe failed (0x0)
	hdk: IRQ probe failed (0x0)
	hdl: IRQ probe failed (0x0)
	hdl: IRQ probe failed (0x0)
	hdm: IRQ probe failed (0x0)
	hdm: IRQ probe failed (0x0)
	hdn: IRQ probe failed (0x0)
	hdn: IRQ probe failed (0x0)
	hdo: IRQ probe failed (0x0)
	hdo: IRQ probe failed (0x0)
	hdp: IRQ probe failed (0x0)
	hdp: IRQ probe failed (0x0)
	eth0: CPM ENET Version 0.2 on SCC2, 08:00:22:50:70:63
	RAMDISK: Compressed image found at block 0
	Freeing initrd memory: 4194300k freed
	loop: loaded (max 8 devices)
	NET4: Linux TCP/IP 1.0 for NET4.0
	IP Protocols: ICMP, UDP, TCP
	IP: routing cache hash table of 512 buckets, 4Kbytes
	TCP: Hash tables configured (established 512 bind 512)
	IP-Config: Incomplete network configuration information.
	NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
	EXT2-fs warning: checktime reached, running e2fsck is recommended
	VFS: Mounted root (ext2 filesystem).
	Freeing unused kernel memory: 44k init

	### Initial RAM disk starting interactive shell ###

	BusyBox v0.60.0 (2001.09.18-16:26+0000) Built-in shell (msh)
	Enter 'help' for a list of built-in commands.

 I don´t see any similar question in the mailing list.
 What do i forget or what and where i am doing wrong? I´m using an
unsupported card?
  Thank you for your help.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
