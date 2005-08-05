Return-Path: <apoorvsangal@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id B2FD467EEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 20:39:00 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so327456nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 05 Aug 2005 03:38:59 -0700 (PDT)
Message-ID: <a796693605080503383ce43419@mail.gmail.com>
Date: Fri, 5 Aug 2005 16:08:59 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: sibi_mathew@satyam.com, vikrant_basotra@satyam.com,
	nishant_galange@satyam.com, apoorv sangal <apoorv_sangal@satyam.com>
Subject: Problem related to root filesystem
Reply-To: apoorv sangal <apoorvsangal@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
=09I am porting Linux on the custom board PMC8266 (having MPC8266
microprocessor) based on the ADS8260 board.I am using ELDK1.1.1 and
Linux2.4.24.

I am trying to load JFFS2 filesystem , the JFFS2 filesystem image is
at address 0xFC160000 and the flash size is 32mb

I am getting the following messages:-
physmap flash device: 2000000 at fc160000

CFI: Found no Physically mapped flash device at location zero

kmod: failed to exec /sbin/modprobe -s -k jedec_probe, errno =3D 2

kmod: failed to exec /sbin/modprobe -s -k map_rom, errno =3D 2

pmc8260 flash map (size->0x2000000 mem->0xFC160000)

CFI: Found no pmc8260 flash memory device at location zero

Can anyone please tell me what is happening and how can i set it right??

***************************************************************************=
**
The whole of captured output is as following:-
***************************************************************************=
**
Image Name:   2.4.24 ADS8260
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    302270 Bytes =3D 295.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ...=20

Linux version 2.4.24-pre2 (satyam@pmcserver) (gcc version 3.2.2
20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #20 Fri Aug 5 15:22:28 IST
2005

On node 0 totalpages: 32768

zone(0): 32768 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200 root=3DFC160000 rw rootfstype=
=3Djffs2

Warning: real time clock seems stuck!

Calibrating delay loop... 131.89 BogoMIPS

Memory: 128712k available (512k kernel code, 260k data, 36k init, 0k highme=
m)

Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

Inode cache hash table entries: 8192 (order: 4, 65536 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)

Page-cache hash table entries: 32768 (order: 5, 131072 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Starting kswapd

Inside Chr_dev_init

CPM UART driver version 0.01

ttyS0 on SMC1 at 0x0000, BRG7

ttyS1 on SMC2 at 0x0040, BRG8

ttyS2 on SCC1 at 0x8000, BRG1

ttyS3 on SCC2 at 0x8100, BRG2

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

physmap flash device: 2000000 at fc160000

CFI: Found no Physically mapped flash device at location zero

kmod: failed to exec /sbin/modprobe -s -k jedec_probe, errno =3D 2

kmod: failed to exec /sbin/modprobe -s -k map_rom, errno =3D 2

pmc8260 flash map (size->0x2000000 mem->0xFC160000)

CFI: Found no pmc8260 flash memory device at location zero

*****

VFS:test name =3D /dev/root

VFS:fs_name =3D jffs2=20

VFS:root name =3D 00:00

 ****=20

kmod: failed to exec /sbin/modprobe -s -k jffs2, errno =3D 2

VFS:tried fs_name =3D jffs2 err =3D -19

VFS: Cannot open root device "FC160000" or 00:00

Please append a correct "root=3D" boot option

Kernel panic: VFS: Unable to mount root fs on 00:00

 <0>Rebooting in 180 seconds..

Response awaited from the list.

Regards,
Apoorv Sangal
