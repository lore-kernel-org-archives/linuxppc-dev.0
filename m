Date: Fri, 29 Jun 2001 01:21:25 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <3B3C30CD.34B20F02@mvista.com>
Message-ID: <Pine.LNX.3.95.1010629011928.2623B-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 29 Jun 2001, Dan Malek wrote:

>
> jtm@smoothsmoothie.com wrote:
>
> > .... The buffer memory will get filled
> > via DMA, and therefore must not be cached.
>
> Huh????  The 8260 is cache coherent, you don't need to do that.
>
> For processors that are not cache coherent (4xx and 8xx), there
> are standard 'consistent_alloc()' functions available.
>

Are those functions in the code for the 6xx proceesors? I have a 603e with
a broken memory controller- it does everything (or so I am assured) except
support atomic functions (ie, no memory coherency). If they are not in the
codo, are they at least portable to the 6xx?

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
