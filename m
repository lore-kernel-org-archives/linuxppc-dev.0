Date: Tue, 28 Nov 2000 20:39:59 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Stefan Jeglinski <jeglin@4pi.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: usb wheel mouse, XF4.0
In-Reply-To: <p04330108b649b743e634@[206.6.156.5]>
Message-ID: <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> ... not that there isn't a simple trick, and not that I've exhausted
> all my possibilities yet, but my level of exasperation is rather high
> at the moment... so far I'm chalking it up mostly to usb still being
> not really built into the stable kernel.

Wrong: support for USB PCI cards not being built into the stable kernel.
Support for recent Mac builtin USB controllers (OHCI) is just fine.
Support for anything above the controller (protocols) apparently works
fine with OHCI (PPC) and UHCI (Intel).

What exactly is on the PCI USB card?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
