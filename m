Return-Path: <SSparks@aclaratech.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id A59D9DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 02:12:16 +1000 (EST)
Received: from mail4-sin (localhost.localdomain [127.0.0.1])	by
	mail4-sin-R.bigfish.com (Postfix) with ESMTP id 582FCD68360	for
	<linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:12:13 +0000 (UTC)
Received: from acl-exch.aclaratech.com (unknown [68.89.149.23])	by
	mail4-sin.bigfish.com (Postfix) with ESMTP id CB38EDC804F	for
	<linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:12:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: mpc8349-mITX DTB load failure
Date: Mon, 28 Jul 2008 11:10:47 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I am trying to boot the mpc8349-mITX board with Compact flash support,
and am unable to boot the Linux kernel. Here is the pertinant versioning
information:
DTC 1.2.0-rc2-g17773b0e
U-Boot 1.3.4-rc1-00012-g1953d12
Linux-2.6.26-05752-g93ded9b

I've built the DTB using the following two commands - neither change the
error I get during boot-up.
$ ../dtc/dtc -b 0 -I dts -O dtb -R 4 -S 0x3000 -o
/tftproot/ssparks/itx/cf2/itx.dtb -V 17
arch/powerpc/boot/dts/mpc8349emitx.dts
$ ../dtc/dtc -I dts -O dtb -o /tftproot/ssparks/itx/cf2/itx2.dtb
arch/powerpc/boot/dts/mpc8349emitx.dts

Can anyone shed any light onto what I am doing to cause the following
error? I haven't been able to find this error message in the mailing
list or by asking google...
## Booting kernel from Legacy Image at 01001000 ...
   Image Name:   Linux-2.6.26-05752-g93ded9b
   Created:      2008-07-24  20:40:59 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1708661 Bytes =3D  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 01000000
   Booting using the fdt blob at 0x1000000
   Loading Device Tree to 007fb000, end 007ff526 ... OK
WARNING: could not create /chosen FDT_ERR_BADSTRUCTURE.
ERROR: /chosen node create failed - must RESET the board to recover.
Resetting the board.

Thanks for the help,
Sam
