Date: Wed, 7 Jan 2004 11:27:39 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
In-Reply-To: <1073467436.5753.102.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401071048590.7754-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Is this a problem with overlapping PCI resources again (thought that was
> > fixed in 2.4 anyway)? Resolving the overlap helped there. What does XFree
> > do, simply disable resources?
>
> There should be no overlap.... Let me check the log ...
>
> (II) Host-to-PCI bridge:
> (II) Bus 16: bridge is at (0:0:0), (-1,16,0), BCTRL: 0x0008 (VGA_EN is
> set)
> (II) Bus 16 I/O range:
>         [0] -1  0       0x00000000 - 0x0000ffff (0x10000) IX[B]
> (II) Bus 16 non-prefetchable memory range:
>         [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
> (II) Bus 16 prefetchable memory range:
>         [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
>
> The problem is on the host bridge BARs again. I don't know what they

That's the weird (-1,busno,0)? My values are 0,busno,1 (plain old
gracke). The rest looks perfectly OK...

> are supposed to do, you need to look at the bridge spec, but you
> definitely need to hide them some way...

Thought I spotted something familiar, but this looks new.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
