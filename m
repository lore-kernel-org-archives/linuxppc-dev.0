Message-ID: <3BFD8F2F.247CDF33@linux-m68k.org>
Date: Fri, 23 Nov 2001 00:50:07 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
References: <3BFAB960.DAA72239@mvista.com> <15357.26322.107051.143144@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Paul Mackerras wrote:

> If we have to have a consistent_sync_page, it should be purely a local
> function in our implementation of the official DMA mapping API - see
> Documentation/DMA-mapping.txt.  Drivers should be using functions such
> as pci_alloc_consistent, pci_map_single, pci_dma_sync_single,
> pci_unmap_single, etc.  The implementation of those routines should do
> the correct cache flushing - if it doesn't then we need to fix it.

This document only describes DMA _mappings_, it doesn't say anything
about cache coherency.

> If you're talking about non-PCI devices, use the pci DMA API but just
> pass NULL for the dev (we need to make sure that will work ok on the
> non-cache-coherent cpus).

That's the other problem, "non-PCI" sounds like ISA there, what about
other buses?

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
