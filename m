Date: Tue, 27 Aug 2002 14:27:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Linux/PPC on APUS development <linux-apus-devel@lists.sourceforge.net>
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc-2.5
In-Reply-To: <20020827120046.DCE42FC70@hostme.bitkeeper.com>
Message-ID: <Pine.GSO.4.21.0208271406320.17719-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Aug 2002 ppc@bitkeeper.com wrote:
> ChangeSet
>   1.497.1.22 02/08/27 21:55:39 paulus@samba.org +2 -0
>   PPC32: remove code that sets kd_mksound now that it isn't a pointer.
>
>   This gets it to compile but leaves us without a keyboard beep on
>   powermac and APUS for now.
>
>   arch/ppc/platforms/pmac_setup.c
>     1.16.1.6 02/08/27 21:55:36 paulus@samba.org +0 -14
>     remove kd_mksound references
>
>   arch/ppc/amiga/config.c
>     1.12 02/08/27 21:55:36 paulus@samba.org +0 -4
>     remove kd_mksound references

APUS should use arch/ppc/amiga/amisound.c:amiga_mksound().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
