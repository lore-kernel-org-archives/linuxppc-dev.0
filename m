Message-Id: <200009211743.TAA00736@piglet.grunz.lu>
Date: Thu, 21 Sep 2000 19:42:58 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: dual G4 time issues..
To: haworth@ncal.verio.com
cc: bh40@calva.net, hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39C822D7.93126A84@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Sep, this message from Henry Worth echoed through cyberspace:
> I'll look into getting a serial port on this machine so I can
> try some debugging. Any recommendations what sort of PCI I/O
> card would work best, or would one of those gadgets that
> replaces the modem be a better bet?

Go for the modem-replacement-thing, if you don't need the modem. That
will give aou a standard Mac-style serial port, supported
out-of-the-box.

On the other hand, PCI serial boards are supported as of very recently,
and I'm not sure whether/if that suport has found it's way into current
PPC kernels.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
