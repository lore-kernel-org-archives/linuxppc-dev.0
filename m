Date: Sun, 15 Oct 2000 13:38:35 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <19340908105038.32516@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10010151338250.574-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 14 Oct 2000, Benjamin Herrenschmidt wrote:
> >Here are my fixes for aty128fb, atyfb, platinumfb, and tdfxfb.
> >
> >Igafb is not affected since it sets disp during initialization only.
> >
> >Can someone please test these patches so I can send them to Linus? I'm unable
> >to test any of them (besides a simple compile test). Thanks!
>
> While we are at it, I beleive we should also change atyfb.c so that
> currcon is no longer a global. My understanding is that can break multihead.
>
> Any objection ?

No.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
