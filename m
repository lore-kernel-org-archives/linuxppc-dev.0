Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90BEFB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 16:01:19 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Nov 2009 16:01:07 +1100
Message-ID: <1257915667.2140.16.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

This contains one code fix, 3 little device-tree fixes and a bunch of
defconfig updates for Freescale platforms for 2.6.32 along with one
defconfig update for PA-Semi.

Overall, a large diffstat but not much actual churn. If you are unhappy
with the defconfig updates at that stage of the process, let us know and
I'll ask my sub-maintainers to do them earlier.

Cheers,
Ben.

The following changes since commit 799dd75b1a8380a967c929a4551895788c374b31:
  Linus Torvalds (1):
        Merge branch 'i2c-for-linus' of git://git.kernel.org/.../jdelvare/staging

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Vorontsov (2):
      powerpc/85xx: Fix USB GPIOs for MPC8569E-MDS boards
      powerpc/83xx: Fix u-boot partion size for MPC8377E-WLAN boards

Benjamin Herrenschmidt (1):
      Merge commit 'kumar/merge' into merge

Kim Phillips (1):
      powerpc/8xxx: enable IPsec ESP by default on mpc83xx/mpc85xx

Kumar Gala (1):
      powerpc: 2.6.32 update of defconfigs for embedded 6xx/7xxx, 8xx, 8{3,5,6}xxx

Olof Johansson (1):
      powerpc: pasemi_defconfig update

Paul Gortmaker (1):
      powerpc/85xx: sbc8548 - fixup of PCI-e related DTS fields

Roel Kluin (1):
      powerpc/82xx: kmalloc failure ignored in ep8248e_mdio_probe()

 arch/powerpc/boot/dts/mpc8377_wlan.dts            |    2 +-
 arch/powerpc/boot/dts/mpc8569mds.dts              |    4 +-
 arch/powerpc/boot/dts/sbc8548.dts                 |   17 +-
 arch/powerpc/configs/83xx/asp8347_defconfig       |   60 ++-
 arch/powerpc/configs/83xx/kmeter1_defconfig       |   46 +-
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |   73 ++-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |   76 ++-
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |   62 ++-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |   66 ++-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |   60 ++-
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |   58 ++-
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |   58 ++-
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |   64 ++-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |   60 ++-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |   64 ++-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |   70 ++-
 arch/powerpc/configs/83xx/sbc834x_defconfig       |   61 ++-
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   61 ++-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   57 ++-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   63 ++-
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   58 ++-
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   53 ++-
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   57 ++-
 arch/powerpc/configs/85xx/socrates_defconfig      |   68 ++-
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |   77 ++-
 arch/powerpc/configs/85xx/tqm8540_defconfig       |   59 ++-
 arch/powerpc/configs/85xx/tqm8541_defconfig       |   64 ++-
 arch/powerpc/configs/85xx/tqm8548_defconfig       |   64 ++-
 arch/powerpc/configs/85xx/tqm8555_defconfig       |   64 ++-
 arch/powerpc/configs/85xx/tqm8560_defconfig       |   64 ++-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |   76 ++-
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |   74 ++-
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |   72 ++-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |   80 ++-
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |   64 ++-
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |   65 ++-
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |   66 ++-
 arch/powerpc/configs/adder875_defconfig           |   48 +-
 arch/powerpc/configs/c2k_defconfig                |   77 ++-
 arch/powerpc/configs/ep8248e_defconfig            |   49 +-
 arch/powerpc/configs/ep88xc_defconfig             |   47 +-
 arch/powerpc/configs/linkstation_defconfig        |   72 ++-
 arch/powerpc/configs/mgcoge_defconfig             |   51 ++-
 arch/powerpc/configs/mgsuvd_defconfig             |   45 +-
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   58 ++-
 arch/powerpc/configs/mpc8272_ads_defconfig        |   52 ++-
 arch/powerpc/configs/mpc83xx_defconfig            |   90 ++-
 arch/powerpc/configs/mpc85xx_defconfig            |   98 ++--
 arch/powerpc/configs/mpc85xx_smp_defconfig        |   99 ++--
 arch/powerpc/configs/mpc866_ads_defconfig         |   54 ++-
 arch/powerpc/configs/mpc86xx_defconfig            |   70 ++-
 arch/powerpc/configs/mpc885_ads_defconfig         |   47 +-
 arch/powerpc/configs/pasemi_defconfig             |  628 +++++++++++++++------
 arch/powerpc/configs/pq2fads_defconfig            |   55 ++-
 arch/powerpc/configs/prpmc2800_defconfig          |   67 ++-
 arch/powerpc/configs/storcenter_defconfig         |   54 ++-
 arch/powerpc/platforms/82xx/ep8248e.c             |   15 +-
 57 files changed, 2603 insertions(+), 1380 deletions(-)
