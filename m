Date: Mon, 19 Jan 2004 11:08:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
In-Reply-To: <1074503490.4547.52.camel@gaston>
Message-ID: <Pine.GSO.4.58.0401191108100.6038@waterleaf.sonytel.be>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jan 2004, Benjamin Herrenschmidt wrote:
> > I am returning 0 for all of function 0. I dropped the whole struct
> > pci_dev ressource thingy, and they are well nullified. My limited
> > understanding of those pci issues let me make a guess though. I think
> > that either the stuff in the struct pci_dev is set later on (the BARs
> > are modifiable i think), or those values are read from the struct
> > pci_dev before i nullify them.
>
> pci_dev resources are read from the BARs and the sizing mecanism
> uses the BARs too (you should filter out writes too btw). If you
> properly filter things out, there should be no problem.

So shouldn't reads from the BAR return -1 instead of 0, and writes be ignored?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
