In-Reply-To: <20040331181852.GA20127@lst.de>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A973047C-8357-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 16:09:13 -0500
To: Christoph Hellwig <hch@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> 1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
>> phys_to_virt.  With the use of fully virtual addresses for
>
> These are all obsolete interface and you're not supposed to use them
> for new plattforms or drivers at all.
>

pci_map_single() (include/asm-ppc/pci.h) and dma_map_single()
(include/asm-ppc/dma-mapping.h) use virt_to_bus().  Shouldn't some care
be taken to ensure that ANY virtual address passed to these routines
maps to the correct physical (bus) address?

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
