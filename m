Mime-Version: 1.0
Message-Id: <v04220801b64a66c6a467@[10.0.0.42]>
In-Reply-To: 
 <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseldorf.de
 >
References: 
 <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseldorf.de
 >
Date: Wed, 29 Nov 2000 00:15:59 -0800
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Stefan Jeglinski <jeglin@4pi.com>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: usb wheel mouse, XF4.0
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:39 PM +0100 11/28/00, Michael Schmitz wrote:
>>  ... not that there isn't a simple trick, and not that I've exhausted
>>  all my possibilities yet, but my level of exasperation is rather high
>>  at the moment... so far I'm chalking it up mostly to usb still being
>>  not really built into the stable kernel.
>
>Wrong: support for USB PCI cards not being built into the stable kernel.
>Support for recent Mac builtin USB controllers (OHCI) is just fine.

Wrong.  PCI USB cards are exactly the same thing as built-in
controllers, because the built-in controllers are PCI devices too.

The OHCI driver should support literally any standards compliant OHCI
USB controller found on PCI, whether it's integrated into a
multifunction IO chip or on a card.  If it doesn't work, there's a
bug somewhere, either in the hardware (in which case it probably
doesn't comply to the standard) or in the driver (most likely
initialization related).

The same principle applies to UHCI.  UHCI could work on PPC, but
nobody has ever bothered, because the installed base of UHCI
controllers on PPC boxes approximates zero.  Apple's built-in USB is
always OHCI, and their MacOS drivers only support OHCI, so anybody
who wants to market a PCI USB card for Macs uses a OHCI chip to take
advantage of the drivers written by Apple.

x86 boxes can use either type of controller.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
