In-Reply-To: <20040331184353.GA20510@lst.de>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331181852.GA20127@lst.de> <DA08904D-8342-11D8-9FF0-000A95A07384@sands-edge.com> <20040331184353.GA20510@lst.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5007C040-8344-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 13:50:43 -0500
To: Christoph Hellwig <hch@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> What mtd code?
>
> hch@bird:/repo/repo/linux-2.5$ grep __raw_readll include/asm-*/io.h |
> wc -l
> 0
> hch@bird:/repo/repo/linux-2.5$ grep __raw_readq include/asm-*/io.h |
> wc -l
> 22
>
>

Specifically, include/linux/mtd/cfi.h and include/linux/mtd/map.h.  If
__raw_readll/writell aren't defined (as macros), they define them as a
direct read/write from a volatile u64 pointer.  I'll copy this over to
an MTD developer as well, perhaps we can fix MTD to use the standard
__raw_readq/writeq instead.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
