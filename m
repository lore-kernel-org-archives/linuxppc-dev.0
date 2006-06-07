Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A5659679E9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 08:36:20 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k57Mr3MR027535
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:53:03 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k57MaI5V001238
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 17:36:18 -0500 (CDT)
Subject: [PATCH 0/10] Add MPC8641 HPCN Platform
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149719542.23938.181.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 07 Jun 2006 17:32:22 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches introduces the MPC8641 HPCN platform.

Please consider this for addition into the 2.6.18 queue.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Jeff Brown <Jeff.Brown@freescale.com>
Signed-off-by: Kriston Carson <KristonCarson@freescale.com>


 arch/powerpc/Kconfig                        |   15 
 arch/powerpc/platforms/Makefile             |    1 
 arch/powerpc/platforms/86xx/Makefile        |    7 
 arch/powerpc/platforms/86xx/Kconfig         |   46 +
 drivers/i2c/busses/Kconfig                  |    4 

 arch/powerpc/platforms/86xx/misc.c          |   50 +
 arch/powerpc/platforms/86xx/mpc8641_hpcn.c  |   52 ++
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h  |   54 ++
 arch/powerpc/platforms/86xx/mpc86xx.h       |   31 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c  |  313 +++++++++

 arch/powerpc/platforms/86xx/pci.c           |  213 ++++++
 arch/powerpc/platforms/86xx/pex.c           |  173 +++++

 arch/powerpc/kernel/cpu_setup_6xx.S         |    2 

 arch/powerpc/kernel/cputable.c              |   12 
 arch/powerpc/kernel/head_32.S               |   15 
 arch/powerpc/sysdev/i8259.c                 |    5 

 include/asm-powerpc/immap_86xx.h            |  199 ++++++
 include/asm-powerpc/irq.h                   |   88 +++
 include/asm-powerpc/mpc86xx.h               |   95 +++
 include/asm-powerpc/reg.h                   |    1 

 include/asm-ppc/io.h                        |    2 
 include/asm-ppc/ppc_sys.h                   |    2 
 include/asm-ppc/serial.h                    |    2 

 arch/powerpc/configs/mpc8641_hpcn_defconfig |  923 +++++++++++++++++++++++++++

 drivers/net/Kconfig                         |    6 
 drivers/net/phy/Kconfig                     |    5 
 drivers/net/phy/Makefile                    |    1 
 drivers/net/phy/vitesse.c                   |  136 ++++

 arch/powerpc/kernel/prom.c                  |   13 

 29 files changed, 2457 insertions(+), 9 deletions(-)
