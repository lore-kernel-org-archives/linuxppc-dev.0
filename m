Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46283B6EF2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 03:34:36 +1100 (EST)
Date: Wed, 6 Jan 2010 10:34:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] defconfig updates
Message-ID: <Pine.LNX.4.64.1001061034030.12194@localhost.localdomain>
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

The following changes since commit 74d2e4f8d79ae0c4b6ec027958d5b18058662eea:
  Linus Torvalds (1):
        Linux 2.6.33-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (1):
      powerpc: 2.6.33 update of defconfigs for embedded 6xx/7xxx, 8xx, 8xxx

 arch/powerpc/configs/83xx/asp8347_defconfig       |   88 +++++++++++++-----
 arch/powerpc/configs/83xx/kmeter1_defconfig       |   68 +++++++++++---
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |   97 +++++++++++++++-----
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  100 +++++++++++++++-----
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |   89 +++++++++++++-----
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |   93 ++++++++++++++-----
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |   95 ++++++++++++++-----
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |   92 ++++++++++++++-----
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |   86 +++++++++++++-----
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |   89 +++++++++++++-----
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |   87 +++++++++++++-----
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |   89 +++++++++++++-----
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |   91 ++++++++++++++-----
 arch/powerpc/configs/83xx/sbc834x_defconfig       |   85 +++++++++++++-----
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   69 +++++++++++---
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   69 +++++++++++---
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   76 ++++++++++++----
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   75 ++++++++++++----
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   77 ++++++++++++----
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   72 +++++++++++---
 arch/powerpc/configs/85xx/socrates_defconfig      |   99 +++++++++++++++-----
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |   87 +++++++++++++-----
 arch/powerpc/configs/85xx/tqm8540_defconfig       |   89 +++++++++++++-----
 arch/powerpc/configs/85xx/tqm8541_defconfig       |   90 +++++++++++++-----
 arch/powerpc/configs/85xx/tqm8548_defconfig       |   95 +++++++++++++++----
 arch/powerpc/configs/85xx/tqm8555_defconfig       |   90 +++++++++++++-----
 arch/powerpc/configs/85xx/tqm8560_defconfig       |   90 +++++++++++++-----
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  103 ++++++++++++++++----
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  102 ++++++++++++++++----
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |   99 ++++++++++++++++----
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |   92 ++++++++++++++----
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |   88 ++++++++++++++----
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |   90 ++++++++++++++----
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |   81 ++++++++++++----
 arch/powerpc/configs/adder875_defconfig           |   57 +++++++++---
 arch/powerpc/configs/c2k_defconfig                |   90 +++++++++++++-----
 arch/powerpc/configs/ep8248e_defconfig            |   64 ++++++++++---
 arch/powerpc/configs/ep88xc_defconfig             |   55 +++++++++---
 arch/powerpc/configs/linkstation_defconfig        |   96 +++++++++++++++-----
 arch/powerpc/configs/mgcoge_defconfig             |   74 +++++++++++----
 arch/powerpc/configs/mgsuvd_defconfig             |   63 ++++++++++---
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   79 ++++++++++++----
 arch/powerpc/configs/mpc8272_ads_defconfig        |   70 +++++++++++---
 arch/powerpc/configs/mpc83xx_defconfig            |   92 ++++++++++++++-----
 arch/powerpc/configs/mpc85xx_defconfig            |   97 +++++++++++++++-----
 arch/powerpc/configs/mpc85xx_smp_defconfig        |   97 +++++++++++++++-----
 arch/powerpc/configs/mpc866_ads_defconfig         |   65 ++++++++++---
 arch/powerpc/configs/mpc86xx_defconfig            |   93 ++++++++++++++----
 arch/powerpc/configs/mpc885_ads_defconfig         |   55 +++++++++---
 arch/powerpc/configs/pq2fads_defconfig            |   72 +++++++++++---
 arch/powerpc/configs/prpmc2800_defconfig          |   94 ++++++++++++++-----
 arch/powerpc/configs/storcenter_defconfig         |   86 +++++++++++++----
 52 files changed, 3351 insertions(+), 1030 deletions(-)
