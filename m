Date: Fri, 5 May 2000 13:38:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-fbdev@vuser.vu.union.edu,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver
In-Reply-To: <391270BD.A170EC15@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10005051335010.428-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 5 May 2000, Jeff Garzik wrote:
> updates my cirrus logic fbdev driver with a few cleanups, fix 0xA0000
> bug (note to alan), module and PCI cleanups, ...

Since clgen_of_init() is exactly the same as clgenfb_init(), and since clgenfb
uses PCI resource management, can't we simply get rid of the OF specific stuff
in clgenfb?

Can someone please test this by disabling Offb (CONFIG_FB_OF=n) and seeing
whether everything still works fine? Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
