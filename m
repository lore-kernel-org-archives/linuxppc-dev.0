Date: Fri, 2 Jan 2004 19:34:16 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
In-Reply-To: <20040102074049.GA2032@iliana>
Message-ID: <Pine.GSO.4.58.0401021933100.3062@waterleaf.sonytel.be>
References: <20040101181145.GA27294@iliana> <1073016223.1502.179.camel@gaston>
 <20040102074049.GA2032@iliana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Jan 2004, Sven Luther wrote:
> Happy new year to you.

Happy New Year!

> On Fri, Jan 02, 2004 at 03:03:43PM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2004-01-02 at 05:11, Sven Luther wrote:
> > > I am currently trying to port linux to the Pegasos 2, which
> > > uses the Marvell Discovery 2 chip, and has two independent pci
> > > controllers, of which one is faked as an agp bus. This is with a
> > > modified 2.4.23 kernel from the linuxppc_2_4 branch.
> >
> > Why "faked" ? It's actually fairly sane to have the AGP bus be a
> > separate PCI host controller... That's how it's done on pmacs.
>
> There is some extra magic that needs to be done. In particular
> interrupts need to be disabled before being able to write to the
> config space of the agp bridge.

I seem to remember the upper layer already takes care of disabling interrupts?
Or am I mistaken?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
