Message-ID: <3BF0213A.CE13CAA1@mvista.com>
Date: Mon, 12 Nov 2001 11:21:30 -0800
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112195657.24771N-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Maciej W. Rozycki" wrote:
>
> On Mon, 12 Nov 2001, Jun Sun wrote:
>
> > >  OK, then you need an RTC chipset-specific driver and not a CPU
> > > architecture-specific one.
> >
> > You *can* write a chip specific driver in addition to this generic one if you
> > want.  Presumably the chip-specific one provides more operations than just
> > read/write date.
>
>  Then why make this driver MIPS-specific?
>

I suppose one of my previous replies should answer this.  Let me know if it
does not.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
