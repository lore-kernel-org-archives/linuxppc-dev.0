From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>,
	Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
Date: Wed, 7 Mar 2001 00:08:46 +0100
Message-Id: <20010306230846.595@mailhost.mipsys.com>
In-Reply-To: <200103062210.XAA00895@piglet.grunz.lu>
References: <200103062210.XAA00895@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The probelm with the USB card is related to it getting IRQ1. Something
>is fishy with assigning PCI interrupts (still or once again, I don't
>know...)

Right, we may be beeting the infamous IRQ-behind-a-PCI<->PCI bridge problem.

I guess we don't properly walk up the tree to get the interrupt and the card
may have a PCI<->PCI bridge on it.


Stefan: Could you try disabling the driver for the card in the kernel, and
sending me the output of lsprop for your entire device tree ?

lsprop can usually be found on paulus site, just in case, I'll email it to
you separately.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
