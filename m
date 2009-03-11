Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: test branch update 
In-reply-to: <1236752755.7086.45.camel@pasglop> 
References: <1236752755.7086.45.camel@pasglop>
Date: Wed, 11 Mar 2009 19:43:37 +1100
Message-ID: <28138.1236761017@neuling.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FYI pseries_defconfig and ppc64_defconfig boot fine with this on BML
systemsim.

Mikey "manual kisskb" Neuling

> The following commits have been added to powerpc test:
> 
> Andrew Klossner (1):
>       powerpc/udbg: Fix lost byte during console handover; change LFCR
> to CRLF
> 
> Benjamin Herrenschmidt (10):
>       powerpc/mm: Properly wire up get_user_pages_fast() on 32-bit
>       powerpc/kconfig: Kill PPC_MULTIPLATFORM
>       powerpc/mm: Split the various pgtable-* headers based on MMU type
>       powerpc/mm: Unify PTE_RPN_SHIFT and _PAGE_CHG_MASK definitions
>       powerpc/mm: Tweak PTE bit combination definitions
>       powerpc/mm: Merge various PTE bits and accessors definitions
>       powerpc/mm: Rename arch/powerpc/kernel/mmap.c to mmap_64.c
>       powerpc/mm: Fix printk type warning in mmu_context_nohash
>       powerpc/mm: Add option for non-atomic PTE updates to ppc64
>       powerpc/mm: Introduce early_init_mmu() on 64-bit
> 
> Jeremy Kerr (2):
>       powerpc/spufs: Check file offset before calculating write size in
> fixed-sized files
>       powerpc/spufs: Fix incorrect buffer offset in regs write
> 
> Michael Ellerman (5):
>       powerpc: Print linux_banner in prom_init
>       powerpc/pseries: Reject discontiguous/non-zero based MSI-X
> requests
>       powerpc/pseries: The pseries MSI code depends on EEH
>       powerpc/cell: Fix Axon MSI driver dependencies
>       powerpc/pseries: The RPA PCI hotplug driver depends on EEH
> 
> Octavian Purdila (1):
>       powerpc/oprofile: Enable support for ppc750 processors
> 
> Thomas Gleixner (2):
>       powerpc/irq: Convert obsolete irq_desc_t to struct irq_desc
>       powerpc/irq: Convert obsolete hw_interrupt_type to struct irq_chip
> 
> Wolfram Sang (1):
>       powerpc/pci: Fix typo: s/resouces/resources/ in a pr_debug
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
