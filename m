Date: Wed, 17 Dec 2003 11:27:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>,
	Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on
 your machine ?
In-Reply-To: <20031217095139.GC2283@iliana>
Message-ID: <Pine.GSO.4.58.0312171126330.24864@waterleaf.sonytel.be>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston>
 <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston>
 <20031217095139.GC2283@iliana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Dec 2003, Sven Luther wrote:
> On Wed, Dec 17, 2003 at 06:27:37PM +1100, Benjamin Herrenschmidt wrote:
> > CONFIG_PPC_RTC/CONFIG_GENERIC_RTC is a different driver that provides
> > the /dev/rtc interface but relies on hooks provided by the platform
> > code for actually getting/setting the RTC content. The PowerMac platform
> > provides hooks for the different kind of RTC chips found on Macs (that
> > is basically  access to the RTC via via-cuda or via-pmu). CHRP or
>
> Mmm, these are external via chips on mac hardware used for clocks ?

No, that's VIA as in Versatile Interface Adapter, not as in VIA Technologies.
It used to be a separate chip in the old 68000 days, but now it's integrated in
some Mac fabric (e.g. Mac I/O).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
