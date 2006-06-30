Return-Path: <alancarbr@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.226])
	by ozlabs.org (Postfix) with ESMTP id 2F6C367B75
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 07:16:00 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i23so320250wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 14:15:59 -0700 (PDT)
Message-ID: <dc70db7d0606301409y3dfd285dr880d2fa350edace5@mail.gmail.com>
Date: Fri, 30 Jun 2006 15:09:41 -0600
From: "Alan Carvalho" <alancarbr@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Problem with Lite5200B
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi people,
I am trying to run Linux on Lite5200B board with no success.

Currently I am using a Lite5200 (IceCube) board too, and this board
work perfectly with this same set. (I am setting CONFIG_ICECUBE and
CONFIG_LITE5200B correctly), but IceCube don't detect my Video Card
(ATI Rage) otherwise Lite5200B detect it. I am using
lite5200b_defconfig as default.

Board: Lite5200B
Crosscompiler: DENX ELDK 3.1.1 3.3.3-9
Kernel: linuxppc_2_4_devel-2006-04-06-1735.tar.bz2
RootFS: debian powerpc 3.1

I tested also linux kernel 2.6.17 (using ELDK 4.0) with no success :-(

Some idea about it?

Thank you,

This is my "log" :

=> tftp 400000 uImage
Using FEC ETHERNET device
TFTP from server 10.2.241.166; our IP address is 10.2.241.100
Filename 'uImage'.
Load address: 0x400000
Loading: #################################################################
         #################################################################
         ###################
done
Bytes transferred = 761658 (b9f3a hex)
=> bootm 400000
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    761594 Bytes = 743.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=256Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (alan@diderot) (gcc version 3.3.3 (DENX ELDK
3.1.1 3.3.3-9)) #5 Sex Jun 30 17:6On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/hda3 rw
Calibrating delay loop... 307.20 BogoMIPS
Memory: 256724k available (1316k kernel code, 436k data, 72k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
ttyS0 on PSC1
ttyS1 on PSC2
ttyS2 on PSC3
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Port Config is: 0x91050004
ipb=132MHz, set clock period to 7
GPIO config: 91050004
ATA invalid: 01000000
ATA hostcnf: 03000000
ATA pio1   : 100a0a00
ATA pio2   : 02040600
XLB Arb cnf: 0000a366
mpc5xxx_ide: Setting up IDE interface ide0...
Probing IDE interface ide0...
hda: QUANTUM FIREBALL CX6.4A, ATA DISK drive
ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=13328/15/63
Partition check:
 hda: hda1 hda2 hda3 hda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init
INIT: version 2.86 booting
Couldnt get a file descriptor referring to the console
Couldnt get a file descriptor referring to the console
...
Couldnt get a file descriptor referring to the console
Couldnt get a file descriptor referring to the console
Couldnt get a file descrip
(I pressed Ctrl ^C)
Activating swap.
Checking root file system...
fsck 1.37 (21-Mar-2005)
/ was not cleanly unmounted, check forced.
Oops: kernel access of bad area, sig: 11
NIP: C0026C38 XER: 00000000 LR: C0026CF0 SP: CFB4FE80 REGS: cfb4fdd0
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00003E4C, DSISR: 20000000
TASK = cfb4e000[73] 'fsck.ext2' Last syscall: 3
last math cfb4e000 last altivec 00000000
GPR00: 00000CFF CFB4FE80 CFB4E000 00003E44 00000000 00000010 100CAC4C 00000000
GPR08: 00000000 0002D5A4 CFFC0000 0000FFFF 00159B92 1003A3F4 00000000 00000000
GPR16: 00000000 C0190000 C00272D8 00000001 CFC5A1E0 00000001 CFB4FEE0 00001000
GPR24: CFFA69C0 00000000 CFC5A1C0 00000000 000001C3 CFFED5A4 CFFA6A70 C0533E70
Call backtrace:
C0026CD4 C0027448 C0037604 C0005A5C 0FFDBF64 0FFDCBD8 0FFD6B64
0FFD6DC0 10009144 10007078 10006334 0FE12220 00000000
Warning... fsck.ext2 for device /dev/hda3 exited with signal 11.

fsck failed.  Please repair manually and reboot.  Please note
that the root file system is currently mounted read-only.  To
remount it read-write:

   # mount -n -o remount,rw /

CONTROL-D will exit from this shell and REBOOT the system.

Oops: kernel access of bad area, sig: 11
NIP: C0026444 XER: 00000000 LR: C0029208 SP: CFC83BE0 REGS: cfc83b30
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000E5A0, DSISR: 20000000
TASK = cfc82000[74] 'rcS' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 000278C8 CFC83BE0 CFC82000 C0192310 00000000 0000E598 00000000 CFC47548
GPR08: CFC47538 0000FFFF 00000001 CFFC0000 00001FFF 100C1E94 00000000 100C0000
GPR16: 00000000 00000000 100D1508 100CF368 CFC83C88 C01A1A14 C0190000 C0190000
GPR24: C00797C4 00000000 0C019231 00000000 C0192310 CFFE78C8 00000000 C0192260
Call backtrace:
C01730EC C00770D0 C0077448 C00775FC C007ADB8 C0043634 C0043F9C
C0044488 C0040ED8 C0041ACC C00088CC C0005A5C 00000000 10027C20
100279B0 100266D8 100231AC 100246C4 10023444 10022BD0 1002469C
10023444 10022BD0 100233FC 1005C864 1005C228 10063D64 10026C64
10027644 100267D0 100231AC 100246C4 10023444
/etc/init.d/rcS: line 279:    74 Segmentation fault      /sbin/sulogin $CONSOLE
Oops: kernel access of bad area, sig: 11
NIP: C0026444 XER: 00000000 LR: C0029208 SP: CFBFFD60 REGS: cfbffcb0
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000018C, DSISR: 20000000
TASK = cfbfe000[57] 'rcS' Last syscall: 195
last math cfbfe000 last altivec 00000000
GPR00: 000218B4 CFBFFD60 CFBFE000 CFC79310 00000000 00000184 00000000 CFC47448
GPR08: CFC47438 0000FFFF 00000001 CFFC0000 00001FFF 100C1E94 00000000 100C0000
GPR16: 00000000 00000000 100CF748 100C05E8 CFBFFE08 C01A1A14 C0190000 C0190000
GPR24: C00797C4 00000000 0CFC7931 00000000 CFC79310 CFFE18B4 00000000 CFC79260
Call backtrace:
00000000 C00770D0 C0077448 C00775FC C007ADB8 C0043634 C0043F9C
C0044488 C00447D0 C0040538 C0005A5C 00000000 10052C68 10053470
10053724 10053048 1002786C 100266D8 100231AC 100246C4 10023444
10022BD0 100233FC 1005C864 1005C228 10063D64 10026C64 10027644
100267D0 100231AC 100246C4 10023444 10024214
/etc/init.d/rcS: line 57:    57 Segmentation fault      ( trap - INT
QUIT TSTP; set start; . $i )
Oops: kernel access of bad area, sig: 11
NIP: C0026444 XER: 00000000 LR: C0029208 SP: CFE4DD60 REGS: cfe4dcb0
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00007B68, DSISR: 20000000
TASK = cfe4c000[8] 'rcS' Last syscall: 195
last math cfe4c000 last altivec 00000000
GPR00: 00027B20 CFE4DD60 CFE4C000 C0192C70 00000000 00007B60 00000000 CFCCBC08
GPR08: CFCCBBF8 0000FFFF 00000001 CFFC0000 00001FFF 100C1E94 00000000 100C0000
GPR16: 00000000 00000000 00000000 100C0448 CFE4DE08 C01A1A14 C0190000 C0190000
GPR24: C00797C4 00000000 0C0192C7 00000000 C0192C70 CFFE7B20 00000000 C0192BC0
Call backtrace:
C003A048 C00770D0 C0077448 C00775FC C007ADB8 C0043634 C0043B38
C0044488 C00447D0 C0040538 C0005A5C 00000000 10046180 100470F0
10046EB4 10047660 10047798 10047918 10063F38 10026C64 10027644
100267D0 100231AC 10022BD0 10024814 10023444 10022BD0 1002469C
10023444 10022BD0 10024A38 10023380 10022BD0
Oops: kernel access of bad area, sig: 11
NIP: C0026444 XER: 00000000 LR: C0029208 SP: C0557D20 REGS: c0557c70
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000888C, DSISR: 20000000
TASK = c0556000[1] 'init' Last syscall: 33
last math 00000000 last altivec 00000000
GPR00: 0002CF10 C0557D20 C0556000 CFFA6C50 00000000 00008884 00000000 CFCCBB08
GPR08: CFCCBAF8 0000FFFF 00000001 CFFC0000 00001FFF 1001F568 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 C0557DC8 C01A1A14 C0190000 C0190000
GPR24: C00797C4 00000000 0CFFA6C5 00000000 CFFA6C50 CFFECF10 00000000 CFFA6BA0
Call backtrace:
00000000 C00770D0 C0077448 C00775FC C007ADB8 C0043634 C0043B38
C0044488 C00447D0 C003632C C0005A5C 3000B3B4 100064C0 100053D0
100057E0 10005E7C 0FEBE220 00000000
Kernel panic: Attempted to kill init!
