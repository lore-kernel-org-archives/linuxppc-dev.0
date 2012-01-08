Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
In-reply-to: <alpine.LFD.2.00.1201041605230.15492@right.am.freescale.net>
References: <alpine.LFD.2.00.1201041605230.15492@right.am.freescale.net>
Date: Mon, 09 Jan 2012 10:58:01 +1100
Message-ID: <13121.1326067081@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar,

Can you pick up this one too.  Current Linus tree breaks compiling
mpc85xx_defconfig

  powerpc: fix compile error with 85xx/p1022_ds.c
  http://patchwork.ozlabs.org/patch/130620/

Mikey

In message <alpine.LFD.2.00.1201041605230.15492@right.am.freescale.net> you wro
te:
> The following changes since commit e4f387d8db3ba3c2dae4d8bdfe7bb5f4fe1bcb0d:
> 
>   powerpc: Fix unpaired probe_hcall_entry and probe_hcall_exit (2012-01-03 12:09:27 +1100)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next
> 
> Andy Fleming (1):
>       powerpc: Add TBI PHY node to first MDIO bus
> 
> Julia Lawall (1):
>       arch/powerpc/sysdev/fsl_rmu.c: introduce missing kfree
> 
> Kumar Gala (3):
>       powerpc/fsl-pci: Allow 64-bit PCIe devices to DMA to any memory address
>       powerpc/fsl: Update defconfigs to enable some standard FSL HW features
>       powerpc/fsl: update compatiable on fsl 16550 uart nodes
> 
> Michael Neuling (1):
>       powerpc: fix compile error with 85xx/p1023_rds.c
> 
> Paul Gortmaker (1):
>       sbc834x: put full compat string in board match check
> 
> Prabhakar Kushwaha (1):
>       powerpc/fsl: Add support for Integrated Flash Controller
> 
> Timur Tabi (3):
>       powerpc/85xx: re-enable ePAPR byte channel driver in corenet32_smp_defc
onfig
>       powerpc/85xx: fix PCI and localbus properties in p1022ds.dts
>       powerpc/fsl: add MSI support for the Freescale hypervisor
> 
> Tony Breeds (1):
>       powerpc: fix compile error with 85xx/p1010rdb.c
> 
>  arch/powerpc/Kconfig                         |    4 +
>  arch/powerpc/boot/dts/asp834x-redboot.dts    |    4 +-
>  arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi   |    4 +-
>  arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi |    4 +-
>  arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi |    4 +-
>  arch/powerpc/boot/dts/gef_ppc9a.dts          |    4 +-
>  arch/powerpc/boot/dts/gef_sbc310.dts         |    4 +-
>  arch/powerpc/boot/dts/gef_sbc610.dts         |    4 +-
>  arch/powerpc/boot/dts/kmeter1.dts            |    2 +-
>  arch/powerpc/boot/dts/kuroboxHD.dts          |    4 +-
>  arch/powerpc/boot/dts/kuroboxHG.dts          |    4 +-
>  arch/powerpc/boot/dts/mpc8308_p1m.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8308rdb.dts         |    4 +-
>  arch/powerpc/boot/dts/mpc8313erdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8315erdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc832x_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc832x_rdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8349emitx.dts       |    4 +-
>  arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4 +-
>  arch/powerpc/boot/dts/mpc834x_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc836x_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc836x_rdk.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8377_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8377_rdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8377_wlan.dts       |    4 +-
>  arch/powerpc/boot/dts/mpc8378_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8378_rdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8379_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8379_rdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc8540ads.dts         |    4 +-
>  arch/powerpc/boot/dts/mpc8541cds.dts         |    4 +-
>  arch/powerpc/boot/dts/mpc8555cds.dts         |    4 +-
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts       |    4 +-
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    4 +-
>  arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts   |    4 +-
>  arch/powerpc/boot/dts/p1010rdb.dtsi          |    5 +
>  arch/powerpc/boot/dts/p1020rdb.dtsi          |    5 +
>  arch/powerpc/boot/dts/p1021mds.dts           |    4 +
>  arch/powerpc/boot/dts/p1022ds.dts            |   12 +-
>  arch/powerpc/boot/dts/p2020rdb.dts           |    8 +-
>  arch/powerpc/boot/dts/sbc8349.dts            |    4 +-
>  arch/powerpc/boot/dts/sbc8548.dts            |    4 +-
>  arch/powerpc/boot/dts/sbc8641d.dts           |    4 +-
>  arch/powerpc/boot/dts/socrates.dts           |    4 +-
>  arch/powerpc/boot/dts/storcenter.dts         |    4 +-
>  arch/powerpc/boot/dts/stxssa8555.dts         |    4 +-
>  arch/powerpc/boot/dts/tqm8540.dts            |    4 +-
>  arch/powerpc/boot/dts/tqm8541.dts            |    4 +-
>  arch/powerpc/boot/dts/tqm8548-bigflash.dts   |    4 +-
>  arch/powerpc/boot/dts/tqm8548.dts            |    4 +-
>  arch/powerpc/boot/dts/tqm8555.dts            |    4 +-
>  arch/powerpc/boot/dts/xcalibur1501.dts       |    4 +-
>  arch/powerpc/boot/dts/xpedite5200.dts        |    4 +-
>  arch/powerpc/boot/dts/xpedite5200_xmon.dts   |    4 +-
>  arch/powerpc/boot/dts/xpedite5301.dts        |    4 +-
>  arch/powerpc/boot/dts/xpedite5330.dts        |    4 +-
>  arch/powerpc/boot/dts/xpedite5370.dts        |    4 +-
>  arch/powerpc/configs/corenet32_smp_defconfig |   10 +-
>  arch/powerpc/configs/corenet64_smp_defconfig |    3 +-
>  arch/powerpc/configs/mpc85xx_defconfig       |   16 +-
>  arch/powerpc/configs/mpc85xx_smp_defconfig   |   17 +-
>  arch/powerpc/include/asm/fsl_ifc.h           |  834 ++++++++++++++++++++++++
++
>  arch/powerpc/platforms/83xx/sbc834x.c        |    4 +-
>  arch/powerpc/platforms/85xx/p1010rdb.c       |    2 -
>  arch/powerpc/platforms/85xx/p1023_rds.c      |    1 -
>  arch/powerpc/sysdev/Makefile                 |    1 +
>  arch/powerpc/sysdev/fsl_ifc.c                |  310 ++++++++++
>  arch/powerpc/sysdev/fsl_msi.c                |   68 ++-
>  arch/powerpc/sysdev/fsl_msi.h                |    7 +-
>  arch/powerpc/sysdev/fsl_pci.c                |   84 +++
>  arch/powerpc/sysdev/fsl_rmu.c                |    1 +
>  71 files changed, 1448 insertions(+), 150 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/fsl_ifc.h
>  create mode 100644 arch/powerpc/sysdev/fsl_ifc.c
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
