Date: Wed, 17 Dec 2003 17:18:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
	Lee Braiden <jel@ntlworld.com>, Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on
 your machine ?
In-Reply-To: <0E17AA13-30A8-11D8-9472-000A95A4DC02@kernel.crashing.org>
Message-ID: <Pine.GSO.4.58.0312171718180.24864@waterleaf.sonytel.be>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston>
 <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston>
 <20031217095139.GC2283@iliana> <Pine.GSO.4.58.0312171126330.24864@waterleaf.sonytel.be>
 <0E17AA13-30A8-11D8-9472-000A95A4DC02@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Dec 2003, Segher Boessenkool wrote:
> > No, that's VIA as in Versatile Interface Adapter, not as in VIA
> > Technologies.
> > It used to be a separate chip in the old 68000 days, but now it's
> > integrated in
> > some Mac fabric (e.g. Mac I/O).
>
> Actually, there is no RTC chip _at all_ in NewWorld Macs.  The PMU
> itself keeps the time (from a 32768Hz clock).

So from a technical point of view, the PMU is the RTC chip, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
