Date: Tue, 29 Aug 2000 21:24:55 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm in OF?
In-Reply-To: <200008291737.TAA00677@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10008292122010.385-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Aug 2000, Michel Lanners wrote:
> Does anybody know how to embed machine code into an OF script (into
> nvramrc, that is)? I suppose OF doesn't have an assembler built-in, so
> machine code would be the only option.

I think it does, since e.g. `see rb@' tells me

| code rb@
| ff83b474     lbz     r28,0(r28)
| ff83b478     bcctr   always

But then I'm the one with the real Firmworks Open Firmware, and not some Apple
surrogate...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
