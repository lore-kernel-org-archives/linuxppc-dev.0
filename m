Date: Sat, 26 Jan 2002 18:27:16 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Broken asm/div64.h macro
In-Reply-To: <20020126103720.Z14725@altus.drgw.net>
Message-ID: <Pine.GSO.4.21.0201261825430.742-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Jan 2002, Troy Benjegerdes wrote:
> Our div64.h macro is quite broken, and causes printk to not be able to do
> a long long format.
>
> Is there a 'fast' generic C algorithm we can replace it with, instead of
> mucking with ASM?

Usually you can copy the asm version from the gcc sources (libgcc).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
