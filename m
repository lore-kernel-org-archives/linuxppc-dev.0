Date: Wed, 1 Dec 1999 18:23:22 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Grant Erickson <grant@lcse.umn.edu>
cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Ethernet Drivers for LAN/Controller-on-Board Systems
In-Reply-To: <Pine.SGI.4.10.9911301438280.118603-100000@brule.borg.umn.edu>
Message-ID: <Pine.LNX.4.05.9912011822180.389-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Nov 1999, Grant Erickson wrote:
> Anyway, I'm working on a port for the IBM "Oak" 403GCX board. This board
> has on it, a National DP83902AV Ethernet MAC. The chip is more or less
> directly attached to the 403GCX's address/data buses and resides at the
> base physical address 0xF4000000.
> 
> How are such Ethernet controllers accommodated by the kernel? It seems as
> though I cannot just use 8390.o directly as it is but a library used by
> drivers such as ne2k.o. However, I don't think I can or want to use a
> driver such as ne2k.o as this isn't a PCI or an ISA card-type controller
> either.
> 
> Do I need to write a small upper-layer wrapper driver, such as oak_8390.c,
> for this?

Yes, you have to write glue code between your hardware and 8390.o. Look at the
other 8390 glue codes for examples.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
