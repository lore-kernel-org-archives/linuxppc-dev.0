Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0244BDDF77
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 11:40:48 +1100 (EST)
Date: Tue, 17 Mar 2009 19:40:41 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'test'
Message-ID: <Pine.LNX.4.64.0903171939360.26038@blarg.am.freescale.net>
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

Please pull from 'test' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git test

to receive the following updates:

 arch/powerpc/include/asm/mmu.h      |    6 +
 arch/powerpc/include/asm/mpic.h     |    5 +
 arch/powerpc/kernel/cpu_setup_6xx.S |    4 +
 arch/powerpc/kernel/cputable.c      |    9 +-
 arch/powerpc/kernel/head_32.S       |  109 ++++++++++++++++++++++--------------
 arch/powerpc/kernel/pci-common.c    |    2
 arch/powerpc/sysdev/mpic.c          |   30 +++++++++
 drivers/net/gianfar.c               |   34 +++++------
 drivers/net/gianfar.h               |    3
 9 files changed, 139 insertions(+), 63 deletions(-)

Kumar Gala (7):
      powerpc: Add support for CoreInt delivery of interrupts on MPIC
      powerpc/pci: Default to dma_direct_ops for pci dma_ops
      powerpc/mm: Respect _PAGE_COHERENT on classic ppc32 SW TLB load machines
      powerpc/mm: Remove unused register usage in SW TLB miss handling
      powerpc/mm: Used free register to save a few cycles in SW TLB miss handling
      powerpc/mm: e300c2/c3/c4 TLB errata workaround
      gianfar: pass the proper dev to DMA ops
