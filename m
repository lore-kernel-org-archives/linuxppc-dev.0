In-Reply-To: <20040331181852.GA20127@lst.de>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DA08904D-8342-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 13:40:15 -0500
To: Christoph Hellwig <hch@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> 1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
>> phys_to_virt.  With the use of fully virtual addresses for
>
> These are all obsolete interface and you're not supposed to use them
> for new plattforms or drivers at all.

Just out of curiosity, are there replacements or are you just supposed
to do good-practice things like store the dma address returned by
pci_alloc_consistent/dma_alloc_coherent?

> Standard-naming for those are readq/writeq afaik

Specifically, the MTD code looks for __raw_readll/writell, which is why
I used the convention I did.  I'll be happy to update the names if
desired.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
