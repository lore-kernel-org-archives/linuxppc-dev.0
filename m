Date: Tue, 23 Dec 2003 09:06:25 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100 PCI Adapter
Message-ID: <20031223150625.GB11197@kilzer.net>
References: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de> <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 23, 2003 at 03:01:49PM +0100, Geert Uytterhoeven wrote:
> On Tue, 23 Dec 2003, Michael Schmitz wrote:
> > I'm not sure - the card having an OF driver might mean it's a Mac card,
> > needing byte swapping, whereas a card with no OF driver would be a PC
> > card, needing no byte swap. Or vice versa. Asante probably never built PC
> > specific ethernet cards so the PCI vendor/device property could be used
> > instead of OF data. OF data is just easier to get at :-)
>
> Really? I'd say it's easier to look at the struct pci_dev the Tulip driver
> already looks at. Besides, someone may want to try that card in a
> non-PowerMac, while still having the correct MAC address.

The card is currently in a PowerMac 7200/75 running Debian 3.0 with a
Linux 2.2 kernel.  (It's my firewall. :)

I do have an x86 PC (also running Debian 3.0 but with a 2.4 kernel) that
I could test it on, although this is somewhat inconvenient since I'll be
off the Internet while I'm doing the testing.

BTW, the almighty original box that the ethernet card came in says, "For
PCI-bus PC or Macintosh computers", so it should work in both, in
theory.  I also have original PC and Mac driver disks and the original
documentation in PDF format if that's helpful.

Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
