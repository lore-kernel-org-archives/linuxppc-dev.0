Subject: Re: [RFC] generic MIPS RTC driver
From: Pete Popov <ppopov@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jun Sun <jsun@mvista.com>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1011112142501.24771K-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain
Date: 12 Nov 2001 08:14:39 -0800
Message-Id: <1005581679.459.4.camel@zeus>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2001-11-12 at 05:29, Maciej W. Rozycki wrote:
> On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
>
> > >  Unless you use a non-MC146818 RTC, which you need to write a separate
> > > driver for anyway.
> >
> > Yep, so that's why both m68k and PPC have common routines to read/write the
> > RTC, with a /dev/rtc-compatible abstraction on top of it.
>
>  OK, then you need an RTC chipset-specific driver and not a CPU
> architecture-specific one.  Otherwise we'll end with a zillion of similar
> RTC drivers like we already have for LANCE and SCC chips.

I agree.  We don't have arch specific network drivers so why have arch
specific rtc drivers.

Pete


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
