Message-ID: <39072FDB.18C989EC@embeddededge.com>
Date: Wed, 26 Apr 2000 14:05:15 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MultiPPC - was: memory map
References: <Pine.BSF.4.10.10004260915061.60450-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:

> Mostly I was playing with the Linux PDA idea, wich requires a
> system-on-a-chip core. A 8260 with PCI (and probabely also CardBus32
> PCI extensions or else use a TI bridge) Ethernet, FireWire and USB
> implemented in microcode would defenitely do the trick. Add a 1/4
> VGA LCD and one set of five keys to each side of the box (making up
> a stenography keyboard) and we have a excellent, streamlined PDA.

I know of a company that is building such a thing without a PCI......

> But even if I had to throw a low power 8240 into the mix it would

I don't know if there is a "low power" 8240, at least based upon
the heat sink they put on the things :-).

> Then perhaps I should wait it out on the nearest fence?
> Like the 8260 PCI interface?

I have mixed feelings about using PCI with the 8260.  Yes, I have
seen some designs where that was appropriate, but all to often PCI
is used as (an expensive) crutch to get some I/O that is more than
possible and more efficient within the programmability of the
processor and CPM.  It's like the designers were sold on the features,
then decided it was easier to plunk down hardware rather than learn
something new.


> If 12 MBit/s USB could not be implemented in microcode on
> a 20 MBit/s 8xx SCC port,

But it is implemented and it works......It takes a small microcode
patch (that I just happen to have here in my back pocket) for efficient
host mode, but the original design was only for a function end point.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
