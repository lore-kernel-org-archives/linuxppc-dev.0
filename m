Date: Wed, 18 Oct 2000 13:25:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <Pine.LNX.4.21.0010181110280.24224-100000@ipnpcu5>
Message-ID: <Pine.LNX.4.10.10010181319270.841-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Oct 2000, Xavier Grave wrote:
> I have the following message at boot :
>
> Freeing unused kernel memory: 220k init 12k pmac 4k chrp 4k openfirmware
> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init= option to kernel.
> Rebooting in 180 seconds..
>
> if I give this argument init=/sbin/init it's the same.
>
> Also hen I try to enable virtual terminual I have the following very early:
>
> TCP: Hash tables configured (established 4096 bind 4096)
> Starting kswapd v1.8
> pc_keyb: controller jammed (0xFF).
> pc_keyb: controller jammed (0xFF).
> and so on...
>
> Thanks in advance for anyhelp.
>
> xavier
> configuration: CPU 603e + Prep Board

What does /dev/console look like?

Did you enable any device that can provide a console functionality, like e.g.
CONFIG_VT, CONFIG_SERIAL_CONSOLE?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
