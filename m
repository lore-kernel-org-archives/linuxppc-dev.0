Date: Wed, 29 Nov 2000 10:30:47 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Stefan Jeglinski <jeglin@4pi.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: usb wheel mouse, XF4.0
In-Reply-To: <v04220801b64a66c6a467@[10.0.0.42]>
Message-ID: <Pine.LNX.4.10.10011291029180.4900-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Wrong: support for USB PCI cards not being built into the stable kernel.
> >Support for recent Mac builtin USB controllers (OHCI) is just fine.
>
> Wrong.  PCI USB cards are exactly the same thing as built-in
> controllers, because the built-in controllers are PCI devices too.

Thanks for the clarification. Are there known issues with IRQ sharing on
PPC, or would the missing interrupt rather be a PCI-PCI bridge
initialization problem?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
