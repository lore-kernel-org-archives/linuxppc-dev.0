Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DB5EDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 08:53:02 +1100 (EST)
Date: Tue, 17 Feb 2009 15:52:55 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0902171551460.23647@blarg.am.freescale.net>
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

 arch/powerpc/boot/dts/mpc8572ds.dts            |   10
 arch/powerpc/boot/dts/mpc8572ds_36b.dts        |  787 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    8
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    4
 arch/powerpc/include/asm/mmu-book3e.h          |  103 +++
 arch/powerpc/include/asm/mmu-fsl-booke.h       |   85 --
 arch/powerpc/include/asm/mmu.h                 |    6
 arch/powerpc/kernel/entry_32.S                 |    6
 arch/powerpc/kernel/head_fsl_booke.S           |   14
 arch/powerpc/mm/fsl_booke_mmu.c                |    6
 arch/powerpc/platforms/Kconfig.cputype         |    4
 11 files changed, 921 insertions(+), 112 deletions(-)

Kumar Gala (5):
      powerpc/85xx: Fixed PCI IO region sizes in mpc8572ds*.dts
      powerpc/85xx: Added 36-bit physical device tree for mpc8572ds board
      powerpc/fsl-booke: Add new ISA 2.06 page sizes and MAS defines
      powerpc/book-3e: Introduce concept of Book-3e MMU
      powerpc/fsl-booke: Fix compile warning

I'd also like the opcode patch to go in since several patches depend on
that (doorbell, tlbilx).  If you want to ack the patch I can put it into
my next branch for you.

- k
