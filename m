Message-Id: <200012030744.IAA00755@piglet.grunz.lu>
Date: Sun, 3 Dec 2000 08:44:50 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 3COM 3c905c-TX-M.... works, or not?
To: jingai@shell.faradic.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200012030028.eB30SHR04153@shell.faradic.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   2 Dec, this message from Jonathan Lane echoed through cyberspace:
> A 'cat /proc/interrupts' shows that there have
> been no interrupts serviced for the card:
>
>            CPU0
>   1:          0   PMAC-PIC      eth1

Hmmm, IRQ 1? Weird for a PCI device....

>  20:          0   PMAC-PIC      NMI - XMON
>  24:       9202   PMAC-PIC      usb-ohci

I suppose your USB is on a PCI card in a PCI slot? I'd expect the other
PCI slot's interrupts to be next to this one, then.

> eth1: 3Com 3c905C Tornado at 0x1000,  00:01:02:c1:88:c2, IRQ 1

Everything OK, except IRQ1...

> eth1: transmit timed out, tx_status 00 status e601.
> eth1: Interrupt posted but not delivered -- IRQ blocked by another device?

Yes, IRQ problem.... Could you send a complete lspci -vv along, together
with lspci -bvv (bus view)?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
