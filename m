Date: Fri, 21 Sep 2001 09:24:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@mvista.com>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	Mark Salisbury <mbs@mc.com>,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
In-Reply-To: <3BAAB9E7.16F9ED2D@mvista.com>
Message-ID: <Pine.GSO.4.21.0109210922040.3006-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Sep 2001, Dan Malek wrote:
> "Timothy A. Seufert" wrote:
> > Finally, Book E has been mentioned.
>
> Too bad.....
>
> > ... a TLB entry bit (bit 'E' for endian) which marks a page as
> > little endian.
>
> This has been discussed in the past and suffers from the same
> problem as trying to byte swap in a bridge.  Although you can use
> any load/store in this space, unless you are performing the access
> on the natural size of the object it won't have the proper effect.
> Since you must require that knowledge, it is just as easy to choose
> the proper byte swapping variant of the instruction.

Anyone who knows how this differs from the similar bit on UltraSPARC?

> I guess I better go looking for those m68k projects now :-).

Good! We can use some help to keep the old platforms alive... AFAIK the
working platform support decreased to Amiga, Q40, Sun3[x], and Mac in 2.4.x...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
