Date: Mon, 2 Oct 2000 16:59:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <20001001224427.A18368@suse.de>
Message-ID: <Pine.LNX.4.10.10010021658320.1581-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 1 Oct 2000, Olaf Hering wrote:
> while we are about to improve the atyfb, is it possible to fix the color
> depth switching?
> When I boot without a kernel arg I end up with 8 bit at console. I can't
> increase the color depth afterwards with fbset, and mol crashes when it
> tries to do that. When I specify atyfb:cmode:24 everythings works fine
> and I can switch down to 8 and back to 24 and mol starts fine.

Does it also crash when you increase the color depth with fbset?

I don't use MOL (I don't have MacOS), but I never saw this problem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
