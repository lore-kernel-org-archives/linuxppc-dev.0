Date: Thu, 3 Jun 2004 11:33:02 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: DMA support for MPC5xxx?
Message-ID: <20040603113302.A24468@home.com>
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040603164245.B24A9C109F@atlas.denx.de>; from wd@denx.de on Thu, Jun 03, 2004 at 06:42:40PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 03, 2004 at 06:42:40PM +0200, Wolfgang Denk wrote:
>
> Matt,
>
> in message <20040603090635.B7347@home.com> you wrote:
> >
> > It would be nice if you could work support for your silicon into
> > the de facto standard Linux/PPC community trees like the MPC85xx
> > folks are doing.
>
> We tried. We really tried.
>
> See the thread starting at
> http://lists.linuxppc.org/linuxppc-dev/200311/msg00000.html
>
> David even posted on this list to get feedback  from  the  community.
> But I haven't seen a single reply on the mailing lists.

So? Repost. I miss stuff the first time around a lot of times
myself [this is not to indicate that I would necessarily comment
on 5200 stuff, just an example].

> Please don't blame _us_ that the 5xxx code was not accepted  for  the
> public trees.
>
> This is really not fair!!!

Fair? Of course the community isn't fair. It's fickle and often
concerned only with its own current projects. Persistence really
helps when one wants something to be in the trees. Frankly, I'm
surprised that this isn't a top priority for Freescale. Maintaining
code in the kernel.org trees is far more efficient than when it
bit rots in some other tree. It also makes the support for Freescale's
silicon available to a wider audience.  I think that has got to be
high on their list.

Just to add fuel to the fire, I'll note that others are able to
appear on #mklinux and work out the issues in real-time with the
folks there. is often more desirable and productive. It's also often
the only way to get Paul's attention. Oh, and FWIW, the folks working
hard on 8xx and 85xx acceptance do manage to do this.

I'm glad I don't give up as easy. It took me a while to get core OCP/4xx
in linux-2.5. :)

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
