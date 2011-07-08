Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8506CB6F7A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 22:58:38 +1000 (EST)
Date: Fri, 8 Jul 2011 07:58:31 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1107080758020.28136@right.am.freescale.net>
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

The following changes since commit af9719c3062dfe216a0c3de3fa52be6d22b4456c:

  powerpc: Use -mtraceback=no (2011-07-01 13:49:27 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Becky Bruce (1):
      powerpc: Create next_tlbcam_idx percpu variable for FSL_BOOKE

Felix Radensky (1):
      powerpc/p1022ds: Remove fixed-link property from ethernet nodes.

Kumar Gala (5):
      powerpc/85xx: Add P3041 SoC device tree include stub
      powerpc/85xx: Add P5020 SoC device tree include stub
      driver core: Add ability for arch code to setup pdev_archdata
      powerpc: implement arch_setup_pdev_archdata
      powerpc: Dont require a dma_ops struct to set dma mask

Laurentiu TUDOR (1):
      powerpc/85xx: Remove stale BUG_ON in mpc85xx_smp_init

Mingkai Hu (1):
      powerpc/85xx: Add p2040 RDB board support

Timur Tabi (2):
      drivers/virt: introduce Freescale hypervisor management driver
      powerpc/85xx: add hypervisor config entries to corenet_smp_defconfig

 Documentation/ioctl/ioctl-number.txt         |    1 +
 arch/powerpc/boot/dts/p1022ds.dts            |    2 -
 arch/powerpc/boot/dts/p2040rdb.dts           |  166 +++++
 arch/powerpc/boot/dts/p2040si.dtsi           |  623 +++++++++++++++++
 arch/powerpc/boot/dts/p3041ds.dts            |  579 +----------------
 arch/powerpc/boot/dts/p3041si.dtsi           |  660 ++++++++++++++++++
 arch/powerpc/boot/dts/p5020ds.dts            |  571 +----------------
 arch/powerpc/boot/dts/p5020si.dtsi           |  652 ++++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig |    4 +
 arch/powerpc/include/asm/mmu.h               |    5 +
 arch/powerpc/kernel/dma.c                    |    4 +-
 arch/powerpc/kernel/setup-common.c           |   28 +-
 arch/powerpc/kernel/smp.c                    |    4 +
 arch/powerpc/mm/mem.c                        |    9 +
 arch/powerpc/mm/tlb_nohash.c                 |    6 +
 arch/powerpc/platforms/85xx/Kconfig          |   12 +
 arch/powerpc/platforms/85xx/Makefile         |    1 +
 arch/powerpc/platforms/85xx/p2040_rdb.c      |   88 +++
 arch/powerpc/platforms/85xx/smp.c            |    9 +-
 drivers/Kconfig                              |    2 +
 drivers/Makefile                             |    3 +
 drivers/base/platform.c                      |   21 +
 drivers/of/platform.c                        |    4 +-
 drivers/virt/Kconfig                         |   32 +
 drivers/virt/Makefile                        |    5 +
 drivers/virt/fsl_hypervisor.c                |  937 ++++++++++++++++++++++++++
 include/linux/Kbuild                         |    1 +
 include/linux/fsl_hypervisor.h               |  241 +++++++
 include/linux/platform_device.h              |    1 +
 29 files changed, 3488 insertions(+), 1183 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p2040rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p2040si.dtsi
 create mode 100644 arch/powerpc/boot/dts/p3041si.dtsi
 create mode 100644 arch/powerpc/boot/dts/p5020si.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c
 create mode 100644 drivers/virt/Kconfig
 create mode 100644 drivers/virt/Makefile
 create mode 100644 drivers/virt/fsl_hypervisor.c
 create mode 100644 include/linux/fsl_hypervisor.h
