Date: Wed, 18 Oct 2000 13:17:17 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Thomas Graichen <graichen@innominate.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: openoffice on ppc anyone?
In-Reply-To: <Pine.LNX.4.10.10010172057330.27337-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10010181316430.841-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Oct 2000, Michael Schmitz wrote:
> > is anyone trying to get the now opensource staroffice to compile on
> > linux/ppc?
>
> I've given up on this - the build tools included in the source package are
> binary only (Intel or Sparc), no sources so far as I can see, and the
> stuff in config_office has a number of hardcoded assumptions that make
> life miserable (gcc version == 2.95.2, jdk 1.2.2 which requires glibc
> 2.1.3, Linux only exists on Intel and Sparc, ...). Basically, it sucks.
                              ^^^^^^^^^^^^^^^
Look at the bright side: at least the code should be endianness and 64-bit
clean :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
