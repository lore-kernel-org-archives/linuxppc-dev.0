Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DAEC52C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 05:56:43 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Subject: [git pull] Please pull powerpc.git next branch
Date: Mon, 29 Apr 2013 14:56:05 -0500
Message-Id: <79688787-4841-4AB9-805A-59799A56C710@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Cc: linuxppc list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Add support for T4 and B4 SoC families from Freescale, e6500 altivec =
support, some various board fixes and other minor cleanups.

- k

The following changes since commit =
54c9b2253d34e8998e4bff9ac2d7a3ba0b861d52:

  powerpc: Set DSCR bit in FSCR setup (2013-03-05 16:56:30 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

for you to fetch changes up to 9e2ecdbba3b0745f9ed454ab86961e3ccf9dc224:

  powerpc/fsl-booke: add the reg prop for pci bridge device node for =
T4/B4 (2013-04-29 14:47:25 -0500)

----------------------------------------------------------------
Ben Collins (1):
      powerpc/85xx: sgy-cts1000 - Remove __dev* attributes

Chen-Hui Zhao (1):
      powerpc/85xx: fix a bug with the parameter of mpic_reset_core()

Jia Hongtao (1):
      powerpc/85xx: Add platform_device declaration to fsl_pci.h

Jiucheng Xu (1):
      powerpc/85xx: Reserve a partition of NOR flash for QE ucode =
firmware

Kevin Hao (2):
      powerpc/fsl-pci: don't unmap the PCI SoC controller registers in =
setup_pci_atmu
      powerpc/fsl-booke: add the reg prop for pci bridge device node for =
T4/B4

Kumar Gala (11):
      powerpc/fsl-booke: Support detection of page sizes on e6500
      powerpc/85xx: Add AltiVec support for e6500
      powerpc/fsl-booke: Add initial silicon device tree for T4240
      powerpc/fsl-booke: Add initial T4240QDS board device tree
      powerpc/fsl-booke: Add initial T4240QDS board support
      powerpc/85xx: Update corenet64_smp_defconfig for T4240
      powerpc/qe: Fix Kconfig enablement of QE_USB support
      powerpc/fsl-booke: Update T4240 device config node in device tree
      powerpc/fsl-booke: Minor fixes to T4240 Si device tree
      powerpc/fsl-pci: Keep PCI SoC controller registers in =
pci_controller
      powerpc/85xx: Fix MPC8536DS 36-bit device tree

Paul Bolle (2):
      powerpc: remove "config 8260_PCI9"
      powerpc: remove "config MPC10X_OPENPIC"

Prabhakar Kushwaha (1):
      powerpc: add CONFIG(s) require for using flash controller

Ramneek Mehresh (1):
      powerpc/85xx: Add first usb controller node for Qonverge platforms

Rojhalat Ibrahim (1):
      powerpc/fsl-pci Make PCIe hotplug work with Freescale PCIe =
controllers

Roy ZANG (2):
      powerpc/85xx: Add support for FSL PCIe controller v3.0
      powerpc/85xx: enable Silicon image 3132 PCIe to SATA controller

Roy Zang (2):
      powerpc/85xx: enable E1000 NIC to mpc85xx_defconfig
      powerpc/fsl_pci: fix 64 bit pci size issue

Scott Wood (1):
      powerpc/85xx: add CONFIG_E1000E to corenet64_smp_defconfig

Sebastian Andrzej Siewior (1):
      powerpc/fsl-msi: use a different lockclass for the cascade =
interrupt

Shaveta Leekha (5):
      powerpc/85xx: add SEC-5.3 device tree
      powerpc/fsl-booke: Add initial silicon device tree files for B4860 =
and B4420
      powerpc/fsl-booke: Add initial B4860QDS and B4420QDS board device =
tree
      powerpc/fsl-booke: Add B4_QDS board support
      powerpc/85xx: Update corenet64_smp_defconfig for B4_QDS

Stephen George (2):
      powerpc/fsl-booke: Added device tree DCSR entries for T4240 =
Chassis v2 Debug IP
      powerpc/fsl-booke: Update DCSR EPU device tree entries for =
existing SoCs

Stuart Yoder (3):
      powerpc/e6500: Add architecture categories for e6500 cores
      powerpc: add missing deo arch category to e500mc/e5500 dts
      powerpc: Add paravirt idle loop for 64-bit Book-E

Tang Yuantian (1):
      powerpc/fsl: remove the PPC_CLOCK dependency

Vakul Garg (3):
      powerpc/85xx: Added SEC-5.0 device tree.
      powerpc/fsl: removed qoriq-sec4.1-0.dtsi.
      powerpc/fsl: Add property for 'era' in SEC dts crypto node

Zhicheng Fan (1):
      powerpc/dts: Fix the dts for p1025rdb 36bit

 .../devicetree/bindings/powerpc/fsl/cpus.txt       |  22 +
 arch/powerpc/Kconfig                               |   6 -
 arch/powerpc/boot/dts/b4420qds.dts                 |  50 +++
 arch/powerpc/boot/dts/b4860qds.dts                 |  61 +++
 arch/powerpc/boot/dts/b4qds.dts                    | 169 ++++++++
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  98 +++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |  73 ++++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        | 142 +++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |  83 ++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           | 268 +++++++++++++
 arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi    |   1 +
 arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi     |   1 +
 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi     |  65 +++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi        |   1 +
 arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi  |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi        |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi        |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi        |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi      |   1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi      |   1 +
 .../{qoriq-sec4.1-0.dtsi =3D> qoriq-sec5.0-0.dtsi}   |  27 +-
 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi      |   1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi      | 119 ++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        | 442 =
+++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         | 128 ++++++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts            |   6 +-
 arch/powerpc/boot/dts/p1021rdb-pc.dtsi             |  12 +-
 arch/powerpc/boot/dts/p1025rdb_36b.dts             |   5 +
 arch/powerpc/boot/dts/t4240qds.dts                 | 224 +++++++++++
 arch/powerpc/configs/corenet64_smp_defconfig       |  46 ++-
 arch/powerpc/configs/mpc85xx_defconfig             |  40 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |  32 ++
 arch/powerpc/include/asm/cputable.h                |   2 +-
 arch/powerpc/include/asm/kvm_asm.h                 |   4 +
 arch/powerpc/include/asm/pci-bridge.h              |  11 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  16 +
 arch/powerpc/kernel/cputable.c                     |   9 +-
 arch/powerpc/kernel/epapr_hcalls.S                 |   2 +
 arch/powerpc/kernel/exceptions-64e.S               |  47 +++
 arch/powerpc/kernel/idle_book3e.S                  |  32 +-
 arch/powerpc/mm/tlb_nohash.c                       |  18 +-
 arch/powerpc/platforms/85xx/Kconfig                |  34 ++
 arch/powerpc/platforms/85xx/Makefile               |   2 +
 arch/powerpc/platforms/85xx/b4_qds.c               | 102 +++++
 arch/powerpc/platforms/85xx/corenet_ds.c           |   5 +-
 arch/powerpc/platforms/85xx/sgy_cts1000.c          |   6 +-
 arch/powerpc/platforms/85xx/smp.c                  |   2 +-
 arch/powerpc/platforms/85xx/t4240_qds.c            |  98 +++++
 arch/powerpc/platforms/Kconfig                     |   1 -
 arch/powerpc/platforms/Kconfig.cputype             |   2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |   5 -
 arch/powerpc/sysdev/fsl_msi.c                      |   4 +-
 arch/powerpc/sysdev/fsl_pci.c                      | 112 ++++--
 arch/powerpc/sysdev/fsl_pci.h                      |  13 +
 arch/powerpc/sysdev/indirect_pci.c                 |  10 +-
 arch/powerpc/sysdev/qe_lib/Kconfig                 |   2 +-
 62 files changed, 2738 insertions(+), 100 deletions(-)
 create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
 create mode 100644 arch/powerpc/boot/dts/b4420qds.dts
 create mode 100644 arch/powerpc/boot/dts/b4860qds.dts
 create mode 100644 arch/powerpc/boot/dts/b4qds.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi
 rename arch/powerpc/boot/dts/fsl/{qoriq-sec4.1-0.dtsi =3D> =
qoriq-sec5.0-0.dtsi} (83%)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/t4240qds.dts
 create mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
 create mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c=
