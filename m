Date: Wed, 17 Dec 2003 10:24:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031217172420.GT11761@stop.crashing.org>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston> <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston> <20031217095139.GC2283@iliana> <20031217164740.GR11761@stop.crashing.org> <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031217171052.GB11851@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031217171052.GB11851@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 17, 2003 at 06:10:52PM +0100, Sven Luther wrote:

>
> On Wed, Dec 17, 2003 at 10:06:20AM -0700, Tom Rini wrote:
> > On Wed, Dec 17, 2003 at 05:56:08PM +0100, Sven Luther wrote:
> > >
> > > On Wed, Dec 17, 2003 at 09:47:40AM -0700, Tom Rini wrote:
> > > > 4) Use CONFIG_GEN_RTC and be happy.  What _might_ be happening right now
> > > > is that chrp_get_rtc_time is 'funky' and not quite right for anything
> > > > other than an IBM OpenFirmeware'd CHRP box.  What I would suggest is
> > > > looking at include/asm-generic/rtc.h in 2.6 and moving much of that code
> > > > into 'chrp_get_rtc_time' and 'chrp_set_rtc_time'.
> > >
> > > Ok, thanks, i will look into it.
> > >
> > > But then, remember, this is for the debian powerpc kernel, and has to be
> > > 2.4.x still for now.
> >
> > Yes.  The code in <asm-generic/rtc.h> is taken right from
> > drivers/char/rtc.c.  It just didn't get sent to 2.4 for some reason.
>
> Ok, will do this tomorrow, thanks for your help.
>
> BTW, in this case, would it make sense to hide the CONFIG_RTC on powerpc ?

iff we get it working on chrp properly and someone adds the alarm
functionality, it shouldn't be objectionable.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
