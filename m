Date: Fri, 1 Sep 2000 22:13:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
In-Reply-To: <20000901161432.8125@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10009012212420.1349-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 1 Sep 2000, Benjamin Herrenschmidt wrote:
> >Without a real xf86 card with a bios present to play with, there is really no
> >way to try and devise a better test.  Even if a bios is present, wouldn't OF
> >still do the initialization?
>
> I don't think OF will do anything but assign base addresses.

And even that depends on the OF. Not all versions assign all base addresses
for `unrecognized' cards.

Let's hope the kernel will do soon :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
