Return-Path: <chris@alcor.co.uk>
Received: from mizar.alcor-electronics.co.uk (alcor.demon.co.uk [62.49.62.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB2922BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 22:17:26 +1100 (EST)
Received: from alcor1 ([192.168.1.1])
	by mizar.alcor-electronics.co.uk with esmtp (Exim 4.30)
	id 1CSZAa-00018e-BK
	for linuxppc-embedded@ozlabs.org; Fri, 12 Nov 2004 11:00:44 +0000
From: "Chris Down" <chris@alcor.co.uk>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 12 Nov 2004 11:00:44 -0000
Message-ID: <004201c4c8a6$db904cd0$0101a8c0@alcor1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Problem bringing up Linux on Custom MPC522 Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to bring up Linux (latest linuxppc-2.4 tree) on a custom =
MPC852
Board. The board has 8MByte SDRAM and 8MByte Flash.=20
I have ported u-boot, modified Linux to add a new board config and added =
the
board specific definitions in arch/ppc/platforms.=20
U-Boot and Linux were built using the ppc_8xx compiler from ELDK 3.0.

When I boot Linux I get the following:-

## Booting image at 00100000 ...
   Image Name:   Linux-2.4.28-pre3-cdd1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    664920 Bytes =3D 649.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.28-pre3-cdd1 (chris@alioth) (gcc version 3.2.2 =
20030217 (Yello
w Dog Linux 3.0 3.2.2-2a_1)) #3 Fri Nov 12 09:46:59 GMT 2004
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Decrementer Frequency =3D 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 6508k available (1176k kernel code, 344k data, 56k init, 0k =
highmem)
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode cache hash table entries: 512 (order: 0, 4096 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX

At this point it stops executing in arch_kernel_thread.

As I am new to this I could do with some pointers as to what to do next. =
Any
help would be gratefully appreciated.


Regards

Chris Down
