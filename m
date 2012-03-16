Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC567B6EE7
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 08:30:38 +1100 (EST)
Date: Fri, 16 Mar 2012 16:30:15 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.02.1203161628390.27327@spiff>
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

The following changes since commit aba0eb84c87928992c021d33ef3ea59c931086b9:

  Merge branch 'eeh' into next (2012-03-13 10:15:35 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Claudiu Manoil (2):
      powerpc/85xx: Fix compiler error with THIS_MODULE and related
      powerpc/85xx: Add missing config option for CACHE SRAM code

Diana CRACIUN (1):
      powerpc/fsl: Added aliased MSIIR register address to MSI node in dts

Gustavo Zacarias (1):
      powerpc/85xx: fix typo in p1010rdb.dtsi

Jerry Huang (2):
      powerpc/85xx: add P1020MBG-PC platform support
      powerpc/85xx: add P1020UTM-PC platform support

Jia Hongtao (3):
      powerpc/85xx: Clean up partition nodes in dts for MPC8572DS
      powerpc: add support for MPIC message register API
      powerpc: document the FSL MPIC message register binding

Kumar Gala (2):
      powerpc/fsl-booke: Fixup calc_cam_sz to support MMU v2
      powerpc: Add initial e6500 cpu support

Liu Gang (2):
      powerpc/srio: Fix the relocation errors when building with 64bit
      powerpc/srio: Fix the compile errors when building with 64bit

Liu Shuo (2):
      powerpc/fsl_msi: return proper error value when ioremap failed.
      powerpc/dts: fix the compatible string of sec 4.0

Martyn Welch (4):
      powerpc: Add GE FPGA config option
      gpio: Move GE GPIO driver to reside within GPIO subsystem
      powerpc: Move GE PIC drivers
      powerpc/85xx: Board support for GE IMP3A

Paul Gortmaker (2):
      powerpc/85xx: fix Kconfig warning about missing 8250 dependency
      powerpc/83xx: mpc836x - fix failed phy detection for ucc ethernet on MDS

Prabhakar Kushwaha (1):
      NAND Machine support for Integrated Flash Controller

Ramneek Mehresh (1):
      powerpc/85xx: Add usb controller version info

Sebastian Andrzej Siewior (2):
      powerpc/85xx: p2020rdb - move the NAND address.
      powerpc/85xx: p2020rdb & p1010rdb - lower spi flash freq to 40Mhz

Tang Yuantian (2):
      powerpc/85xx: Adds Support for P2020RDB-PC board
      powerpc/85xx: Add p2020rdb-pc dts support

Timur Tabi (4):
      powerpc/85xx: create 32-bit DTS for the P1022DS
      powerpc/85xx: p1022ds: disable the NOR flash node if video is enabled
      powerpc/85xx: p1022ds: enable monitor switching via pixis indirect mode
      powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable

Xie Xiaobo (2):
      powerpc/85xx: Add some DTS nodes and attributes for mpc8536ds
      powerpc/85xx: Add magic-packet properties for etsec

Xu Jiucheng (2):
      powerpc/85xx: Added dts for P1021RDB-PC board
      powerpc/85xx: Added P1021RDB-PC Platform support

Zhao Chenhui (3):
      powerpc/85xx: mpc8548cds - fix alias in mpc8548si-pre.dtsi
      powerpc/85xx: Refactor mpc8548cds device tree
      powerpc/85xx: mpc8548cds - add 36-bit dts

Zhicheng Fan (6):
      powerpc/85xx: Add p1025rdb platform support
      powerpc/85xx: Add dts for p1025rdb board
      powerpc/85xx: Add p1020rdb-pc platform support
      powerpc/85xx: Add dts for p1020rdb-pc board
      powerpc/85xx: Abstract common define of signal multiplex control for qe
      powerpc/85xx: Add Quicc Engine support for p1025rdb

chenhui zhao (5):
      powerpc/85xx: l2sram - Add compatible entry for mpc8548 L2 controller
      powerpc/85xx: mpc85xxcds - Fix PCI I/O space resource of PCI bridge
      powerpc/85xx: mpc8548cds - Add NOR flash node to dts
      powerpc/85xx: mpc8548cds - Add RapidIO node to dts
      powerpc/85xx: mpc8548cds - Add FPGA node to dts

 .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   63 ++
 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |    6 +-
 arch/powerpc/boot/Makefile                         |    2 +-
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi      |    4 +-
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi      |   16 +
 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi       |    4 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi        |    3 +
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi        |    6 +
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi        |    7 +
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi        |   12 +-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |    3 +
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi        |    3 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |    2 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |    2 +
 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi        |    6 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |    2 +
 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi        |    3 +-
 arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi        |    3 +-
 arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi        |    3 +-
 arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi        |    3 +-
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi        |   10 +-
 arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi          |    6 +-
 arch/powerpc/boot/dts/ge_imp3a.dts                 |  255 +++++
 arch/powerpc/boot/dts/mpc836x_mds.dts              |    4 +
 arch/powerpc/boot/dts/mpc8536ds.dts                |    6 +-
 arch/powerpc/boot/dts/mpc8536ds.dtsi               |   93 ++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts            |    8 +-
 arch/powerpc/boot/dts/mpc8548cds.dts               |  306 ------
 arch/powerpc/boot/dts/mpc8548cds.dtsi              |  306 ++++++
 arch/powerpc/boot/dts/mpc8548cds_32b.dts           |   86 ++
 arch/powerpc/boot/dts/mpc8548cds_36b.dts           |   86 ++
 arch/powerpc/boot/dts/mpc8572ds.dtsi               |   50 +-
 arch/powerpc/boot/dts/p1010rdb.dtsi                |    4 +-
 arch/powerpc/boot/dts/p1020rdb-pc.dtsi             |  247 +++++
 arch/powerpc/boot/dts/p1020rdb-pc_32b.dts          |   90 ++
 arch/powerpc/boot/dts/p1020rdb-pc_36b.dts          |   90 ++
 arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts   |   64 ++
 arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts   |  142 +++
 arch/powerpc/boot/dts/p1021rdb.dts                 |   96 ++
 arch/powerpc/boot/dts/p1021rdb.dtsi                |  236 +++++
 arch/powerpc/boot/dts/p1021rdb_36b.dts             |   96 ++
 arch/powerpc/boot/dts/p1022ds.dts                  |  274 -----
 arch/powerpc/boot/dts/p1022ds.dtsi                 |  234 +++++
 arch/powerpc/boot/dts/p1022ds_32b.dts              |  103 ++
 arch/powerpc/boot/dts/p1022ds_36b.dts              |  103 ++
 arch/powerpc/boot/dts/p1025rdb.dtsi                |  286 ++++++
 arch/powerpc/boot/dts/p1025rdb_32b.dts             |  135 +++
 arch/powerpc/boot/dts/p1025rdb_36b.dts             |   88 ++
 arch/powerpc/boot/dts/p2020rdb-pc.dtsi             |  241 +++++
 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts          |   96 ++
 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts          |   96 ++
 arch/powerpc/boot/dts/p2020rdb.dts                 |    4 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |  257 +++++
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig      |    1 +
 arch/powerpc/configs/86xx/gef_sbc310_defconfig     |    1 +
 arch/powerpc/configs/86xx/gef_sbc610_defconfig     |    2 +
 arch/powerpc/configs/mpc85xx_defconfig             |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    1 +
 arch/powerpc/include/asm/cputable.h                |   12 +-
 arch/powerpc/include/asm/fsl_guts.h                |    6 +-
 arch/powerpc/include/asm/mpic_msgr.h               |  132 +++
 arch/powerpc/include/asm/reg_booke.h               |    1 +
 arch/powerpc/kernel/cputable.c                     |   18 +
 arch/powerpc/mm/fsl_booke_mmu.c                    |   19 +-
 arch/powerpc/platforms/85xx/Kconfig                |   27 +-
 arch/powerpc/platforms/85xx/Makefile               |    1 +
 arch/powerpc/platforms/85xx/ge_imp3a.c             |  246 +++++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   81 ++-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   35 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  215 ++++-
 arch/powerpc/platforms/85xx/p1022_ds.c             |  203 ++++-
 arch/powerpc/platforms/86xx/Kconfig                |    3 +
 arch/powerpc/platforms/86xx/Makefile               |    7 +-
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |    2 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c           |    2 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c           |    2 +-
 arch/powerpc/platforms/Kconfig                     |    8 +
 arch/powerpc/sysdev/Kconfig                        |    4 +
 arch/powerpc/sysdev/Makefile                       |    4 +
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c          |    1 +
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |    4 +
 arch/powerpc/sysdev/fsl_msi.c                      |    1 +
 arch/powerpc/sysdev/fsl_rio.c                      |    4 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   42 +-
 arch/powerpc/sysdev/ge/Makefile                    |    1 +
 .../86xx/gef_pic.c => sysdev/ge/ge_pic.c}          |    2 +-
 .../86xx/gef_pic.h => sysdev/ge/ge_pic.h}          |    0
 arch/powerpc/sysdev/mpic_msgr.c                    |  282 +++++
 drivers/gpio/Kconfig                               |   11 +
 drivers/gpio/Makefile                              |    1 +
 .../86xx/gef_gpio.c => drivers/gpio/gpio-ge.c      |   30 +-
 drivers/mtd/nand/Kconfig                           |   10 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/fsl_ifc_nand.c                    | 1072 ++++++++++++++++++++
 drivers/watchdog/Kconfig                           |    2 +-
 95 files changed, 6119 insertions(+), 730 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
 create mode 100644 arch/powerpc/boot/dts/ge_imp3a.dts
 delete mode 100644 arch/powerpc/boot/dts/mpc8548cds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds_32b.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts
 create mode 100644 arch/powerpc/boot/dts/p1021rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p1021rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1021rdb_36b.dts
 delete mode 100644 arch/powerpc/boot/dts/p1022ds.dts
 create mode 100644 arch/powerpc/boot/dts/p1022ds.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1022ds_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1022ds_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1025rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1025rdb_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1025rdb_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
 create mode 100644 arch/powerpc/configs/85xx/ge_imp3a_defconfig
 create mode 100644 arch/powerpc/include/asm/mpic_msgr.h
 create mode 100644 arch/powerpc/platforms/85xx/ge_imp3a.c
 create mode 100644 arch/powerpc/sysdev/ge/Makefile
 rename arch/powerpc/{platforms/86xx/gef_pic.c => sysdev/ge/ge_pic.c} (99%)
 rename arch/powerpc/{platforms/86xx/gef_pic.h => sysdev/ge/ge_pic.h} (100%)
 create mode 100644 arch/powerpc/sysdev/mpic_msgr.c
 rename arch/powerpc/platforms/86xx/gef_gpio.c => drivers/gpio/gpio-ge.c (83%)
 create mode 100644 drivers/mtd/nand/fsl_ifc_nand.c
