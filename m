Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A503AB7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 14:14:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65C91DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 14:14:25 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n6R4EH1b009743
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Jul 2009 23:14:18 -0500
Subject: "test" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 14:14:17 +1000
Message-Id: <1248668057.5706.2.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi !

I've started collecting things for my -next branch. For now I put
everything in -test, I'll move it over to -next in the upcoming couple
of days if there's no major issue found.

The current log if what I put in is:

Anton Blanchard (3):
      powerpc: Move 64bit VDSO to improve context switch performance
      powerpc: Rearrange SLB preload code
      powerpc: Preload application text segment instead of TASK_UNMAPPED_BASE

Benjamin Herrenschmidt (27):
      mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
      powerpc: Rename exception.h to exception-64s.h
      powerpc: Use names rather than numbers for SPRGs (v2)
      powerpc: Remove use of a second scratch SPRG in STAB code
      powerpc/mm: Fix definitions of FORCE_MAX_ZONEORDER in Kconfig
      powerpc/pmac: Fix PowerSurge SMP IPI allocation
      powerpc: Change PACA from SPRG3 to SPRG1
      powerpc/mm: Fix misplaced #endif in pgtable-ppc64-64k.h
      powerpc/of: Remove useless register save/restore when calling OF back
      powerpc/mm: Add HW threads support to no_hash TLB management
      powerpc/mm: Add opcode definitions for tlbivax and tlbsrx.
      powerpc/mm: Add more bit definitions for Book3E MMU registers
      powerpc/mm: Add support for early ioremap on non-hash 64-bit processors
      powerpc: Modify some ppc_asm.h macros to accomodate 64-bits Book3E
      powerpc/mm: Make low level TLB flush ops on BookE take additional args
      powerpc/mm: Call mmu_context_init() from ppc64
      powerpc: Clean ifdef usage in copy_thread()
      powerpc: Move definitions of secondary CPU spinloop to header file
      powerpc/mm: Rework & cleanup page table freeing code path
      powerpc: Add SPR definitions for new 64-bit BookE
      powerpc: Add memory management headers for new 64-bit BookE
      powerpc: Add definitions used by exception handling on 64-bit Book3E
      powerpc: Add PACA fields specific to 64-bit Book3E processors
      powerpc/mm: Move around mmu_gathers definition on 64-bit
      powerpc: Add TLB management code for 64-bit Book3E
      powerpc/mm: Add support for SPARSEMEM_VMEMMAP on 64-bit Book3E
      powerpc: Remaining 64-bit Book3E support

Chase Douglas (1):
      powerpc: Add compat_sys_truncate

Frans Pop (1):
      powerpc: Makefile simplification through use of cc-ifversion

Geoff Thorpe (1):
      powerpc: expose the multi-bit ops that underlie single-bit ops.

Gerhard Pircher (1):
      powerpc/amigaone: Convert amigaone_init() to a machine_device_initcall()

Lucian Adrian Grijincu (1):
      powerpc: Update boot wrapper script with the new location of dtc

Michael Ellerman (1):
      powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs

roel kluin (1):
      powerpc/cell: Replace strncpy by strlcpy
