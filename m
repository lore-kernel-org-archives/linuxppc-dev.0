Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
	PCI Adapter
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Jeff Garzik <jgarzik@pobox.com>, tulip-devel@lists.sourceforge.net,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031223131553.GA21005@permusion.kilzer.net>
References: 
	 <Pine.LNX.4.44.0312221520490.10152-100000@opal.biophys.uni-duesseldorf.de>
	 <1072137958.705.9.camel@gaston>
	 <20031223131553.GA21005@permusion.kilzer.net>
Content-Type: text/plain
Message-Id: <1072186011.738.2.camel@gaston>
Mime-Version: 1.0
Date: Wed, 24 Dec 2003 00:26:51 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Please forgive my ignorance, but how do I tell if the card has an OF
> driver?  Running "ofpath /dev/eth1" doesn't reveal anything, although
> looking at the source for "ofpath" shows me that it doesn't handle
> ethernet devices.  I don't see anything under /proc/device-tree/ that
> would map to the Asante ethernet card, either.
>
> The card does show up in "lspci" and /proc/pci (obviously).  Would
> checking for the PCI vendor/device and subvendor/subdevice be
> equivalent to checking for the OF name property?

Not really.

Send me a tarball of /proc/device-tree with the card in along with
lspci -v & lspci -n outputs

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
