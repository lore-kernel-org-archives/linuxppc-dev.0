Date: Mon, 27 Mar 2000 22:03:01 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Lanners <mlan@cpu.lu>
cc: geert@linux-m68k.org, paubert@iram.es, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <200003271858.UAA01181@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10003272201540.2447-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > pci_assign_resource() is duplicated (sort of) in drivers/pci/setup-res.c
> > where the correct PCIBIOS_MIN_* limits are applied. That function calls
> > pcibios_update_resource() to do the actual bit twiddling. Is 2.3.48 too
> > dated for your patch to apply?
>
> Yeah; you might consider moving to 2.3.99.... pci_assign_resource() is
> gone from arch/ppc/kernel/pci.c.

Wasn't 2.3.99 the one with broken IDE interface as someone reported here?
I can do without that sort of fun, thank you :-) I'll move back to 2.2.15
now.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
