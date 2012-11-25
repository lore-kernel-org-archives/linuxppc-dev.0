Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 98B192C007E
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2012 00:27:27 +1100 (EST)
Date: Sun, 25 Nov 2012 07:27:21 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1211250726550.14762@right.am.freescale.net>
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

The following changes since commit cedddd812a79a4fda3885a15711aee3de78c4a24:

  powerpc: Disable relocation on exceptions when kexecing (2012-11-15 15:08:08 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

for you to fetch changes up to 1723d90915d4689fa2e8cd4151d45ea38c96cb99:

  powerpc/dma/raidengine: add raidengine device (2012-11-25 07:19:51 -0600)

----------------------------------------------------------------
Jia Hongtao (1):
      powerpc/fsl-pci: Add PCI controller ATMU PM support

Timur Tabi (2):
      drivers/virt: the Freescale hypervisor driver doesn't need to check MSR[GS]
      powerpc/86xx: fsl_pcibios_fixup_bus requires CONFIG_PCI

Tushar Behera (1):
      powerpc/85xx: p1022ds: Use NULL instead of 0 for pointers

Varun Sethi (1):
      powerpc/iommu/fsl: Add PAMU bypass enable register to ccsr_guts struct

Xuelin Shi (1):
      powerpc/dma/raidengine: add raidengine device

York Sun (1):
      powerpc/mpc85xx: Change spin table to cached memory

 .../devicetree/bindings/powerpc/fsl/raideng.txt    |   81 +++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |    1 +
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |    6 ++
 arch/powerpc/boot/dts/fsl/qoriq-raid1.0-0.dtsi     |   85 ++++++++++++++++++++
 arch/powerpc/include/asm/fsl_guts.h                |    4 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |   49 ++++++++---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +
 arch/powerpc/sysdev/fsl_pci.c                      |   37 ++++++++-
 drivers/virt/fsl_hypervisor.c                      |    3 -
 10 files changed, 250 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/raideng.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-raid1.0-0.dtsi
