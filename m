Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84422DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:57:24 +1000 (EST)
Date: Wed, 24 Sep 2008 16:57:14 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'mmu' branch
Message-ID: <Pine.LNX.4.64.0809241654200.22678@blarg.am.freescale.net>
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

Please pull from 'mmu' branch of

(forgot linuxppc-dev on first go around)


	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git mmu

to receive the following updates:

 arch/powerpc/include/asm/highmem.h       |    2
 arch/powerpc/include/asm/io.h            |    2
 arch/powerpc/include/asm/page_32.h       |    8 ++
 arch/powerpc/include/asm/pgtable-ppc32.h |   57 +++++++++++++++++---
 arch/powerpc/include/asm/reg_booke.h     |    7 ++
 arch/powerpc/include/asm/tlbflush.h      |   13 ++--
 arch/powerpc/kernel/asm-offsets.c        |    1
 arch/powerpc/kernel/head_32.S            |    4 -
 arch/powerpc/kernel/head_fsl_booke.S     |    2
 arch/powerpc/kernel/misc_32.S            |   54 +++++++++++++++++++
 arch/powerpc/kernel/ppc_ksyms.c          |    3 +
 arch/powerpc/mm/hash_low_32.S            |   86 +++++++++++++++++++++++++------
 arch/powerpc/mm/pgtable_32.c             |    4 -
 arch/powerpc/mm/tlb_32.c                 |    1
 arch/powerpc/platforms/Kconfig.cputype   |   17 +++---
 15 files changed, 215 insertions(+), 46 deletions(-)

Becky Bruce (1):
      POWERPC: Allow 32-bit hashed pgtable code to support 36-bit physical

Kumar Gala (3):
      powerpc: Introduce local (non-broadcast) forms of tlb invalidates
      powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
      powerpc/mm: Implement _PAGE_SPECIAL & pte_special() for 32-bit
