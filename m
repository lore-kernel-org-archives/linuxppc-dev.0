Subject: Re: Kernel versions
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gary Thomas <gary@mlbassoc.com>, Wolfgang Denk <wd@denx.de>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	linuxppc <linuxppc@4bridgeworks.com>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1089126527.1897.69.camel@gaston>
References: <20040702145433.5BA0EC109F@atlas.denx.de>
	 <1088783785.6277.346.camel@hermes>  <1089126527.1897.69.camel@gaston>
Content-Type: text/plain
Message-Id: <1092416380.14552.36.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 17:59:41 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-07-06 at 10:08 -0500, Benjamin Herrenschmidt wrote:
> On Fri, 2004-07-02 at 10:56, Gary Thomas wrote:
> > On Fri, 2004-07-02 at 08:54, Wolfgang Denk wrote:
> > > In message <Pine.LNX.4.58.0407021623360.22661@denise.shiny.it> you wrote:
> > > >
> > > > The official 2.6.7 kernel works just fine on ppc machines.
> > >
> > > Please define "ppc machines". It doesn't work on most of the  systems
> > > we have in the lab (like MPC8xx or MPC5200 etc.)

There was a fair amount of MPC5200 code merged recently. MPC8xx
apparently isn't far off working either.

> > Indeed.  Not all "PPC machines" are Apple MacIntosh systems, although
> > Macs do use the PowerPC CPU.  Too many folks simply equate the two...

Amongst the "PPC machines" on which I have 2.6 running are mpc8265,
mpc8560 and a dual 745x machine with MV64360 chipset -- although the
latter isn't merged into Linus' tree yet.

It's not _just_ working on macs.

> I tend to think that pretty much everything including fancy board
> support should be sent to lkml for comment & proposed upstream right
> away.

Works for me.

--
dwmw2


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
