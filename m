Date: Sat, 24 Jan 2004 21:01:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: chrp mmu and booting.
In-Reply-To: <1074890984.2840.25.camel@otta.rchland.ibm.com>
Message-ID: <Pine.GSO.4.58.0401242059430.11768@waterleaf.sonytel.be>
References: <20040123111725.GB23537@iliana>  <1074883450.2842.9.camel@otta.rchland.ibm.com>
  <20040123185433.GB5125@iliana> <1074890984.2840.25.camel@otta.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 23 Jan 2004, Peter Bergner wrote:
> On Fri, 2004-01-23 at 12:54, Sven Luther wrote:
> > Yeah, but in my case, i have no yaboot, and i know that these boxes are
> > also capable of booting from the OF.
>
> Yes, you can boot any 32-bit ELF binary from OF.  Yaboot and the zImage
> wrapper for the 64-bit kernel are both 32-bit ELF binaries, so you can
> boot either of these.  Note that you cannot boot a plain PPC64 vmlinux,
> as the OF ELF loader doesn't support 64-bit ELF binaries.

Indeed, when porting Linux to the LongTrail, my first program on the box was a
small assembler program to print `Hello, world!' to the serial port, compiled
to a plain ELF binary and loaded from OF.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
