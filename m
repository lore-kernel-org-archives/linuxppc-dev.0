Date: Sun, 5 Mar 2000 22:34:38 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI I/O address problems on B&W G3
In-Reply-To: <v04220801b4e6adfba6f6@[10.0.0.42]>
Message-ID: <Pine.LNX.4.05.10003052234231.14296-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 4 Mar 2000, Timothy A. Seufert wrote:
> At 11:16 AM +0100 3/4/00, Michel Lanners wrote:
> >>  So it would seem to me that we need some kind of a scheme for
> >>  allocating I/O port base addresses if OF didn't do it.  I'm vaguely
> >>  familiar with the concepts behind PCI address space allocation,
> >>  having looked at it from the hardware design POV a while back, but
> >>  I'm not familiar enough with the kernel code yet to tackle this
> >>  problem (or to even be sure that I'm on the right track here).
> >
> >That should be handled by the new, 2.3 PCI code with dynamic resurce
> >allocation. I've just discovered that part, however, and am not at all
> >familiar with it. I'm RTFS'ing...
>
> Another piece of code to look at might be the Alpha arch PCI code in
> 2.2.  From what I can tell it is doing complete configuration of PCI
> by itself (apparently the firmware on Alpha boards doesn't do any PCI
> config).

Or the code in drivers/pci in current 2.3.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
