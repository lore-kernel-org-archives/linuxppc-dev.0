Date: Wed, 31 Mar 2004 20:43:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Whitney <johnw@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331184353.GA20510@lst.de>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de> <DA08904D-8342-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DA08904D-8342-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 01:40:15PM -0500, John Whitney wrote:
> Just out of curiosity, are there replacements or are you just supposed
> to do good-practice things like store the dma address returned by
> pci_alloc_consistent/dma_alloc_coherent?

The latter.  (or pci_map* / dma_map*)

> >Standard-naming for those are readq/writeq afaik
>
> Specifically, the MTD code looks for __raw_readll/writell, which is why
> I used the convention I did.  I'll be happy to update the names if
> desired.

What mtd code?

hch@bird:/repo/repo/linux-2.5$ grep __raw_readll include/asm-*/io.h | wc -l
0
hch@bird:/repo/repo/linux-2.5$ grep __raw_readq include/asm-*/io.h | wc -l
22


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
