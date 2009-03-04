Return-Path: <frederic.leger@esisar.grenoble-inp.fr>
Received: from mx1.esisar.inpg.fr (mx1.esisar.inpg.fr [195.220.37.33])
	by ozlabs.org (Postfix) with ESMTP id 4DA6EDE10A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 05:00:49 +1100 (EST)
Received: from mx1.esisar.inpg.fr (mx1 [127.0.0.1])
	by localhost.esisar.inpg.fr (Postfix) with ESMTP id 413B273563
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 18:21:23 +0100 (CET)
Received: from cameron.esisar.inpg.fr (unknown [172.20.253.25])
	by mx1.esisar.inpg.fr (Postfix) with ESMTP id 22F437355F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 18:21:23 +0100 (CET)
Received: from esO422 (eso422.esisar.inpg.fr [172.20.4.62])
	by cameron.esisar.inpg.fr (Postfix) with ESMTP id 7B69B51FC88
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 18:36:07 +0100 (CET)
From: "Frederic LEGER" <frederic.leger@esisar.grenoble-inp.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: GDB problem with Xilinx GIT Linux on Virtex5FX PPC440
Date: Wed, 4 Mar 2009 18:36:33 +0100
Message-ID: <000701c99cef$c27da220$3e0414ac@esisar.inpg.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

At the moment I can't set any breakpoint under gdb or gdbserver on ML510 and
AVNETV5FX30T, if I set one => die "continuing...".

Everything else is OK for a while on both boards: cross-compiling, dhcp,
netperf, custom apps, .... but not debugging !

If you have a working gdb (and/or gdbserver) on PPC440 Linux , could you
please anwer this message with the following piece of information:

Board
kernel revision
kernel snapshot (day/number) used from Xilinx GIT
defconfig used
toolchain (ELDK/buildroot...)
toolchain version
location of the rootfs (ramdisk, SysACE partition, flash Uboot partition)
Type of the rootfs 

Thank you very much in advance.

Best regards,

Frederic
 
