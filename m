Subject: Re: Kernel versions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Wolfgang Denk <wd@denx.de>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	linuxppc <linuxppc@4bridgeworks.com>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1088783785.6277.346.camel@hermes>
References: <20040702145433.5BA0EC109F@atlas.denx.de>
	 <1088783785.6277.346.camel@hermes>
Content-Type: text/plain
Message-Id: <1089126527.1897.69.camel@gaston>
Mime-Version: 1.0
Date: Tue, 06 Jul 2004 10:08:47 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-07-02 at 10:56, Gary Thomas wrote:
> On Fri, 2004-07-02 at 08:54, Wolfgang Denk wrote:
> > In message <Pine.LNX.4.58.0407021623360.22661@denise.shiny.it> you wrote:
> > >
> > > The official 2.6.7 kernel works just fine on ppc machines.
> >
> > Please define "ppc machines". It doesn't work on most of the  systems
> > we have in the lab (like MPC8xx or MPC5200 etc.)
>
> Indeed.  Not all "PPC machines" are Apple MacIntosh systems, although
> Macs do use the PowerPC CPU.  Too many folks simply equate the two...

Then send patches upstream. It's plain wrong to reproduce what we
had in 2.4 letting all sort of stuffs pile up in the "ppc" trees
that never get sent upstream.

I tend to think that pretty much everything including fancy board
support should be sent to lkml for comment & proposed upstream right
away.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
