Message-ID: <38C8EAF5.BC64259A@mpifr-bonn.mpg.de>
Date: Fri, 10 Mar 2000 13:30:45 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: CardBus Bridge IRQ Problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all!

I am currently trying to get the CardBus Brigde in a Lombard PowerBook (TI
PCI1211) to work, but I have an evil problem with the interrupt line.  I started
with Ryuichi Oikawa's patch (see the web site
http://www.rr.iij4u.or.jp/~roikawa/others.html) and added the code for the
TI1211.  I am at the point where an IRQ (from a FireWire2Go CardBus card) is
recognised and serviced, but it seems as if at some point somewhere in the chain
the INTA line is not deasserted, because the interrupt service routine is
entered again and again, thus freezing the whole system.  Strange to say, all
"interrupt pending" bits both in the FireWire card and in the bridge are CLEARED
after the first call to the ISR (as it should be, of course).

Maybe one of the hardware gurus has an idea of what goes wrong here?  Is it
possible to get a dump of the TI1211's PCI register set from MacOS?

Thanks for any help, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
