Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FF54DDFE6
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 08:32:07 +1000 (EST)
Date: Wed, 13 May 2009 17:31:59 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch for 2.6.30
Message-ID: <Pine.LNX.4.64.0905131731260.772@localhost.localdomain>
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

Just added defconfig updates for the normal FSL set of HW.

- k

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/configs/83xx/asp8347_defconfig       |  104 ++++-
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  114 ++++--
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  114 ++++--
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  107 ++++--
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  113 ++++--
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  108 ++++--
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  108 ++++--
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  103 ++++-
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  108 ++++--
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |   96 ++++-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  104 ++++-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  111 ++++--
 arch/powerpc/configs/83xx/sbc834x_defconfig       |   96 ++++-
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   86 +++-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   82 +++-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   89 +++--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   88 +++--
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   84 +++-
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   83 +++-
 arch/powerpc/configs/85xx/socrates_defconfig      |  385 ++++++++++++++++------
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  105 ++++--
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  100 ++++-
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  101 ++++-
 arch/powerpc/configs/85xx/tqm8548_defconfig       |   64 ++-
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  101 ++++-
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  101 ++++-
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |   92 ++++-
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |   92 ++++-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  122 +++++-
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  100 ++++-
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  211 ++++--------
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  114 ++++--
 arch/powerpc/configs/adder875_defconfig           |   65 ++-
 arch/powerpc/configs/c2k_defconfig                |  128 +++++--
 arch/powerpc/configs/ep8248e_defconfig            |   74 +++-
 arch/powerpc/configs/ep88xc_defconfig             |   63 ++-
 arch/powerpc/configs/linkstation_defconfig        |   96 ++++-
 arch/powerpc/configs/mgcoge_defconfig             |   74 +++-
 arch/powerpc/configs/mgsuvd_defconfig             |   72 +++-
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   91 +++--
 arch/powerpc/configs/mpc8272_ads_defconfig        |   77 +++-
 arch/powerpc/configs/mpc83xx_defconfig            |  115 ++++--
 arch/powerpc/configs/mpc866_ads_defconfig         |   77 +++-
 arch/powerpc/configs/mpc86xx_defconfig            |  211 ++++--------
 arch/powerpc/configs/mpc885_ads_defconfig         |   63 ++-
 arch/powerpc/configs/pq2fads_defconfig            |   90 +++--
 arch/powerpc/configs/prpmc2800_defconfig          |  120 +++++-
 arch/powerpc/configs/storcenter_defconfig         |   71 ++--
 arch/powerpc/sysdev/fsl_soc.c                     |   46 --
 49 files changed, 3630 insertions(+), 1489 deletions(-)

Anton Vorontsov (1):
      powerpc/fsl_soc: Remove mpc83xx_wdt_init, again

Kumar Gala (5):
      powerpc/83xx: Update defconfigs
      powerpc/85xx: Update defconfigs
      powerpc/86xx: Update defconfigs
      powerpc/embedded6xx: Update defconfigs
      powerpc/8xx: Update defconfigs
