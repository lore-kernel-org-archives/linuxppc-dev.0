Date: Mon, 1 Oct 2001 10:09:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PowerStack interrupt?problem
In-Reply-To: <20010930115206.E776@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0110011006580.706-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Sep 2001, Tom Rini wrote:
> On Sun, Sep 30, 2001 at 01:23:46PM +0200, Geert Uytterhoeven wrote:
> > We're having interrupt problems with a Motorola PowerStack running 2.4.9 (from
> > MontaVista rsync).
>
> Goody, which? :)  I've got a 604/100 right here.

The one that looks like a HiFi, with 133 MHz 604.

> > Symptoms are:
> >   - We receive lots of PS/2 mouse interrupts (irq 12), a few hundreds or
> >     thousands for each mouse move
> >   - The number of BAD interrupts increases when moving the mouse, a few tens
> >     for each mouse move
> >   - Sometimes the machine locks up (no ping response) after heavy mouse
> >     movement
> >   - The PS/2 keyboard is fine
>
> Hmm.  I sort-of wonder if the PS/2 changes a while back goofed something up.
> My kbd is fine too, and I'll try and throw a mouse on later this week.
> Can you grab the bk version and go back to 2.4.8, .7, et al and see if
> it works?  I think some PS/2 stuff was done in maybe .5 or .6..

I cannot test that right now (I don't own the machine, it was sitting next to
me at the Oldenburg Linux/non-ia32 meeting), but the owner promised to join
the mailing list, so I hope he'll do.

Perhaps the problem is related to the PS/2 mouse problem on my LongTrail. I've
always used a serial mouse, because Linux locks up if I insert the PS/2 mouse
(while Linux is running).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
