Date: Thu, 11 Apr 2002 17:49:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <0204111540.AA28629@ivan.Harhan.ORG>
Message-ID: <Pine.GSO.4.21.0204111748320.27554-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Apr 2002, Michael Sokolov wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Let's do it first in 2.5, we can backport it once we are satisfied
>
> Bleah. 2.5 == never to me. It doesn't help me with my goal of getting support
> for my boards in 2.4. I work on stable kernels and not development ones because
> I'm not a Linux developer, I'm just a HW engineer trying to make Linux
> (existing stable one) support my boards at least as well as it does those from
> my competitors (IBM, Sun, etc).
>
> I guess I'll just have to convince Debian to make a package from
> linuxppc_2_4_alt to support HEC PPCStar machines and show all these exchanges
> as evidence that the PPC MAINTAINERS are not intent on allowing new machine
> support into 2.4 any time soon.

Please note that most probably Marcelo won't accept new machine support into
2.4.x neither, unless it's a backport of 2.5.x and it has proven to be stable.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
