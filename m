Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D0DA6B7BA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:39:00 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DA4ADDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:38:59 +1000 (EST)
Date: Wed, 29 Jul 2009 23:38:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch for 2.6.31
Message-ID: <Pine.LNX.4.64.0907292338080.25284@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

This is pretty much some bug fixes and defconfig updates.

- k

to receive the following updates:

 arch/powerpc/boot/dts/mpc8377_rdb.dts             |    2
 arch/powerpc/boot/dts/mpc8378_rdb.dts             |    2
 arch/powerpc/boot/dts/mpc8379_rdb.dts             |    2
 arch/powerpc/boot/dts/mpc8569mds.dts              |    4
 arch/powerpc/configs/83xx/asp8347_defconfig       |  106 ++--
 arch/powerpc/configs/83xx/kmeter1_defconfig       |  176 ++++---
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  168 +++++--
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  168 +++++--
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  111 ++--
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  120 ++---
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  114 ++--
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  114 ++--
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  104 ++--
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  111 ++--
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  104 ++--
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  110 ++--
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  162 ++++--
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  103 ++--
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   93 ++-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   91 ++-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   99 ++--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   99 ++--
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   96 ++--
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   91 ++-
 arch/powerpc/configs/85xx/socrates_defconfig      |  165 ++++--
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  119 +++--
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  100 ++--
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  101 ++--
 arch/powerpc/configs/85xx/tqm8548_defconfig       |  100 ++--
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  101 ++--
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  101 ++--
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  118 ++--
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  521 ++++++++--------------
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |  216 ++++++---
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  130 +++--
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  118 +++-
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  186 +++----
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  112 +++-
 arch/powerpc/configs/adder875_defconfig           |   97 ++--
 arch/powerpc/configs/c2k_defconfig                |  121 +++--
 arch/powerpc/configs/ep8248e_defconfig            |   97 ++--
 arch/powerpc/configs/ep88xc_defconfig             |   91 ++-
 arch/powerpc/configs/linkstation_defconfig        |  116 +++-
 arch/powerpc/configs/mgcoge_defconfig             |   97 ++--
 arch/powerpc/configs/mgsuvd_defconfig             |   89 ++-
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  103 ++--
 arch/powerpc/configs/mpc8272_ads_defconfig        |  104 ++--
 arch/powerpc/configs/mpc83xx_defconfig            |  162 ++++--
 arch/powerpc/configs/mpc85xx_defconfig            |  193 +++-----
 arch/powerpc/configs/mpc85xx_smp_defconfig        |  193 +++-----
 arch/powerpc/configs/mpc866_ads_defconfig         |   92 ++-
 arch/powerpc/configs/mpc86xx_defconfig            |  186 +++----
 arch/powerpc/configs/mpc885_ads_defconfig         |   91 ++-
 arch/powerpc/configs/pq2fads_defconfig            |  110 ++--
 arch/powerpc/configs/prpmc2800_defconfig          |  158 ++++--
 arch/powerpc/configs/storcenter_defconfig         |  108 ++--
 arch/powerpc/mm/mmu_context_nohash.c              |    1
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   13
 drivers/serial/cpm_uart/cpm_uart_cpm2.c           |    2
 59 files changed, 4007 insertions(+), 2755 deletions(-)

Anton Vorontsov (3):
      powerpc/85xx: Fix ethernet link detection on MPC8569E-MDS boards
      powerpc/85xx: Don't scan for TBI PHY addresses on MPC8569E-MDS boards
      powerpc/83xx: Fix PCI IO base address on MPC837xE-RDB boards

Kumar Gala (2):
      powerpc/mm: Fix SMP issue with MMU context handling code
      powerpc: Update defconfigs for embedded 6xx/7xxx, 8xx, 8{3,5,6}xxx

Mark Ware (1):
      cpm_uart: Don't use alloc_bootmem in cpm_uart_cpm2.c

Martyn Welch (2):
      powerpc/86xx: Update defconfig for GE Fanuc's PPC9A
      powerpc/86xx: Update GE Fanuc sbc310 default configuration
