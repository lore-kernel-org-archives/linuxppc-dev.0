Subject: Re: Disable cache on 74xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian Waite <waite@skycomputers.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gary Thomas <gary@mlbassoc.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200302201047.02490.waite@skycomputers.com>
References: <Pine.GSO.4.21.0302201507510.27212-100000@vervain.sonytel.be>
	 <3E54F2EF.2080601@embeddededge.com>
	 <200302201047.02490.waite@skycomputers.com>
Content-Type: text/plain
Message-Id: <1045756536.12534.106.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 20 Feb 2003 16:55:37 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-02-20 at 16:47, Brian Waite wrote:
> Well to preface, some people around here think disabling cache is a good idea.
> I report to one of those :). What I am trying to debug is why my custom board
> hangs. Basically,  what I see is when a PCI interface starts reading/writing
> SDRAM, my 745x processor locks up. I see no more decrementer interrupts being
> serviced and using a BDI 2000 JTAG interface I see the processors stalled on
> some memory access instruciton. The memory controller (gt64260) seems to be
> doing something very wrong and it is thought to be a cache coherency issue.
> So to prove this, I was asked to try running without any sort of cache.
> Hopefully between Gary's information and yours, Dan I can convince people
> that it is futile.

It could be the gt doing something wrong, it could also be the
CPU, 745x have known lockup conditions, though at least some of
them have workarounds enabled in the kernel.

Look closely at the CPU errata.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
