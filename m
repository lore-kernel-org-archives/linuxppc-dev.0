Date: Wed, 7 Jan 2004 11:54:37 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Tom Rini <trini@kernel.crashing.org>, Lee Braiden <jel@ntlworld.com>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040107105437.GA26103@iliana>
References: <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107074740.GB22544@iliana> <1073464206.4416.81.camel@gaston> <20040107095358.GA24780@iliana> <1073472268.4416.104.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073472268.4416.104.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 09:44:28PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-01-07 at 20:53, Sven Luther wrote:
> > On Wed, Jan 07, 2004 at 07:30:06PM +1100, Benjamin Herrenschmidt wrote:
> > >
> > > >  1) could a #ifdef __powerpc__ not be enough ?
> > >
> > > No. _machine is only defined for the "multiarch" config (PREP/CHRP/PMAC)
> >
> > Ok. I suppose it doesn't make sense also to include the #ifdef
> > CONFIG_ALL_PPC in a #ifdef __powerpc__ ?
>
> Yup, useless to stack them.
>
> > > >  2) The other failures in rtc_init return -EIO, not -ENODEV.
> > >
> > > Well, in this case, -ENODEV makes more sense, though nothing really
> > > cares except the kind of error message the user will get when using
> > > it as a module.
> >
> > I think i will keep it as the others for the debian package.
>
> Why ? The error is definitely not an IO error :) Nothing really relies
> on this error code anyway...

So, would it be meaningfull to change all the others to NODEV too ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
