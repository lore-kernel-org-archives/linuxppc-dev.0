Date: Sat, 6 May 2000 14:18:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-fbdev@vuser.vu.union.edu,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver
In-Reply-To: <200005060603.PAA08017@mail.cc.tohoku.ac.jp>
Message-ID: <Pine.LNX.4.10.10005061413570.406-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 6 May 2000, Kazunori Aoshima wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> on " Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver "
> date: Fri, 5 May 2000 13:38:26 +0200 (CEST) >>>
>
> > On Fri, 5 May 2000, Jeff Garzik wrote:
> > > updates my cirrus logic fbdev driver with a few cleanups, fix 0xA0000
> > > bug (note to alan), module and PCI cleanups, ...
> >
> > Since clgen_of_init() is exactly the same as clgenfb_init(), and since clgenfb
> > uses PCI resource management, can't we simply get rid of the OF specific stuff
> > in clgenfb?
> >
> > Can someone please test this by disabling Offb (CONFIG_FB_OF=n) and seeing
> > whether everything still works fine? Thanks!
>
> I would like to test it on my PowerStack.
>
> The test need to test two things.
>
> 1. Add clgenfb (Version? I have 1.9.4.4 .) patch on newest
>    kernel 2.3.99.7.5 .

You best use clgenfb from 2.3.99-pre7-6, I think.

> 2. CONFIG_FB_OF=n and CONFIG_FB_CLGEN=y needs on the config file.

Yes, that should do it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
