Date: Thu, 25 Sep 2003 13:15:15 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Roland Dreier <roland@topspin.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
In-Reply-To: <52oex8kb07.fsf@topspin.com>
Message-ID: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 25 Sep 2003, Roland Dreier wrote:
> As I recall, the discussion ended with people like David Miller
> agreeing that 2.6 would fix this in a better way, but that my patch
> was OK for 2.4.  However, unaligned DMA buffers only seem to cause
> pain on non-mainstream platforms, so there was never much push to have
> my patch merged in 2.4.  I've never really pushed my patch since we've
> fixed all the problems with our own specific embedded PPC 4xx
> platform, and no one else seems to care very much.

I've read through the old thread about short DMAs, but still there are
things that aren't clear to me.

What exactly is the issue?

As I understand it, if there is a DMA to the same cache line as something
that the CPU is referencing, you've got a cache problem.

Does it matter what type of transfer the PCI device is doing? If it
always does 32-bit burst memory write transfers instead of memory
write & invalidate does that make a difference?

Right now, I'm interested in the PPC and x86 compatible (Pentium,
Pentium 4, Geode) systems, trying to understand the differences and
requirements of each.

Any insight into the details of the problem would be appreciated, on
list or off.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
