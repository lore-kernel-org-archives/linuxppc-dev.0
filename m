Date: Sun, 7 Apr 2002 10:34:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, msokolov@ivan.Harhan.ORG,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <20020406225236.3768@smtp.wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0204071026160.2567-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 6 Apr 2002, Benjamin Herrenschmidt wrote:
> I've looked at the patch in the meantime and it makes much sense. I want
> to do something around those lines:
>
>  - Completely rip off CONFIG_ALL_PPC in favor of CONFIG_GENERIC_PPC32
>  - Each board model has it's own CONFIG_xxx entry (like Michael patch),
>    which means adding "back" CONFIG_PMAC, CONFIG_CHRP, CONFIG_PREP, but
>    those will only control which set of .c file will get in the makefile
>    and the toplevel switch/case on platform_init. That is you will be able
>    to select an arbitrary set of boards.

Good, starts to look like m68k again, where you always were able to compile a
generic kernel (except for Sun-3 (not 3x) due to the different MMU)!
Now start moving platform specific files to arch/ppc/$platform/ again. Dan is
right, we're running in circles :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
