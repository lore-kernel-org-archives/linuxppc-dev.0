Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53329DE1A5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 17:26:00 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2B6PtKQ001800
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 01:25:56 -0500
Subject: test branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 17:25:55 +1100
Message-Id: <1236752755.7086.45.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following commits have been added to powerpc test:

Andrew Klossner (1):
      powerpc/udbg: Fix lost byte during console handover; change LFCR
to CRLF

Benjamin Herrenschmidt (10):
      powerpc/mm: Properly wire up get_user_pages_fast() on 32-bit
      powerpc/kconfig: Kill PPC_MULTIPLATFORM
      powerpc/mm: Split the various pgtable-* headers based on MMU type
      powerpc/mm: Unify PTE_RPN_SHIFT and _PAGE_CHG_MASK definitions
      powerpc/mm: Tweak PTE bit combination definitions
      powerpc/mm: Merge various PTE bits and accessors definitions
      powerpc/mm: Rename arch/powerpc/kernel/mmap.c to mmap_64.c
      powerpc/mm: Fix printk type warning in mmu_context_nohash
      powerpc/mm: Add option for non-atomic PTE updates to ppc64
      powerpc/mm: Introduce early_init_mmu() on 64-bit

Jeremy Kerr (2):
      powerpc/spufs: Check file offset before calculating write size in
fixed-sized files
      powerpc/spufs: Fix incorrect buffer offset in regs write

Michael Ellerman (5):
      powerpc: Print linux_banner in prom_init
      powerpc/pseries: Reject discontiguous/non-zero based MSI-X
requests
      powerpc/pseries: The pseries MSI code depends on EEH
      powerpc/cell: Fix Axon MSI driver dependencies
      powerpc/pseries: The RPA PCI hotplug driver depends on EEH

Octavian Purdila (1):
      powerpc/oprofile: Enable support for ppc750 processors

Thomas Gleixner (2):
      powerpc/irq: Convert obsolete irq_desc_t to struct irq_desc
      powerpc/irq: Convert obsolete hw_interrupt_type to struct irq_chip

Wolfram Sang (1):
      powerpc/pci: Fix typo: s/resouces/resources/ in a pr_debug
