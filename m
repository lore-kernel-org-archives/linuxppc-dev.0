Date: Thu, 5 Feb 2004 08:46:35 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100 PCI Adapter
Message-ID: <20040205144635.GA5984@permusion.kilzer.net>
References: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de> <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be> <40132070.4080704@pobox.com> <1074995318.835.129.camel@gaston> <20040202054938.GA1814@permusion.kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040202054938.GA1814@permusion.kilzer.net>
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 01, 2004 at 11:49:38PM -0600, David D. Kilzer wrote:

> Finally, it may be possible to replace the new
> needs_mac_addr_byte_swapped() function with a check of the PCI vendor
> and device IDs, assuming all tulip ethernet cards using the LC82C168
> chipset have this same problem (and the same PCI IDs):
>
> 	if (pdev->vendor == PCI_VENDOR_ID_LITEON
> 		&& pdev->device == PCI_DEVICE_ID_LITEON_LNE100TX)
>  		for (i = 0; i < 6; i+=2) {
> 			...
> 		}

FWIW, I've ordered both a Kingston KNE100TX and a Netgear FA310TX card
to do some testing on.  I should have results in a week or so, depending
on how fast they're shipped from the eBay sellers.

Netgear 10/100 Network Card - NO SHIPPING!
http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&category=58299&item=3075759665

Kingston KNE100TX 10/100 Ethernet Card
http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&category=20319&item=3074775351

Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
