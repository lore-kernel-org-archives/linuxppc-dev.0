Mime-Version: 1.0
Message-Id: <a04310102b8e0f5b3d245@[199.170.89.81]>
In-Reply-To: <E16xBvj-000073-00@piglet.grunz.lu>
References: <E16xBvj-000073-00@piglet.grunz.lu>
Date: Mon, 15 Apr 2002 16:30:58 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Jeff Walther <trag@io.com>
Subject: Re: 9600 maturity?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 21:14 +0200 04/15/2002, Michel Lanners wrote:

>To take into account here: bootability. If you need a bootable
>additional controler, than that limits your choices. Promise' are not
>bootable; but there apparently is a MacOS version from some OEM that has
>an OF ROM instead of the PC BIOS ROM. Don't know if it's
>Linux-supported, though.

The name of the card is the VST UltraTech/66.  I don't know if it is
Linux-supported either.  OWC has it for about $50 and there is a
firmware update from OWC that adds OSX support in case that is
relevant for Linux.

The VST card is the Promise card with a few resistors moved and
different firmware installed and the 66 MHz oscillator removed.

I don't believe it contains a PPB instantiated in the single IC on
the board.  However, it triggers the PPB hierarchy problem in
PowerSurge machines with almost exactly the same symptoms as a PCI
card with an on-board PPB.   I don't know if it's possible that the
Mac firmware for the card somehow makes it look enough like a PPB
bearing card to trigger the OF bug, but that is my current guess.
Anyway, this card won't work in the lower slots of the Umax S900 if
there is another PCI card present in the lower four slots which has
on-board firmware--with a couple of exceptions.

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
