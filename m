Return-Path: <apoorvsangal@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.205])
	by ozlabs.org (Postfix) with ESMTP id 09DA967BB9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jul 2005 14:25:22 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 40so51102nzk
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Jul 2005 21:25:21 -0700 (PDT)
Message-ID: <a796693605070621187c9394d5@mail.gmail.com>
Date: Thu, 7 Jul 2005 09:48:53 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: vikrant_basotra@satyam.com, nishant_galange@satyam.com,
	apoorv sangal <apoorv_sangal@satyam.com>
Subject: Porting Linux On MPC8266 custom board
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
=09=09I am porting Linux on MPC8266 custom board, after getting in to
Linux the system seems to be struck at a point.
Saved Environment variable:-
      bootargs console=3DttyS0,11520 root=3D1f00 and downloaded the Kernel
image at address 0x02000000 in the RAM.
>From the u-boot prompt the bootm command is invoked as:-=20
=09bootm 0x02000000

After that what I get on the terminal is pasted below for your reference.
I couldn't make out any thing from the output, can any body tell me
where I am doing wrong, and also I don't have any idea about the
bootargs argument "root". Can any body give the precise description of
this argument?


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
=3D> bootm 02000000 ## Booting image at 02000000...
   Image Name:   2.4.24 MPC8260ADS
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    725838 Bytes =3D 708.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb

Linux version 2.4.24-pre2 (root@pmcserver) (gcc version 3.3.4) #2 Tue
Jul 5 15:05:10 IST 2005

On node 0 totalpages: 32768

zone(0): 32768 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200 root=3D1f00

Warning: real time clock seems stuck!

Calibrating delay loop... 131.89 BogoMIPS

Memory: 127812k available (1232k kernel code, 412k data, 64k init, 0k highm=
em)

Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

Inode cache hash table entries: 8192 (order: 4, 65536 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)

Page-cache hash table entries: 32768 (order: 5, 131072 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications =
AB.

i2c-core.o: i2c core module version 2.6.1 (20010830)

i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)

CPM UART driver version 0.01

ttyS0 on SMC1 at 0x0000, BRG7

ttyS1 on SMC2 at 0x0040, BRG8

ttyS2 on SCC1 at 0x8000, BRG1

ttyS3 on SCC2 at 0x8100, BRG2

pty: 256 Unix98 ptys configured
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
=09
Waiting eagerly,
Regards,
VB
