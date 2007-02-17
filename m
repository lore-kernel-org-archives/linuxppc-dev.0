Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D6E8DDE06
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 09:41:03 +1100 (EST)
Date: Sat, 17 Feb 2007 16:38:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch
Message-ID: <Pine.LNX.4.64.0702171636550.11791@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/boot/dts/mpc8313erdb.dts      |   62 -
 arch/powerpc/boot/dts/mpc8323emds.dts      |  344 ---------
 arch/powerpc/boot/dts/mpc832x_mds.dts      |  333 ++++++++
 arch/powerpc/boot/dts/mpc8349emitx.dts     |   60 -
 arch/powerpc/boot/dts/mpc8349emitxgp.dts   |   39 -
 arch/powerpc/boot/dts/mpc834x_mds.dts      |  164 ++--
 arch/powerpc/boot/dts/mpc8360emds.dts      |  374 ---------
 arch/powerpc/boot/dts/mpc836x_mds.dts      |  363 +++++++++
 arch/powerpc/boot/dts/mpc8540ads.dts       |  142 +--
 arch/powerpc/boot/dts/mpc8541cds.dts       |  108 +-
 arch/powerpc/boot/dts/mpc8548cds.dts       |  129 +--
 arch/powerpc/boot/dts/mpc8555cds.dts       |  108 +-
 arch/powerpc/boot/dts/mpc8560ads.dts       |  157 +---
 arch/powerpc/boot/dts/mpc8568mds.dts       |   96 +-
 arch/powerpc/configs/mpc832x_mds_defconfig | 1083 ++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc832xemds_defconfig | 1083 ----------------------------
 arch/powerpc/configs/mpc8360emds_defconfig | 1082 ----------------------------
 arch/powerpc/configs/mpc836x_mds_defconfig | 1099 +++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc8568mds_defconfig  |   32
 arch/powerpc/platforms/83xx/Kconfig        |    8
 arch/powerpc/platforms/83xx/Makefile       |    2
 arch/powerpc/platforms/83xx/mpc8313_rdb.c  |   11
 arch/powerpc/platforms/83xx/mpc832x_mds.c  |   65 -
 arch/powerpc/platforms/83xx/mpc834x_itx.c  |   23
 arch/powerpc/platforms/83xx/mpc834x_mds.c  |   27
 arch/powerpc/platforms/83xx/mpc8360e_pb.c  |  237 ------
 arch/powerpc/platforms/83xx/mpc836x_mds.c  |  206 +++++
 arch/powerpc/platforms/85xx/Kconfig        |    8
 arch/powerpc/platforms/85xx/Makefile       |    2
 arch/powerpc/platforms/85xx/mpc8568_mds.c  |  246 ------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |   14
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   15
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |  234 ++++++
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    9
 arch/powerpc/sysdev/qe_lib/ucc_fast.c      |  163 +---
 arch/powerpc/sysdev/qe_lib/ucc_slow.c      |  137 +--
 include/asm-powerpc/ucc_slow.h             |    8
 37 files changed, 3994 insertions(+), 4279 deletions(-)

Jon Loeliger (2):
      [POWERPC] 8[56]xx: Remove obsolete setting of ROOT_DEV for 85xx and 86xx platforms.
      [POWERPC] 86xx: Add missing of_node_put() in mpc86xx_hpcn_init_irq().

Kumar Gala (10):
      [POWERPC] 83xx: Cleaned up 83xx platform dts files
      [POWERPC] 83xx: Cleaning up machine probing and board initcalls
      [POWERPC] 83xx: Remove obsolete setting of ROOT_DEV.
      [POWERPC] 83xx: use default value of loops_per_jiffy
      [POWERPC] 83xx: Use of_platform_bus_probe to setup QE devices
      [POWERPC] 83xx: Updated and renamed MPC8360PB to MPC836x MDS
      [POWERPC] 83xx: Renamed MPC8323 MDS dts and defconfig to match other boards
      [POWERPC] 85xx: Cleaned up platform dts files
      [POWERPC] 85xx: Cleaning up machine probing
      [POWERPC] 85xx: Renamed MPC8568 MDS board code to match other boards

Timur Tabi (1):
      [POWERPC] QE: clean up ucc_slow.c and ucc_fast.c
