Message-Id: <200012190700.IAA00759@piglet.grunz.lu>
Date: Tue, 19 Dec 2000 08:00:23 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI-to-parallel port problem
To: berke@kis.uni-freiburg.de
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3A3E417E.A5B259C2@kis.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  18 Dec, this message from Thomas Berkefeld echoed through cyberspace:
> I have FASTPCI 4008 PCI parallel port card from Dolphin Peripherals. To
> use the card,
> the manual tells to modprobe parport_pc.o with io-address and irq.
> Unfortunatley
> parport_pc.c cannot be compiled with
> kernel 2.4.0-test11 on my G4 Mac  (a header is missing).
> Furthermore /proc/pci says the interrupt number is 53 which seems a bit
> high.

Depends. PowerMacs have at least 32 interrupts, but some have more.
Anybody know for sure on the G4?

> This is what /proc/pci says about the card:
> Bus  2, device   3, function  0:
>     Parallel controller: PCI device 1409:7268 (Timedia Technology Co
> Ltd) (rev 1).
>       IRQ 53.
>       I/O at 0x1010 [0x1017].
>       I/O at 0x1000 [0x1007].

There is potential for breakage with the IO ports. Don't know what the
state is in the current 2.2.18 kernel; just give it a try once you get
parport to compile. You might then also try the current PPC 2.4 kernels;
they have some PCI code to avoid the IO port problems.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
