Message-ID: <3BF0145C.9795C8CC@mvista.com>
Date: Mon, 12 Nov 2001 10:26:36 -0800
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl> <1005581679.459.4.camel@zeus>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Pete Popov wrote:
>
> On Mon, 2001-11-12 at 05:29, Maciej W. Rozycki wrote:
> > On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
> >
> > > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > > driver for anyway.
> > >
> > > Yep, so that's why both m68k and PPC have common routines to read/write the
> > > RTC, with a /dev/rtc-compatible abstraction on top of it.
> >
> >  OK, then you need an RTC chipset-specific driver and not a CPU
> > architecture-specific one.  Otherwise we'll end with a zillion of similar
> > RTC drivers like we already have for LANCE and SCC chips.
>
> I agree.  We don't have arch specific network drivers so why have arch
> specific rtc drivers.
>

Because we can have a free RTC driver working once you get kernel working.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
