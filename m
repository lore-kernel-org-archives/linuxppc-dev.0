Message-ID: <3A38FC27.CE7F7F24@mvista.com>
Date: Thu, 14 Dec 2000 11:58:15 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos> <20001213121554.B17129@brixi.research.canon.com.au> <3A37A048.46E692A0@mvista.com> <20001214182126.E8430@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> > The advantage of Graham's DMA into skbufs isn't that the driver doesn't
> > copy/sum, it is that later when the IP stack does it we get burst transfers
> > into cache.
>
> But we get burst transfers into cache in either case,

No, because I originally allocated the receive buffers uncached.
Only cached/copyback pages will burst on the bus.  The CPM DMA will
always burst.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
