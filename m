Message-Id: <200006110814.KAA00801@piglet.grunz.lu>
Date: Sun, 11 Jun 2000 10:14:27 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PATCH: ncr885e PPC patch look ok to you?
To: jgarzik@mandrakesoft.com
cc: cort@fsmlabs.com, paulus@linuxcare.com, dan@synergymicro.com,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <394306A3.3D4DFE85@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jeff,

Still cleaning up, I see?

On  10 Jun, this message from Jeff Garzik echoed through cyberspace:
> Does this patch, against 2.4.0-test1-ac13, look ok to you guys?

Looks good to my, AFAIKT. Only potential problem I see is the PCI IO
region access on PPC machines without ISA, where there has to be a
translation applied. But that will probably be only finally resolved in
2.5...

> NOTE:  Maybe a PPC kernel expert can tell me whether pci_enable_device
> on PPC actually enabled PIO/MMIO regions correctly?  If so, this patch
> can, in addition to the change above, also remove the "manual" setting
> of the PIO bit in PCI_COMMAND.

Not that I would call myself a kernel expert, but yes,
pci_enable_device() works correctly on PPC. So you can remove the manual
IO enable.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
