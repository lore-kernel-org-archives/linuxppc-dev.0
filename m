Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch 
In-reply-to: <18153.30975.926456.819248@cargo.ozlabs.ibm.com> 
References: <18153.30975.926456.819248@cargo.ozlabs.ibm.com>
Date: Fri, 14 Sep 2007 11:43:45 +1000
Message-ID: <623.1189734225@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

Could you take this as well for 2.6.24?

  Remove barriers from the SLB shadow buffer update
  http://patchwork.ozlabs.org/linuxppc/patch?id=13116

Mikey

In message <18153.30975.926456.819248@cargo.ozlabs.ibm.com> you wrote:
> David Gibson (2):
>       [POWERPC] Move bootwrapper's strchr() and strncmp() from .h to string.S
>       [POWERPC] Document and implement an improved flash device binding for p
owerpc
> 
> Geert Uytterhoeven (1):
>       [POWERPC] PS3: Add new LV1 error codes
> 
> Geoff Levand (1):
>       [POWERPC] PS3: Enhance storage probe debug output
> 
> Jeremy Kerr (1):
>       [POWERPC] PS3: Fix CONFIG_SMP=n, CONFIG_KEXEC=y build
> 
> Josh Boyer (6):
>       [POWERPC] Remove dtc build cruft from DTS files
>       [POWERPC] Fix bus probe on Bamboo board
>       [POWERPC] Walnut DTS
>       [POWERPC] Walnut defconfig
>       [POWERPC] Walnut board support
>       [POWERPC] Walnut zImage wrapper
> 
> Kumar Gala (3):
>       [POWERPC] Remove old includes from arch/ppc
>       [POWERPC] Copy over headers from arch/ppc to arch/powerpc that we need
>       [POWERPC] Stop include asm-ppc when building ARCH=powerpc for ppc32
> 
> Linas Vepstas (4):
>       [POWERPC] IOMMU virtual merge is no longer experimental
>       [POWERPC] prom_init whitespace cleanup, typo fix
>       [POWERPC] prom.c whitespace cleanup
>       [POWERPC] setup_64.c and prom.c comment cleanup
> 
> Michael Ellerman (5):
>       [POWERPC] Add an optional device_node pointer to the irq_host
>       [POWERPC] Invert null match behaviour for irq_hosts
>       [POWERPC] Provide a default irq_host match, which matches on an exact o
f_node
>       [POWERPC] Initialise hwirq for legacy irqs
>       [POWERPC] Export virq mapping via debugfs
> 
> Olof Johansson (10):
>       [POWERPC] Export new __io{re,un}map_at() symbols
>       [POWERPC] pasemi: Add pasemi_pci_getcfgaddr()
>       [POWERPC] pasemi: Add workaround for erratum 5945
>       [POWERPC] pasemi: Export more SPRs to sysfs when CONFIG_DEBUG_KERNEL=y
>       [POWERPC] pasemi: Print more information at machine check
>       [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
>       [POWERPC] Remove unused platform_machine_check()
>       [POWERPC] Move lowlevel runlatch calls under cpu feature control
>       [POWERPC] Remove warning in arch/powerpc/kernel/sysfs.c
>       [POWERPC] Add workaround for MPICs with broken register reads
> 
> Scott Wood (5):
>       [POWERPC] bootwrapper: flatdevtree fixes
>       [POWERPC] bootwrapper: Add strtoull()
>       [POWERPC] bootwrapper: Add get_path()
>       [POWERPC] bootwrapper: Only print MAC addresses when the node is actual
ly present
>       [POWERPC] Check _PAGE_RW and _PAGE_PRESENT on kernel addresses
> 
> Valentine Barshak (4):
>       [POWERPC] PowerPC 440EPx: Sequoia device tree
>       [POWERPC] PowerPC 440EPx: Sequoia defconfig
>       [POWERPC] PowerPC 440EPx: Sequoia board support
>       [POWERPC] PowerPC 440EPx: Sequoia bootwrapper
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
