Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E35B4DDF48
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:34:10 +1100 (EST)
Date: Wed, 7 Jan 2009 15:34:05 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0901071533460.3892@blarg.am.freescale.net>
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

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/boot/dts/mpc8544ds.dts            |    4
 arch/powerpc/boot/dts/mpc8572ds.dts            |    4
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    2
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    2
 arch/powerpc/include/asm/qe.h                  |   19 ++++
 arch/powerpc/kernel/asm-offsets.c              |    7 +
 arch/powerpc/kernel/head_fsl_booke.S           |    6 -
 arch/powerpc/mm/fsl_booke_mmu.c                |    9 --
 arch/powerpc/mm/mmu_decl.h                     |   11 ++
 arch/powerpc/platforms/fsl_uli1575.c           |    1
 arch/powerpc/sysdev/fsl_pci.c                  |  107 +++++++++++++++++--------
 11 files changed, 117 insertions(+), 55 deletions(-)

Jason Jin (1):
      powerpc: Fix the ide suspend function in uli1575

Kumar Gala (1):
      powerpc/85xx: Fix PCIe error interrupts

Timur Tabi (1):
      powerpc/qe: add Ethernet UPSMR definitions to QE library

Trent Piepho (4):
      powerpc/fsl-pci: Better ATMU setup for 85xx/86xx
      powerpc/fsl-pci: Set relaxed ordering on prefetchable ranges
      powerpc/fsl-booke: Don't hard-code size of struct tlbcam
      powerpc/fsl-booke: Remove num_tlbcam_entries
