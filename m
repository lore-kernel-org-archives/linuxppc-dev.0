Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB659DE2A8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 00:11:38 +1000 (EST)
Date: Mon, 9 Jun 2008 09:11:29 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.26' branch
Message-ID: <Pine.LNX.4.64.0806090911070.27607@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.26' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.26

to receive the following updates:

 arch/powerpc/boot/dts/mpc8548cds.dts              |    4
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  155 +++++++---
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  162 +++++++----
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  146 ++++++----
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  150 ++++++----
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  157 +++++++---
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  150 ++++++----
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  146 ++++++----
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  146 ++++++----
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  146 ++++++----
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  222 +++++++++++----
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  140 ++++++---
 arch/powerpc/configs/85xx/ksi8560_defconfig       |  168 +++++++----
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |  133 ++++++---
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    |  210 +++++++++-----
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |  135 ++++++---
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    |  150 ++++++----
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    |  210 +++++++++-----
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |  137 ++++++---
 arch/powerpc/configs/85xx/sbc8548_defconfig       |  131 ++++++---
 arch/powerpc/configs/85xx/sbc8560_defconfig       |  135 ++++++---
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  152 ++++++----
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  147 ++++++----
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  146 ++++++----
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  146 ++++++----
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  146 ++++++----
 arch/powerpc/configs/adder875_defconfig           |   52 ++-
 arch/powerpc/configs/ep8248e_defconfig            |  124 +++++---
 arch/powerpc/configs/ep88xc_defconfig             |   47 ++-
 arch/powerpc/configs/linkstation_defconfig        |  172 +++++++----
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  136 ++++++---
 arch/powerpc/configs/mpc8272_ads_defconfig        |  126 +++++---
 arch/powerpc/configs/mpc83xx_defconfig            |  151 ++++++----
 arch/powerpc/configs/mpc85xx_defconfig            |  210 +++++++++-----
 arch/powerpc/configs/mpc8610_hpcd_defconfig       |  316 ++++++++++++----------
 arch/powerpc/configs/mpc8641_hpcn_defconfig       |  210 +++++++++-----
 arch/powerpc/configs/mpc866_ads_defconfig         |  128 +++++---
 arch/powerpc/configs/mpc885_ads_defconfig         |   47 ++-
 arch/powerpc/configs/pq2fads_defconfig            |  133 ++++++---
 arch/powerpc/configs/prpmc2800_defconfig          |  153 ++++++----
 arch/powerpc/configs/sbc8641d_defconfig           |  150 ++++++----
 arch/powerpc/configs/storcenter_defconfig         |   71 ++--
 arch/powerpc/platforms/85xx/Kconfig               |    1
 43 files changed, 3960 insertions(+), 2137 deletions(-)

Kumar Gala (3):
      [POWERPC] 85xx: MPC85xx MDS - Unconditionally select PHYLIB for board fixups
      [POWERPC] 85xx: MPC8548CDS - Fix size of PCIe IO space
      [POWERPC] Updated Freescale PPC defconfigs

Timur Tabi (1):
      [POWERPC] 8610: Update defconfig for MPC8610 HPCD

r
