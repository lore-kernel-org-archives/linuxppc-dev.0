Date: Thu, 27 Jul 2000 14:13:17 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Steffen Haeuser <SteffenH@hyperion-software.de>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: sound again [was: Re: xf4 bug report]
In-Reply-To: <yam8242.267.146573120@mail.lf-online.de>
Message-ID: <Pine.LNX.4.10.10007271409430.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Jul 2000, Steffen Haeuser wrote:
> Am 26-Jul-00 schrieb Michael Schmitz:
> >Right. The very people that first brought Linux to the m68k Mac might feel
> >upset. One was a well known ix86 kernel hacker, the other a m68k hacker
> >from the Atari/Amiga camp.
>
> There is no Atari/Amiga camp... actually Amiga and Atari people cannot stand
> each other... :) Mac... yes... but Atari... no... :)

That was how it was before Commodore and Atari died. We've been united since
Linux/m68k exists :-)

> >> Would be only a 68k Kernel then though and not use the PowerPC Board in
> case
> >> of the Amiga...
>
> >Right, but can you compile a kernel that will run on PowerMac/CHRP/PReP
> >and APUS? Which one's serial will work?
>
> The Linux for Amiga PowerPC Boards uses the APUS stuff. Only difference is
> a special bootloader.

You cannot compile a kernel that works on all of the above due to memory
mappings. Either compile for PowerMac/CHRP/PReP, or for APUS. Anyway, the
Amiga serial driver is a sane driver that won't be activated on anything but
an Amiga.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
