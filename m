Date: Sun, 4 Jun 2000 13:11:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fbcon-cfb8.c
In-Reply-To: <Pine.OSF.4.02.10006041259490.6900-100000@ax1305.physik.uni-marburg.de>
Message-ID: <Pine.LNX.4.05.10006041310010.514-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 4 Jun 2000, Henning Loeser wrote:
> trying to fix my console character displayment I wonder whether I'm
> looking at the right place ?????
> When in the console with 8bpp, fbcon-cfb8.c is the driver the kernel uses
> right? Not the tdfxfb driver for the card?

Tdxfb is accelerated. So unless you disable acceleration, it uses the
operations in fbcon_banshee8 in tdxfb.c:

    info->dispsw = noaccel ? fbcon_cfb8 : fbcon_banshee8

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
