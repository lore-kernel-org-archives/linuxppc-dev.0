Date: Tue, 6 Mar 2001 08:25:41 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: "unhandled relocation type 18" ???
In-Reply-To: <20010305190926.8ED2E287EA@denx.denx.de>
Message-ID: <Pine.LNX.4.05.10103060824030.29713-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 5 Mar 2001, Wolfgang Denk wrote:
> when trying to "insmod" a  kernel  module  that  uses  floating-point
> functions  like  "sin", we get error messages:
>
> 	unhandled relocation type 18
>
> This is on a MPC8xx CPU with kernel 2.4.x, modutils-2.4.1; the module
> and all code linked with it was compiled with "-msoft-float".

Does it also complain about a missing symbol for `sin'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
