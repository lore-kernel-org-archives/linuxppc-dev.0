Date: Fri, 26 Jan 2001 10:18:21 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New Apple PCI IDs
In-Reply-To: <Pine.LNX.4.05.10101260953120.497-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10101261017500.497-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 26 Jan 2001, Geert Uytterhoeven wrote:
> >From looking at people's lspci output and at include/linux/pci_ids.h, I created
> this list:
>
>     106b  0018  UniNorth FireWire
>     106b  0019  KeyLargo USB
>     106b  001e  UniNorth PCI
>     106b  001f  UniNorth PCI
>     106b  0020  UniNorth AGP
>     106b  0021  UniNorth GMAC
>     106b  0022  Mac I/O???
>
> Are these correct?
> Is there a difference between the two PCI busses (33/66 MHz? 32/64 bit?)
> Where's the Mac I/O? In UniNorth or in KeyLargo?

Some more kernel source reading convinced me that Mac I/O is indeed in
KeyLargo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
