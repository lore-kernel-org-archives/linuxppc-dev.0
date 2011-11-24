Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D11A81007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 19:40:10 +1100 (EST)
Date: Thu, 24 Nov 2011 02:39:56 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1111240237570.16681@right.am.freescale.net>
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

Ben,

'next' branch pull request that includes 'merge' as well.

- k

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Alexandre Rusev (1):
      powerpc/fsl-lbc: Fix for fsl_upm

Chuck Meade (1):
      drivers/serial/ucc_uart.c: Add missing call to init UCC UART port timeout

Dmitry Eremin-Solenikov (6):
      powerpc/83xx: consolidate init_IRQ functions
      powerpc/83xx: consolidate of_platform_bus_probe calls
      powerpc/83xx: merge PCI bridge additions
      powerpc/83xx: make mpc830x_rdb use mpc83xx_setup_pci
      powerpc/85xx: separate cpm2 pic init
      powerpc/85xx: consolidate of_platform_bus_probe calls

Jason Jin (1):
      powerpc/fsl-pci: Don't hide resource for pci/e when configured as Agent/EP

Jia Hongtao (1):
      powerpc/85xx: Add lbc suspend support for PM

Joakim Tjernlund (1):
      powerpc/qe: Fixup QE_General4 errata

Julia Lawall (1):
      arch/powerpc/sysdev/ehv_pic.c: add missing kfree

Kai Jiang (1):
      powerpc/8xxx: Update device tree bus probe for new RapidIO node binding

Kumar Gala (33):
      powerpc/85xx: Fix compile error on p3060_qds.c
      powerpc/85xx: Simplify P1020RDB CAMP dts using includes
      powerpc/85xx: Rework PCI nodes on P1020RDB
      powerpc/85xx: Update SPI binding to match binding spec for P1020RDB
      powerpc/85xx: Update P1020 SEC3.3 node to match actual SoC HW
      powerpc/85xx: Add ethernet magic packet property to P1020 device tree
      powerpc/85xx: p1020si.dtsi update interrupt handling
      powerpc/85xx: create dts components to build up an SoC
      powerpc/85xx: Rework MPC8536DS device trees
      powerpc/85xx: Rework MPC8544DS device tree
      powerpc/85xx: Rework MPC8548CDS device trees
      powerpc/85xx: Rework MPC8568MDS device tree
      powerpc/85xx: Rework MPC8569MDS device tree
      powerpc/85xx: Rework MPC8572DS device tree
      powerpc/85xx: Rework P1010RDB and P1010 device tree
      powerpc/85xx: Add RTC to P1010RDB device tree
      powerpc/85xx: Add crypto engine to P1010 SoC device tree
      powerpc/85xx: Add a P1010RDB 36-bit address map device tree
      powerpc/85xx: Rework P1020RDB device tree
      powerpc/85xx: Add P1020RDB 36-bit address map device tree
      powerpc/85xx: Rework P1021MDS device tree
      powerpc/85xx: Rework P1022DS device tree
      powerpc/85xx: Rework P1023RDS device tree
      powerpc/85xx: Rework P2020DS device tree
      powerpc/85xx: Rework P2020RDB device tree
      powerpc/85xx: Rework P2041RDB device tree
      powerpc/85xx: Rework P3041DS device tree
      powerpc/85xx: Rework P3060QDS device tree
      powerpc/85xx: Rework P4080DS device trees
      powerpc/85xx: Rework P5020DS device tree
      powerpc/85xx: Update SRIO device tree nodes
      powerpc/85xx: Additional consolidate of_platform_bus_probe calls
      powerpc/85xx: Renamed mpc85xx_common.c to common.c

Liu Gang (3):
      powerpc/fsl: Document rapidio node binding-information
      fsl-rio: Split rio driver into two parts, RapidIO endpoint and message unit
      fsl-rio: Add two ports and rapidio message units support

Paul Bolle (1):
      powerpc/p3060qds: Fix select of 'MPC8xxx_GPIO'

Roy Zang (1):
      powerpc/p1023: set IRQ[4:6,11] to active-high level sensitive for PCIe

Shaohui Xie (1):
      drivers/edac/mpc85xx_edac.c: fix memory controller compatible for edac

Timur Tabi (2):
      powerpc/85xx: add pixis indirect mode device tree node
      powerpc/fsl_msi: add support for the fsl, msi property in PCI nodes

 .../devicetree/bindings/powerpc/fsl/srio-rmu.txt   |  163 +++
 .../devicetree/bindings/powerpc/fsl/srio.txt       |  103 ++
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi      |  248 ++++
 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi       |   63 +
 arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi      |  191 +++
 arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi       |   63 +
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi      |  143 ++
 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi       |   62 +
 arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi      |  270 ++++
 arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi       |   65 +
 arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi      |  304 ++++
 arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi       |   64 +
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi      |  196 +++
 arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi       |   70 +
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi        |  198 +++
 arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi         |   64 +
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi        |  174 +++
 arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi         |   68 +
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi        |  225 +++
 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi         |   68 +
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi        |  235 +++
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi         |   68 +
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |  224 +++
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi         |   76 +
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi        |  194 +++
 arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi         |   69 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  325 +++++
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |  111 ++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  352 +++++
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |  112 ++
 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi        |  296 ++++
 arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi         |  125 ++
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  350 +++++
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |  143 ++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  355 +++++
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   96 ++
 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi           |   66 +
 arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi           |   66 +
 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi         |   51 +
 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi         |   41 +
 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi          |   41 +
 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi        |   53 +
 arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi        |   53 +
 arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi        |   53 +
 arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi        |   53 +
 arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi  |   39 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi        |   60 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi        |   60 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi        |   59 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi   |   42 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi   |   42 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi   |   42 +
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi          |   41 +
 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi           |   43 +
 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi           |   43 +
 arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi    |   42 +
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi            |   66 +
 arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi           |   68 +
 arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi         |   40 +
 arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi         |   40 +
 arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi        |   43 +
 arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi        |   45 +
 arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi        |   45 +
 arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi        |   45 +
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi        |   65 +
 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi       |   41 +
 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi       |   41 +
 arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi         |   66 +
 arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi         |   66 +
 arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi       |   51 +
 arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi       |   51 +
 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi       |   40 +
 arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi        |   41 +
 arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi        |   41 +
 arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi         |   53 +
 arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi         |   53 +
 arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi          |  106 ++
 arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi         |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi       |   39 +
 arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi       |   39 +
 arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi      |  100 ++
 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi      |  109 ++
 arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi      |  109 ++
 arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi     |   41 +
 arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi    |   41 +
 arch/powerpc/boot/dts/mpc8536ds.dts                |  456 +------
 arch/powerpc/boot/dts/mpc8536ds.dtsi               |  141 ++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts            |  410 +-----
 arch/powerpc/boot/dts/mpc8544ds.dts                |  473 +------
 arch/powerpc/boot/dts/mpc8544ds.dtsi               |  161 +++
 arch/powerpc/boot/dts/mpc8548cds.dts               |  505 ++-----
 arch/powerpc/boot/dts/mpc8568mds.dts               |  482 +------
 arch/powerpc/boot/dts/mpc8569mds.dts               |  414 +-----
 arch/powerpc/boot/dts/mpc8572ds.dts                |  757 +----------
 arch/powerpc/boot/dts/mpc8572ds.dtsi               |  397 +++++
 arch/powerpc/boot/dts/mpc8572ds_36b.dts            |  746 +----------
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts     |  487 +------
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts     |  245 +---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts             |   69 +-
 arch/powerpc/boot/dts/p1010rdb.dts                 |  228 +---
 arch/powerpc/boot/dts/p1010rdb.dtsi                |  229 +++
 arch/powerpc/boot/dts/p1010rdb_36b.dts             |   89 ++
 arch/powerpc/boot/dts/p1010si.dtsi                 |  374 -----
 arch/powerpc/boot/dts/p1020rdb.dts                 |  262 +----
 arch/powerpc/boot/dts/p1020rdb.dtsi                |  242 ++++
 arch/powerpc/boot/dts/p1020rdb_36b.dts             |   66 +
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts      |  154 +--
 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts      |   11 +-
 arch/powerpc/boot/dts/p1020si.dtsi                 |  377 -----
 arch/powerpc/boot/dts/p1021mds.dts                 |  421 +-----
 arch/powerpc/boot/dts/p1022ds.dts                  |  449 +------
 arch/powerpc/boot/dts/p1023rds.dts                 |  383 +-----
 arch/powerpc/boot/dts/p2020ds.dts                  |  353 +-----
 arch/powerpc/boot/dts/p2020ds.dtsi                 |  316 ++++
 arch/powerpc/boot/dts/p2020rdb.dts                 |   63 +-
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts      |  141 +--
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts      |  107 +--
 arch/powerpc/boot/dts/p2020si.dtsi                 |  382 -----
 arch/powerpc/boot/dts/p2041rdb.dts                 |   22 +-
 arch/powerpc/boot/dts/p2041si.dtsi                 |  692 ---------
 arch/powerpc/boot/dts/p3041ds.dts                  |   23 +-
 arch/powerpc/boot/dts/p3041si.dtsi                 |  729 ----------
 arch/powerpc/boot/dts/p3060qds.dts                 |   12 +-
 arch/powerpc/boot/dts/p3060si.dtsi                 |  719 ---------
 arch/powerpc/boot/dts/p4080ds.dts                  |   24 +-
 arch/powerpc/boot/dts/p4080si.dtsi                 |  755 ----------
 arch/powerpc/boot/dts/p5020ds.dts                  |   24 +-
 arch/powerpc/boot/dts/p5020si.dtsi                 |  716 ---------
 arch/powerpc/include/asm/fsl_lbc.h                 |    7 +-
 arch/powerpc/kernel/pci-common.c                   |    3 +
 arch/powerpc/platforms/83xx/asp834x.c              |   35 +-
 arch/powerpc/platforms/83xx/km83xx.c               |   58 +-
 arch/powerpc/platforms/83xx/misc.c                 |   77 +
 arch/powerpc/platforms/83xx/mpc830x_rdb.c          |   40 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c          |   43 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   53 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   56 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |   30 +-
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |   42 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   53 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   48 +-
 arch/powerpc/platforms/83xx/mpc837x_mds.c          |   46 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c          |   47 +-
 arch/powerpc/platforms/83xx/mpc83xx.h              |   16 +
 arch/powerpc/platforms/83xx/sbc834x.c              |   45 +-
 arch/powerpc/platforms/85xx/Kconfig                |    2 +-
 arch/powerpc/platforms/85xx/Makefile               |    2 +
 arch/powerpc/platforms/85xx/common.c               |   66 +
 arch/powerpc/platforms/85xx/corenet_ds.c           |    2 +-
 arch/powerpc/platforms/85xx/ksi8560.c              |   46 +-
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |   16 +-
 arch/powerpc/platforms/85xx/mpc85xx.h              |   11 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   52 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   16 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   20 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   47 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   18 +-
 arch/powerpc/platforms/85xx/p1010rdb.c             |   15 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    7 +-
 arch/powerpc/platforms/85xx/p1023_rds.c            |   19 +-
 arch/powerpc/platforms/85xx/p3060_qds.c            |    2 +-
 arch/powerpc/platforms/85xx/sbc8548.c              |   18 +-
 arch/powerpc/platforms/85xx/sbc8560.c              |   52 +-
 arch/powerpc/platforms/85xx/socrates.c             |   13 +-
 arch/powerpc/platforms/85xx/stx_gp3.c              |   51 +-
 arch/powerpc/platforms/85xx/tqm85xx.c              |   51 +-
 arch/powerpc/platforms/85xx/xes_mpc85xx.c          |   20 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |    2 +-
 arch/powerpc/sysdev/Makefile                       |    2 +-
 arch/powerpc/sysdev/ehv_pic.c                      |    1 +
 arch/powerpc/sysdev/fsl_lbc.c                      |   37 +
 arch/powerpc/sysdev/fsl_msi.c                      |   39 +
 arch/powerpc/sysdev/fsl_msi.h                      |    3 +
 arch/powerpc/sysdev/fsl_rio.c                      | 1519 ++++----------------
 arch/powerpc/sysdev/fsl_rio.h                      |  135 ++
 arch/powerpc/sysdev/fsl_rmu.c                      | 1103 ++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe.c                    |    2 +-
 drivers/edac/mpc85xx_edac.c                        |    2 +-
 drivers/tty/serial/ucc_uart.c                      |    3 +
 179 files changed, 12808 insertions(+), 13967 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/srio-rmu.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/srio.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8536ds.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8544ds.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8572ds.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb_36b.dts
 delete mode 100644 arch/powerpc/boot/dts/p1010si.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020rdb_36b.dts
 delete mode 100644 arch/powerpc/boot/dts/p1020si.dtsi
 create mode 100644 arch/powerpc/boot/dts/p2020ds.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p2020si.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p2041si.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p3041si.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p3060si.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p4080si.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p5020si.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/common.c
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 create mode 100644 arch/powerpc/sysdev/fsl_rio.h
 create mode 100644 arch/powerpc/sysdev/fsl_rmu.c
