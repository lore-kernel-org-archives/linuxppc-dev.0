Message-ID: <40132070.4080704@pobox.com>
Date: Sat, 24 Jan 2004 20:48:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	"David D. Kilzer" <ddkilzer@kilzer.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
 PCI Adapter
References: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de> <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> On Tue, 23 Dec 2003, Michael Schmitz wrote:
>>I'm not sure - the card having an OF driver might mean it's a Mac card,
>>needing byte swapping, whereas a card with no OF driver would be a PC
>>card, needing no byte swap. Or vice versa. Asante probably never built PC
>>specific ethernet cards so the PCI vendor/device property could be used
>>instead of OF data. OF data is just easier to get at :-)
>
>
> Really? I'd say it's easier to look at the struct pci_dev the Tulip driver
> already looks at. Besides, someone may want to try that card in a non-PowerMac,
> while still having the correct MAC address.


Agreed.

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
