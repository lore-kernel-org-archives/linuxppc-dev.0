Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
	PCI Adapter
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	"David D. Kilzer" <ddkilzer@kilzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40132070.4080704@pobox.com>
References: 
	 <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de>
	 <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
	 <40132070.4080704@pobox.com>
Content-Type: text/plain
Message-Id: <1074995318.835.129.camel@gaston>
Mime-Version: 1.0
Date: Sun, 25 Jan 2004 12:48:38 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-25 at 12:48, Jeff Garzik wrote:
> Geert Uytterhoeven wrote:
> > On Tue, 23 Dec 2003, Michael Schmitz wrote:
> >>I'm not sure - the card having an OF driver might mean it's a Mac card,
> >>needing byte swapping, whereas a card with no OF driver would be a PC
> >>card, needing no byte swap. Or vice versa. Asante probably never built PC
> >>specific ethernet cards so the PCI vendor/device property could be used
> >>instead of OF data. OF data is just easier to get at :-)
> >
> >
> > Really? I'd say it's easier to look at the struct pci_dev the Tulip driver
> > already looks at. Besides, someone may want to try that card in a non-PowerMac,
> > while still having the correct MAC address.
>
>
> Agreed.

Provided the card has a unique device ID... but yes, in this case,
it's the best solution.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
