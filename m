Date: Wed, 18 Apr 2001 18:36:05 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
Cc: Cort Dougan <cort@fsmlabs.com>, linuxppc-commit@fsmlabs.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: CPU features again
In-Reply-To: <20010418160328.15973@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Apr 2001, Benjamin Herrenschmidt wrote:
> Those feature bits have to be common accross the entire PPC range (and
> possibly common with ppc64 too since ppc64 is supposed to run ppc32
> binaries, except that ppc64 has 32 more bits to stuff it's own features
> for 64 bits binaries).

BTW, we don't take the sparc64/mips64 approach and create arch/ppc64/?
Sparc64/mips64 run 32-bit binaries as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
