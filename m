Message-Id: <200006212147.XAA01021@piglet.grunz.lu>
Date: Wed, 21 Jun 2000 23:47:01 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Proposal: non-PC ISA bus support
To: bh40@calva.net
cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@lists.linuxppc.org,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <20000620122329.13473@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  20 Jun, this message from Benjamin Herrenschmidt echoed through cyberspace:
> We still can decide (and that's what I currently do in the kernel) that
> IO space is only supported on one of those 3 busses (the one on which the
> external PCI is). This prevents however use of IOs on the AGP slot,

... and multiple host bridges, like on the 9x00 (bad, two separate buses
    à 3 slots) and 7x00/8x00 (no problem, second (fixed, video
    subsys) bus doesn't have IO devices).

struct pci_dev has void *sysdata. Can we use that for something
reasonable here? Like additional info (iobase per device, set by fixup
code)?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
