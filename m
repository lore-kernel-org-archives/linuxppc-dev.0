Subject: Re: Missing isa_ symbols
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0402151141120.22078@waterleaf.sonytel.be>
References: <20040203210321.GA19689@lst.de>
	 <20040203231728.GF1860@smtp.west.cox.net> <20040214164611.GA15893@lst.de>
	 <Pine.GSO.4.58.0402151141120.22078@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1076847875.6959.58.camel@gaston>
Mime-Version: 1.0
Date: Sun, 15 Feb 2004 23:24:36 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > +#define __ISA_IO_base ((char *)(PAGE_OFFSET))
>
> This is not true, I think.

Don't we have an isa_io_base and isa_mem_base ? let's just use
these and return 0xffffffff if not there... (assume base = 0 as
non-existing is safe, we'll never ioremap these at 0 physical)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
