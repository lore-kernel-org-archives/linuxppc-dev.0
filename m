Date: Tue, 13 Nov 2001 15:47:53 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	rz@linux-m68k.org
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <20011113074424.A16723@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0111131547180.10875-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Nov 2001, Tom Rini wrote:
> On Tue, Nov 13, 2001 at 07:20:51AM +0100, Geert Uytterhoeven wrote:
> > On Mon, 12 Nov 2001, Tom Rini wrote:
> > > On Mon, Nov 12, 2001 at 09:54:55PM +0100, Roman Zippel wrote:
> > > > Geert Uytterhoeven wrote:
> > > > > > Geert, what is the abstraction they used?
> > > > >
> > > > > At first sight, we only use get_rtc_time() and mach_hwclk().
> > > >
> > > > Over the weekend I changed it into set_rtc_time()/get_rtc_time(), which
> > > > are now defined in <asm/rtc.h>, so mach_hwclk() is gone in the generic
> > > > part.
> > >
> > > Could you please post a copy of this?  I wanna go and try and get the
> > > rest of the PPC world going on it, if you didn't do that already.
> >
> > http://linux-m68k-cvs.apia.dhs.org/
>
> That's the non-generic m68k version tho, yes?  Or did Roman do it in
> that tree too?

That's the real one. On Q40/Q60 it provides some additional features, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
