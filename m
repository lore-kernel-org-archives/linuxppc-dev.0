Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B509CDE089
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 13:04:37 +1100 (EST)
Date: Mon, 26 Jan 2009 20:04:28 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch for 2.6.29
Message-ID: <Pine.LNX.4.64.0901262003480.19010@blarg.am.freescale.net>
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

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/boot/dts/mpc8313erdb.dts             |    2
 arch/powerpc/boot/dts/mpc8572ds.dts               |    2
 arch/powerpc/configs/83xx/asp8347_defconfig       |   91 +++++++++-----
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  103 +++++++++++----
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  103 +++++++++++----
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |   86 +++++++++----
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |   89 +++++++++----
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  100 ++++++++++-----
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |   98 ++++++++++-----
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |   84 ++++++++----
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |   93 ++++++++++----
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |   88 +++++++++----
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |   84 ++++++++----
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |   90 +++++++++----
 arch/powerpc/configs/83xx/sbc834x_defconfig       |   74 +++++++----
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   79 ++++++++----
 arch/powerpc/configs/85xx/mpc8536_ds_defconfig    |  111 ++++++++++++-----
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   66 ++++++----
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    |  111 ++++++++++++-----
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   73 +++++++----
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    |   86 +++++++++----
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    |   80 +++++++++---
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   69 +++++++---
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   60 ++++++---
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   66 ++++++----
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |   88 +++++++++----
 arch/powerpc/configs/85xx/tqm8540_defconfig       |   81 ++++++++----
 arch/powerpc/configs/85xx/tqm8541_defconfig       |   88 +++++++++----
 arch/powerpc/configs/85xx/tqm8548_defconfig       |   84 +++++++++---
 arch/powerpc/configs/85xx/tqm8555_defconfig       |   88 +++++++++----
 arch/powerpc/configs/85xx/tqm8560_defconfig       |   88 +++++++++----
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  136 ++++++++++++++++----
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |   83 ++++++++----
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  111 ++++++++++++-----
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  102 +++++++++++----
 arch/powerpc/configs/adder875_defconfig           |   65 ++++++----
 arch/powerpc/configs/c2k_defconfig                |  118 ++++++++++++------
 arch/powerpc/configs/ep8248e_defconfig            |   77 ++++++++---
 arch/powerpc/configs/ep88xc_defconfig             |   65 ++++++----
 arch/powerpc/configs/linkstation_defconfig        |  110 ++++++++++------
 arch/powerpc/configs/mgcoge_defconfig             |   74 ++++++++---
 arch/powerpc/configs/mgsuvd_defconfig             |   63 ++++++---
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   71 +++++++---
 arch/powerpc/configs/mpc8272_ads_defconfig        |   77 ++++++++---
 arch/powerpc/configs/mpc83xx_defconfig            |  107 +++++++++++-----
 arch/powerpc/configs/mpc85xx_defconfig            |  120 +++++++++++++-----
 arch/powerpc/configs/mpc866_ads_defconfig         |   64 ++++++---
 arch/powerpc/configs/mpc86xx_defconfig            |  143 +++++++++++++++++-----
 arch/powerpc/configs/mpc885_ads_defconfig         |   65 ++++++----
 arch/powerpc/configs/pq2fads_defconfig            |   87 +++++++++----
 arch/powerpc/configs/prpmc2800_defconfig          |   96 ++++++++++----
 arch/powerpc/configs/storcenter_defconfig         |   85 ++++++++-----
 arch/powerpc/platforms/83xx/mpc831x_rdb.c         |    1
 53 files changed, 3120 insertions(+), 1305 deletions(-)

Kumar Gala (6):
      powerpc/85xx: Fix typo in mpc8572ds dts
      powerpc/85xx: Update defconfigs
      powerpc/83xx: Update defconfigs
      powerpc/86xx: Update defconfigs
      powerpc/8xx: Update defconfigs
      powerpc/embedded6xx: Update defconfigs

Li Yang (1):
      powerpc/mpc8313erdb: fix kernel panic because mdio device is not probed

(pretty much defconfig updates and two small fixes).

- k
