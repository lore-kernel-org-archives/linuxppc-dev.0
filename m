Date: Wed, 31 Mar 2004 13:52:48 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: John Whitney <johnw@sands-edge.com>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331215248.GB831@gate.ebshome.net>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de> <A973047C-8357-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A973047C-8357-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 04:09:13PM -0500, John Whitney wrote:
>
> >>1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
> >>phys_to_virt.  With the use of fully virtual addresses for
> >
> >These are all obsolete interface and you're not supposed to use them
> >for new plattforms or drivers at all.
> >
>
> pci_map_single() (include/asm-ppc/pci.h) and dma_map_single()
> (include/asm-ppc/dma-mapping.h) use virt_to_bus().  Shouldn't some care
> be taken to ensure that ANY virtual address passed to these routines
> maps to the correct physical (bus) address?
>

Please, read DMA-mapping.txt, it's quite clear on what memory is considered
DMA'able.

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
