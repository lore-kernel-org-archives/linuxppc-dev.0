Date: Fri, 28 Jun 2002 17:17:24 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Allen <gallen@arlut.utexas.edu>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_BLOCK_DEV_RAM in linuxppc_2_4_devel
In-Reply-To: <p05111b02b9422ba7534a@[10.8.16.89]>
Message-ID: <Pine.GSO.4.21.0206281716390.14426-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 Jun 2002, Greg Allen wrote:
> I just did a bk pull on my modified linuxppc_2_4_devel tree, and it
> no longer compiles.
>
> snippit from init/do_mounts.c, line 381
>
>     #if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
>     static void __init change_floppy(char *fmt, ...)
>     {
>
>
> The linker complains that this function should be present.
>
> I have CONFIG_BLK_DEV_RAM turned on, and no floppy. I can't find any
> other reference to CONFIG_BLOCK_DEV_RAM.
>
> Is this simply a typo that never got tested without CONFIG_BLK_DEV_FD
> turned off?

Must be CONFIG_BLK_DEV_RAM.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
