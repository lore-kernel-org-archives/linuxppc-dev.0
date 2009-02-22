Return-Path: <wb1hbu@runbox.com>
Received: from aibo.runbox.com (aibo.runbox.com [87.238.52.70])
	by ozlabs.org (Postfix) with ESMTP id 1CB16DDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 10:44:11 +1100 (EST)
Received: from [10.9.9.131] (helo=garm.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.50) id 1LbNft-0003wI-Qs
	for linuxppc-dev@ozlabs.org; Mon, 23 Feb 2009 00:23:53 +0100
Received: from mail by garm.runbox.com with local  (Exim 4.50)
	id 1LbNft-0007z6-Pf
	for linuxppc-dev@ozlabs.org; Mon, 23 Feb 2009 00:23:53 +0100
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Received: from [216.181.87.99] by www.runbox.com with http (uid:608409)
	(RMM 4.0); for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 23:23:53 GMT
From: "Eric Cottrell" <wb1hbu@runbox.com>
To: linuxppc-dev@ozlabs.org
Subject: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
Date: Sun, 22 Feb 2009 18:23:53 -0500 (EST)
Message-Id: <E1LbNft-0007z6-Pf@garm.runbox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

This is getting frustrating and I am beginning to think someone messed this=
 board up and returned it.  I would think it would boot up the default flas=
h image out of the box with very little trouble.

Board is a MPC8313e-RDB Rev A4.  I set the dip switches per the instruction=
s, S4 all off and S3 all on.
Uboot comes up but I can not boot either the default images in the flash or=
 images I built with ltib and tftped.  I did not touch the flash.  I get WA=
RNING: could not set linux,stdout-path FDT_ERR_NOTFOUND and ERROR: /chosen =
node create failed - must RESET the board to recover.  The board resets.

A friend has the same board but his U-Boot is Version 1.3.0 (Jun 19 2008 - =
13:41:53) MPC83XX and some environment variables are different.  I do not h=
ave the BOOTCMD variable but entered it manually.

I tried searching for on a solution but it is confusing because if aliases =
are needed why does the default dtb in the flash omit them?

This is what happens:

U-Boot 1.3.3 (Dec  8 2008 - 09:51:15) MPC83XX

Reset Status:

CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.666 MHz
Board: Freescale MPC8313ERDB
I2C:   ready
DRAM:  128 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
=3D> bootm fe100000 fe300000 fe700000
## Booting kernel from Legacy Image at fe100000 ...
   Image Name:   Linux-2.6.20
   Created:      2007-08-24  14:59:01 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1722821 Bytes =3D  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at fe700000
   Booting using the fdt blob at 0xfe700000
## Loading init Ramdisk from Legacy Image at fe300000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Created:      2007-08-24  15:01:41 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2831355 Bytes =3D  2.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Device Tree to 007fd000, end 007fffff ... OK
WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND.
ERROR: /chosen node create failed - must RESET the board to recover.
Resetting the board.


U-Boot 1.3.3 (Dec  8 2008 - 09:51:15) MPC83XX

Reset Status: Software Hard, External/Internal Soft, External/Internal Hard

CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.666 MHz
Board: Freescale MPC8313ERDB
I2C:   ready
DRAM:  128 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
=3D>=20

73 Eric
