Date: Tue, 12 Dec 2000 11:17:05 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Dan Malek <dan@mvista.com>
cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
In-Reply-To: <3A36593C.1EE4CC5D@mvista.com>
Message-ID: <Pine.GSO.4.21.0012121106530.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 12 Dec 2000, Dan Malek wrote:

> Brian Ford wrote:
>
> > Are the explicit driver level calls to invalidate_dcache_range necessary
> > on the receive side,
>
> None of the cache management calls are necessary on the 8260 since the
> cache is snooped.  We are mixing processor types in this discussion,
> so be careful what you assume is necessary or works for a particular
> driver.  They are different.
>
Yes, I know.

Does your statement mean that 60x bus memory is mapped
_PAGE_COHERENT?  What is the exact meaning of the GBL bit in the FCRx
register?

I am confused about their relations.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
