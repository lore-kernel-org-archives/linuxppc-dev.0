Message-Id: <200003271858.UAA01181@piglet.grunz.lu>
Date: Mon, 27 Mar 2000 20:58:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: geert@linux-m68k.org, paubert@iram.es, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10003271850230.1727-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Mar, this message from Michael Schmitz echoed through cyberspace:
> Anyway,
> this is what I found in arch/ppc/kernel/pci.c:
>
> int pci_assign_resource(struct pci_dev *dev, int i)
> {
[snip]
> 	}
>
> pci_assign_resource() is duplicated (sort of) in drivers/pci/setup-res.c
> where the correct PCIBIOS_MIN_* limits are applied. That function calls
> pcibios_update_resource() to do the actual bit twiddling. Is 2.3.48 too
> dated for your patch to apply?

Yeah; you might consider moving to 2.3.99.... pci_assign_resource() is
gone from arch/ppc/kernel/pci.c.

Have fun!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
