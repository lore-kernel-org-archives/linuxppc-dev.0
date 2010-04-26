Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9D25B7D57
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 09:05:21 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.1004192326100.27041@localhost.localdomain>
Date: Mon, 26 Apr 2010 18:05:19 -0500
Message-Id: <2009D70F-BBE3-4D4D-B1BA-C92041AFE9C9@kernel.crashing.org>
References: <Pine.LNX.4.64.1004192326100.27041@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

I've updated this to include this one additional patch for dealing with =
CONFIG_RELOCATE on FSL-BookE ppc32

http://patchwork.ozlabs.org/patch/51011/

- k

On Apr 19, 2010, at 11:26 PM, Kumar Gala wrote:

> (Mostly defconfig updates, but a few minor bug fixes).
>=20
> The following changes since commit =
01bf0b64579ead8a82e7cfc32ae44bc667e7ad0f:
>  Linus Torvalds (1):
>        Linux 2.6.34-rc5
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
>=20
> Anton Vorontsov (1):
>      powerpc/85xx/86xx: Fix build w/ CONFIG_PCI=3Dn
>=20
> Becky Bruce (1):
>      powerpc/fsl_booke: Correct test for MMU_FTR_BIG_PHYS
>=20
> Kim Phillips (4):
>      powerpc/83xx: add RTC drivers in 83xx defconfig
>      powerpc/83xx: enable EPOLL syscall in defconfig
>      powerpc/83xx: configure SIL SATA driver in 83xx-wide defconfig
>      powerpc/mpc8xxx defconfigs - turn off SYSFS_DEPRECATED
>=20
> Kumar Gala (1):
>      powerpc: 2.6.34 update of defconfigs for embedded 6xx/7xxx, 8xx, =
8xxx
>=20
> Wolfgang Ocker (1):
>      powerpc/fsl-cpm: Configure clock correctly for SCC
>=20
> arch/powerpc/configs/83xx/asp8347_defconfig       |   44 ++++----
> arch/powerpc/configs/83xx/kmeter1_defconfig       |   28 +++--
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |   49 +++++----
> arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |   50 +++++----
> arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |   45 ++++----
> arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |   49 ++++----
> arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |   44 ++++----
> arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |   43 ++++----
> arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |   46 +++++----
> arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |   45 ++++----
> arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |   44 ++++---
> arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |   46 +++++----
> arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |   51 +++++----
> arch/powerpc/configs/83xx/sbc834x_defconfig       |   44 ++++----
> arch/powerpc/configs/85xx/ksi8560_defconfig       |   23 +++-
> arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   25 +++--
> arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   34 ++++--
> arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   31 ++++--
> arch/powerpc/configs/85xx/sbc8548_defconfig       |   31 ++++--
> arch/powerpc/configs/85xx/sbc8560_defconfig       |   25 +++--
> arch/powerpc/configs/85xx/socrates_defconfig      |   51 +++++----
> arch/powerpc/configs/85xx/stx_gp3_defconfig       |   51 +++++----
> arch/powerpc/configs/85xx/tqm8540_defconfig       |   48 +++++---
> arch/powerpc/configs/85xx/tqm8541_defconfig       |   54 ++++++---
> arch/powerpc/configs/85xx/tqm8548_defconfig       |   47 +++++---
> arch/powerpc/configs/85xx/tqm8555_defconfig       |   54 ++++++---
> arch/powerpc/configs/85xx/tqm8560_defconfig       |   54 ++++++---
> arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |   59 +++++++---
> arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  102 =
+++++++++++-------
> arch/powerpc/configs/86xx/gef_sbc310_defconfig    |   53 ++++++----
> arch/powerpc/configs/86xx/gef_sbc610_defconfig    |   96 =
+++++++++++------
> arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |   34 +++---
> arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |   48 +++++---
> arch/powerpc/configs/86xx/sbc8641d_defconfig      |   40 ++++---
> arch/powerpc/configs/adder875_defconfig           |   18 ++--
> arch/powerpc/configs/c2k_defconfig                |   55 ++++-----
> arch/powerpc/configs/ep8248e_defconfig            |   20 +++-
> arch/powerpc/configs/ep88xc_defconfig             |   17 ++--
> arch/powerpc/configs/linkstation_defconfig        |   48 +++++---
> arch/powerpc/configs/mgcoge_defconfig             |   31 ++++--
> arch/powerpc/configs/mgsuvd_defconfig             |   19 ++--
> arch/powerpc/configs/mpc7448_hpc2_defconfig       |   26 +++--
> arch/powerpc/configs/mpc8272_ads_defconfig        |   23 +++-
> arch/powerpc/configs/mpc83xx_defconfig            |  124 =
++++++++++++++++-----
> arch/powerpc/configs/mpc85xx_defconfig            |   62 +++++++----
> arch/powerpc/configs/mpc85xx_smp_defconfig        |   64 +++++++----
> arch/powerpc/configs/mpc866_ads_defconfig         |   20 ++--
> arch/powerpc/configs/mpc86xx_defconfig            |   57 ++++++----
> arch/powerpc/configs/mpc885_ads_defconfig         |   20 ++--
> arch/powerpc/configs/pq2fads_defconfig            |   22 +++-
> arch/powerpc/configs/prpmc2800_defconfig          |   52 ++++++---
> arch/powerpc/configs/storcenter_defconfig         |   33 +++---
> arch/powerpc/mm/fsl_booke_mmu.c                   |    4 +-
> arch/powerpc/platforms/85xx/Kconfig               |    4 +-
> arch/powerpc/platforms/86xx/Kconfig               |    4 +-
> arch/powerpc/sysdev/cpm1.c                        |   14 ++-
> arch/powerpc/sysdev/cpm2.c                        |   11 ++-
> 57 files changed, 1432 insertions(+), 904 deletions(-)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
