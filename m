Message-ID: <3BF0371F.8040575B@linux-m68k.org>
Date: Mon, 12 Nov 2001 21:54:55 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jun Sun <jsun@mvista.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	rz@linux-m68k.org
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Geert Uytterhoeven wrote:

> > Geert, what is the abstraction they used?
>
> At first sight, we only use get_rtc_time() and mach_hwclk().

Over the weekend I changed it into set_rtc_time()/get_rtc_time(), which
are now defined in <asm/rtc.h>, so mach_hwclk() is gone in the generic
part.
Another feature is the emulation of the timer interrupt, although I have
no idea which program is using this. Richard?

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
