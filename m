Message-ID: <387B526B.C0A9E32F@switchboard.ericsson.se>
Date: Tue, 11 Jan 2000 16:55:23 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xxrom wierdness
References: <0FO6005190KNBJ@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hello all,

> Hi Mika
> 
> How did your mkrombin work on the zImage. Here it always failed ....
> 
> Therefore I bought an ATA Flash disk.
> I copied the zImage to the flash disk and plugged it into the board.
> 
> My problem is that the board doesn't recognise the Flash disk.
> 
> First it says that 'pcmcia: card not present'
> Then It prints an error message like: "Boot device list: Card not ready, 0xf0"
> and exits with an 'Software emulation interrupt'

Ok, this is it:

depending on what kind of processor you are using
the fads board use different slots:

860 SLOT_A
823 SLOT_B

The pcmcia code in the 8xxrom 0.3.0 is pretty screwed.
Things did not work out of the box with for my ADS860.

I've done some hacking and things are back where they were
on my ADS860 and SLOT_A and SLOT_B configuration option is added
and some nice pcmcia code is created...

Things are not really finished yet...

I can send my hacked work to anyone who wants it.
If no one wants to deal with it will I fix it later.

Cheers and good luck! /

magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
