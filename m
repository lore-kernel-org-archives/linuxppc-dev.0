Date: Tue, 27 Nov 2001 16:18:57 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Porter <mporter@mvista.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: include/asm-ppc/platforms/
In-Reply-To: <20011127050040.A15728@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.GSO.4.21.0111271617470.29663-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Nov 2001, Matt Porter wrote:
> On Thu, Dec 27, 2001 at 09:59:59AM -0500, Dan Malek wrote:
> > Paul Mackerras wrote:
> > > Does anyone have any comments or objections?
> >
> > That's a pretty good idea, and I have another one.  Name the
> > directory include/asm-ppc/ppc-platforms or something, then
> > have a symbolic link
> > 	include/asm/platform -> include/asm-ppc/ppc-platforms/<board-file>
> >
> > That way we can just #include <platform.h> instead of having lots
> > of ifdefs in upper level files to determine which one is needed.  If
> > we are moving files around, let's have some effect on actually making
> > it easier to use them, too.
>
> Yes, this is similar to what has worked well in the arm tree.

Note that ARM has include/asm-arm/arch-$(PLATFORM)/, i.e. a whole directory
with platform-specific files, not a single header file.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
