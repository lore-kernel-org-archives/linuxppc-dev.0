Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AEB852C0084
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2012 04:21:17 +1000 (EST)
Date: Thu, 13 Sep 2012 13:21:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1209131320360.8720@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit 6b5e7229bbd59f0cfce7015fd46736fc93d8c8c3:

  powerpc/mm: Match variable types to API (2012-09-10 14:37:31 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

for you to fetch changes up to 905e75c46dba5f3061049277e4eb7110beedba43:

  powerpc/fsl-pci: Unify pci/pcie initialization code (2012-09-12 14:57:12 -0500)

----------------------------------------------------------------
Jia Hongtao (3):
      powerpc/swiotlb: Enable at early stage and disable if not necessary
      powerpc: add adt7461 thermal monitor support to applicable boards
      powerpc/fsl-pci: Unify pci/pcie initialization code

Kim Phillips (1):
      powerpc/85xx: add Freescale P5040 SOC and SEC v5.2 device trees

Olivia Yin (3):
      powerpc/e500v2: Add Power ISA properties to comply with ePAPR 1.1
      powerpc/e500mc: Add Power ISA properties to comply with ePAPR 1.1
      powerpc/e5500: Add Power ISA properties to comply with ePAPR 1.1

Prabhakar Kushwaha (2):
      powerpc: Update Integrated Flash controller device tree bindings
      powerpc/mpc85xx: Add new ext fields to Integrated FLash Controller

Roy Zang (2):
      powerpc/pci: Add IP revision register define for Freescale PCIe controller
      powerpc/pci: Use PCIe IP block revision register instead of compatible

Shaohui Xie (1):
      powerpc/p5040: fix dtb build warning of p5040ds.dtb

Tang Yuantian (1):
      powerpc/85xx: L2sram - Add compatible string to the device id list

Timur Tabi (4):
      powerpc/85xx: remove P1020RDB and P2020RDB CAMP device trees
      powerpc/fsl-pci: add fsl,qoriq-pcie-v2.4 compatible string
      powerpc/85xx: Add support for P5040DS board
      powerpc/85xx: introduce support for the Freescale / iVeia P1022RDK

Varun Sethi (6):
      powerpc/mpic: finish supporting timer group B on Freescale chips
      powepc/booke: Separate out E.HV check and ivor setup code.
      powerpc/booke: Merge the 32 bit e5500/e500mc cpu setup code.
      powerpc/booke: Separate out restore_e5500/setup_e5500 routines.
      powerpc/booke: Add CPU_FTR_EMB_HV check for e5500.
      powerpc/mpic: FSL MPIC error interrupt support.

Wang Dongsheng (1):
      powerpc/8544ds: add partition table for norflash

Zhao Chenhui (4):
      powerpc/85xx: Replace epapr spin table macros/defines with a struct
      powerpc/smp: add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE
      powerpc/85xx: implement hardware timebase sync
      powerpc/85xx: add HOTPLUG_CPU support

 .../devicetree/bindings/powerpc/fsl/ifc.txt        |    9 +-
 arch/powerpc/Kconfig                               |    6 +-
 arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi    |   58 ++++
 arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi    |   52 ++++
 arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi     |   59 ++++
 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi       |    3 +
 arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi       |    3 +
 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi       |    3 +
 arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi       |    3 +
 arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi       |    3 +
 arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi       |    3 +
 arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |    3 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  320 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |  114 +++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi      |  118 ++++++++
 arch/powerpc/boot/dts/mpc8536ds.dtsi               |    4 +
 arch/powerpc/boot/dts/mpc8540ads.dts               |    2 +
 arch/powerpc/boot/dts/mpc8541cds.dts               |    2 +
 arch/powerpc/boot/dts/mpc8544ds.dts                |    4 +-
 arch/powerpc/boot/dts/mpc8544ds.dtsi               |   39 +++
 arch/powerpc/boot/dts/mpc8555cds.dts               |    2 +
 arch/powerpc/boot/dts/mpc8560ads.dts               |    2 +
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts      |   63 ----
 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts      |  141 ---------
 arch/powerpc/boot/dts/p1022ds.dtsi                 |    4 +
 arch/powerpc/boot/dts/p1022rdk.dts                 |  188 ++++++++++++
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts      |   67 ----
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts      |  125 --------
 arch/powerpc/boot/dts/p2041rdb.dts                 |    4 +
 arch/powerpc/boot/dts/p3041ds.dts                  |    4 +
 arch/powerpc/boot/dts/p4080ds.dts                  |    4 +
 arch/powerpc/boot/dts/p5020ds.dts                  |    4 +
 arch/powerpc/boot/dts/p5040ds.dts                  |  207 +++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig       |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig       |    1 +
 arch/powerpc/configs/mpc85xx_defconfig             |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    1 +
 arch/powerpc/include/asm/cacheflush.h              |    2 +
 arch/powerpc/include/asm/fsl_guts.h                |    2 +
 arch/powerpc/include/asm/fsl_ifc.h                 |   14 +-
 arch/powerpc/include/asm/mpic.h                    |   19 ++
 arch/powerpc/include/asm/smp.h                     |    2 +
 arch/powerpc/include/asm/swiotlb.h                 |    6 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   74 ++++-
 arch/powerpc/kernel/cputable.c                     |    4 +
 arch/powerpc/kernel/dma-swiotlb.c                  |   20 ++
 arch/powerpc/kernel/exceptions-64e.S               |   18 +-
 arch/powerpc/kernel/head_fsl_booke.S               |   46 ++-
 arch/powerpc/kernel/smp.c                          |   12 +-
 arch/powerpc/mm/mem.c                              |    3 +-
 arch/powerpc/platforms/44x/currituck.c             |   10 +-
 arch/powerpc/platforms/85xx/Kconfig                |   21 ++
 arch/powerpc/platforms/85xx/Makefile               |    2 +
 arch/powerpc/platforms/85xx/common.c               |   10 +
 arch/powerpc/platforms/85xx/corenet_ds.c           |   38 +--
 arch/powerpc/platforms/85xx/ge_imp3a.c             |   62 ++--
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |   36 +--
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   11 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   44 ++-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   15 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   40 +--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   30 +-
 arch/powerpc/platforms/85xx/p1010rdb.c             |   14 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   36 +--
 arch/powerpc/platforms/85xx/p1022_rdk.c            |  167 ++++++++++
 arch/powerpc/platforms/85xx/p1023_rds.c            |    9 +-
 arch/powerpc/platforms/85xx/p2041_rdb.c            |    2 +-
 arch/powerpc/platforms/85xx/p3041_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p4080_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p5020_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p5040_ds.c             |   89 ++++++
 arch/powerpc/platforms/85xx/qemu_e500.c            |    5 +-
 arch/powerpc/platforms/85xx/sbc8548.c              |   21 +-
 arch/powerpc/platforms/85xx/smp.c                  |  220 +++++++++++---
 arch/powerpc/platforms/85xx/socrates.c             |   11 +-
 arch/powerpc/platforms/85xx/stx_gp3.c              |   13 +-
 arch/powerpc/platforms/85xx/tqm85xx.c              |   21 +-
 arch/powerpc/platforms/85xx/xes_mpc85xx.c          |   56 +---
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |   12 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c           |   13 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c           |   12 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   21 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   42 +--
 arch/powerpc/platforms/86xx/sbc8641d.c             |   14 +-
 arch/powerpc/sysdev/Makefile                       |    2 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |   10 +
 arch/powerpc/sysdev/fsl_mpic_err.c                 |  149 +++++++++
 arch/powerpc/sysdev/fsl_pci.c                      |  118 +++++---
 arch/powerpc/sysdev/fsl_pci.h                      |   20 +-
 arch/powerpc/sysdev/mpic.c                         |  102 +++++--
 arch/powerpc/sysdev/mpic.h                         |   22 ++
 drivers/edac/mpc85xx_edac.c                        |   43 +--
 101 files changed, 2421 insertions(+), 1024 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
 delete mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
 create mode 100644 arch/powerpc/boot/dts/p1022rdk.dts
 delete mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
 delete mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
 create mode 100644 arch/powerpc/boot/dts/p5040ds.dts
 create mode 100644 arch/powerpc/platforms/85xx/p1022_rdk.c
 create mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
 create mode 100644 arch/powerpc/sysdev/fsl_mpic_err.c
