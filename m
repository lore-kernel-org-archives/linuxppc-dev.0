Date: Wed, 7 Jan 2004 10:02:34 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
In-Reply-To: <1073425055.784.3.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401071000001.8608-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> note that there's still a problem with XFree which will "see"  those
> BARs and, according to the log posted by Sven, shoke. Sven, can you
> try "hiding" the host bridge completely from the config ops and see
> if that helps with XFree ? That's not a very good solution though,
> we'll have to do something different about it. Now if only XFree
> stopped mucking with the PCI bus...

Is this a problem with overlapping PCI resources again (thought that was
fixed in 2.4 anyway)? Resolving the overlap helped there. What does XFree
do, simply disable resources?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
