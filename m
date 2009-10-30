Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57AFDB7C3D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 17:26:49 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n9U6Qiju010771
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2009 01:26:45 -0500
Subject: powerpc "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2009 17:26:43 +1100
Message-ID: <1256884003.6372.72.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hoy hoy !

It's late, I know, but finally here's a first batch of patches in
powerpc "next" branch that I pushed out today. Hopefully more to come
as I start pulling from Kumar, Grant, etc... 

Cheers,
Ben.

Alexey Dobriyan (1):
      Convert /proc/device-tree/ to seq_file

Anton Vorontsov (2):
      powerpc: Make it possible to select hibernation on all PowerPCs
      of/platform: Implement support for dev_pm_ops

Benjamin Herrenschmidt (4):
      powerpc: Cleanup Kconfig selection of hugetlbfs support
      powerpc: Move /proc/ppc64 to /proc/powerpc and add symlink
      powerpc/chrp: Use the same RTAS daemon as pSeries
      powerpc/8xx: Fix build breakage with sparse irq changes

Brian King (1):
      powerpc: Add kdump support to Collaborative Memory Manager

David Gibson (6):
      powerpc/mm: Make hpte_need_flush() correctly mask for multiple page sizes
      powerpc/mm: Cleanup management of kmem_caches for pagetables
      powerpc/mm: Allow more flexible layouts for hugepage pagetables
      powerpc/mm: Cleanup initialization of hugepages on powerpc
      powerpc/mm: Split hash MMU specific hugepage code into a new file
      powerpc/mm: Bring hugepage PTE accessor functions back into sync with normal accessors

Jean Delvare (1):
      powerpc/therm_adt746x: Don't access non-existing register

Michael Ellerman (7):
      powerpc/ps3: Use pr_devel() in ps3/mm.c
      powerpc: Make NR_IRQS a CONFIG option
      powerpc/pseries: Use irq_has_action() in eeh_disable_irq()
      powerpc: Remove get_irq_desc()
      powerpc: Make virq_debug_show() cope with sparse irq_descs
      powerpc: Rearrange and fix show_interrupts() for sparse irq_descs
      powerpc: Enable sparse irq_descs on powerpc

Michael Neuling (1):
      powerpc: Fix potential compile error irqs_disabled_flags

Olof Johansson (1):
      powerpc: pasemi_defconfig update

Thomas Gleixner (3):
      powerpc/nvram_64: Remove unused code
      powerpc/nvram_64: Check nvram_error_log_index in nvram_clear_error_log()
      powerpc/nvram_64: Mark init code __init
