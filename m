Date: Tue, 9 Apr 2002 10:14:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC BK repository <linuxppc@helium.Harhan.ORG>,
	linuxppc-commit@source.mvista.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
In-Reply-To: <20020408184019.9367@smtp.wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0204091013120.13709-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Benjamin Herrenschmidt wrote:
> >Won't that still lead to an:
> >#ifdef CONFIG_x
> > ... set thingsup for CONFIG_X since this will only exist on CONFIG_x...
> >#endif
> >
> >Or am I missing something?
>
> Yes, though it will be separated from the actual code, and I'm
> thinking about eventually auto-generating it.

Or put the pointers to the ppc_md structs in a new section, cfr. the
module_init() stuff.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
