Date: Tue, 17 Oct 2000 15:45:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: paulus@linuxcare.com.au,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <19340911041320.23766@192.168.1.2>
Message-ID: <Pine.LNX.4.10.10010171543360.394-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Oct 2000, Benjamin Herrenschmidt wrote:
> >Could someone fill me in on why we need legacy I/O to the AGP bus?
>
> Some display cards (like voodoo) AFAIK, need us to tweak with the VGA IO
> registers. The interest in having something like ioportremap or similar
> is that we can have the platform specific code return a different base
> for VGA than other legacy devices, thus allowing us to have, for example,
> such a VGA card in the AGP slot and a legacy serial card in the PCI slots.
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Do these exist? I'm aware of legacy serial cards for ISA slots only.
AFAIK all PCI serial cards use PCI configuration and are handled separately by
serial.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
