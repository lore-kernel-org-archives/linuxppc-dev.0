Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48E3CDDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:54:26 +1000 (EST)
Date: Wed, 24 Sep 2008 16:54:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'dma' branch
Message-ID: <Pine.LNX.4.64.0809241652540.22678@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'dma' branch of

(forgot linuxppc-dev on first go around)

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git dma

to receive the following updates:

 arch/powerpc/include/asm/device.h       |    3
 arch/powerpc/include/asm/dma-mapping.h  |  187 +++++++++--------------------
 arch/powerpc/include/asm/machdep.h      |    5
 arch/powerpc/include/asm/pci.h          |   14 +-
 arch/powerpc/include/asm/types.h        |    2
 arch/powerpc/kernel/Makefile            |    4
 arch/powerpc/kernel/dma-iommu.c         |  103 ++++++++++++++++
 arch/powerpc/kernel/dma.c               |  127 ++++++++++++++++++++
 arch/powerpc/kernel/dma_64.c            |  200 --------------------------------
 arch/powerpc/kernel/of_device.c         |    2
 arch/powerpc/kernel/pci-common.c        |   48 +++++++
 arch/powerpc/kernel/pci_32.c            |    7 +
 arch/powerpc/kernel/pci_64.c            |   49 -------
 arch/powerpc/kernel/vio.c               |    2
 arch/powerpc/platforms/cell/iommu.c     |    6
 arch/powerpc/platforms/ps3/system-bus.c |    2
 16 files changed, 366 insertions(+), 395 deletions(-)

Becky Bruce (5):
      powerpc: Rename dma_64.c to dma.c
      powerpc: Move iommu dma ops from dma.c to dma-iommu.c
      powerpc: Drop archdata numa_node
      powerpc: Merge 32 and 64-bit dma code
      powerpc: Make dma_addr_t a u64 if CONFIG_PHYS_64BIT is set
