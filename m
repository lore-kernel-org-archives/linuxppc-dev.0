Date: Mon, 12 Nov 2001 18:31:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jun Sun <jsun@mvista.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	rz@linux-m68k.org
Subject: Re: [RFC] generic MIPS RTC driver
Message-ID: <20011112183158.C16490@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be> <3BF0371F.8040575B@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BF0371F.8040575B@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 12, 2001 at 09:54:55PM +0100, Roman Zippel wrote:
>
> Hi,
>
> Geert Uytterhoeven wrote:
>
> > > Geert, what is the abstraction they used?
> >
> > At first sight, we only use get_rtc_time() and mach_hwclk().
>
> Over the weekend I changed it into set_rtc_time()/get_rtc_time(), which
> are now defined in <asm/rtc.h>, so mach_hwclk() is gone in the generic
> part.

Could you please post a copy of this?  I wanna go and try and get the
rest of the PPC world going on it, if you didn't do that already.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
