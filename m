Date: Wed, 7 Jan 2004 08:43:12 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Tom Rini <trini@kernel.crashing.org>, Lee Braiden <jel@ntlworld.com>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040107074312.GA22544@iliana>
References: <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073460144.784.79.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 06:22:25PM +1100, Benjamin Herrenschmidt wrote:
>
> > BTW, i didn't manage to get the generic RTC code working on my pegasos,
> > and i am actually a bit pressed for time.
> >
> > Do you think a workaround, for the debian powerpc packages, would be to
> > add a test for the presence of a pmac in the CONFIG_RTC code, and abort
> > if one is found ?
> >
> > If so, what would be the best way to test for a pmac subarch in the
> > drivers/char/rtc.c code ?
>
> will the kernel let you build both drivers in ?

Yes, sure. But naturally they die horribly on pmac hardware, or so i am
told.

> then you can do, in 2.4, something ugly like that:
>
> #ifdef CONFIG_ALL_PPC
> if (_machine == _MACH_Pmac)
> 	return -ENODEV;
> #endif

Ok, cool, will try that out.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
