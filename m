Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E00E267C3F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 07:58:47 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k58MFWL2028749
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:15:32 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58LwjpD019434
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 16:58:45 -0500 (CDT)
Subject: [PATCH 0/10] Version 2 -- Add MPC8641 HPCN Platform
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149803684.23938.273.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 16:54:44 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the second posting of a series of patches
that introduces the MPC8641 HPCN platform.  This
version corrects all of the suggestions from Kumar,
and shows an ACK from Jeff Garzik for the netdev
related parts.

Please consider this for addition into the 2.6.18 queue.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Jeff Brown <Jeff.Brown@freescale.com>
Signed-off-by: Kriston Carson <KristonCarson@freescale.com>

1)
 arch/powerpc/Kconfig                        |   15 
 arch/powerpc/platforms/Makefile             |    1 
 arch/powerpc/platforms/86xx/Kconfig         |   46 +
 arch/powerpc/platforms/86xx/Makefile        |    7 

2)
 arch/powerpc/platforms/86xx/misc.c          |   51 +
 arch/powerpc/platforms/86xx/mpc8641_hpcn.c  |   52 ++
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h  |   54 ++
 arch/powerpc/platforms/86xx/mpc86xx.h       |   31 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c  |  304 +++++++++

3)
 arch/powerpc/platforms/86xx/pci.c           |  213 ++++++
 arch/powerpc/platforms/86xx/pex.c           |  173 +++++

4)
 arch/powerpc/kernel/cpu_setup_6xx.S         |    2 

5)
 arch/powerpc/kernel/cputable.c              |   12 
 arch/powerpc/kernel/head_32.S               |   15 
 arch/powerpc/sysdev/i8259.c                 |    5 

6)
 include/asm-powerpc/immap_86xx.h            |  199 ++++++
 include/asm-powerpc/irq.h                   |   88 +++
 include/asm-powerpc/mpc86xx.h               |   47 +

7)
 arch/powerpc/configs/mpc8641_hpcn_defconfig |  920 +++++++++++++++++++++++++++

8)
 drivers/net/Kconfig                         |    6 
 drivers/net/phy/Kconfig                     |    5 
 drivers/net/phy/Makefile                    |    1 
 drivers/net/phy/vitesse.c                   |  112 +++

9)
 arch/powerpc/kernel/prom.c                  |   13 

10)
 drivers/i2c/busses/Kconfig                  |    4 

 25 files changed, 2367 insertions(+), 9 deletions(-)
